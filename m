Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4AA6B4207BC
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:52:37 +0200 (CEST)
Received: by mail-wm1-f68.google.com with SMTP id f21so17546259wml.3
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:52:37 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214])
	by smtp.gmail.com with ESMTPSA id f7sm1340790wrx.64.2020.10.12.08.52.35
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:52:36 -0700 (PDT)
Resent-Message-ID: <20201012155234.GE2116@soda.linbit>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5DEB1420C6C
	for <drbd-dev@lists.linbit.com>; Fri,  9 Oct 2020 21:55:53 +0200 (CEST)
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Date: Fri,  9 Oct 2020 12:49:40 -0700
Message-Id: <20201009195033.3208459-6-ira.weiny@intel.com>
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-aio@kvack.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-kselftest@vger.kernel.org, samba-technical@lists.samba.org,
	Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org,
	drbd-dev@lists.linbit.com, devel@driverdev.osuosl.org,
	linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvdimm@lists.01.org,
	linux-rdma@vger.kernel.org, x86@kernel.org,
	amd-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
	cluster-devel@redhat.com, linux-cachefs@redhat.com,
	intel-wired-lan@lists.osuosl.org, xen-devel@lists.xenproject.org,
	linux-ext4@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	linux-um@lists.infradead.org, intel-gfx@lists.freedesktop.org,
	ecryptfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	reiserfs-devel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	io-uring@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Subject: [Drbd-dev] [PATCH RFC PKS/PMEM 05/58] kmap: Introduce
	k[un]map_thread
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Ira Weiny <ira.weiny@intel.com>

To correctly support the semantics of kmap() with Kernel protection keys
(PKS), kmap() may be required to set the protections on multiple
processors (globally).  Enabling PKS globally can be very expensive
depending on the requested operation.  Furthermore, enabling a domain
globally reduces the protection afforded by PKS.

Most kmap() (Aprox 209 of 229) callers use the map within a single thread and
have no need for the protection domain to be enabled globally.  However, the
remaining callers do not follow this pattern and, as best I can tell, expect
the mapping to be 'global' and available to any thread who may access the
mapping.[1]

We don't anticipate global mappings to pmem, however in general there is a
danger in changing the semantics of kmap().  Effectively, this would cause an
unresolved page fault with little to no information about why the failure
occurred.

To resolve this a number of options were considered.

1) Attempt to change all the thread local kmap() calls to kmap_atomic()[2]
2) Introduce a flags parameter to kmap() to indicate if the mapping should be
   global or not
3) Change ~20 call sites to 'kmap_global()' to indicate that they require a
   global enablement of the pages.
4) Change ~209 call sites to 'kmap_thread()' to indicate that the mapping is to
   be used within that thread of execution only

Option 1 is simply not feasible.  Option 2 would require all of the call sites
of kmap() to change.  Option 3 seems like a good minimal change but there is a
danger that new code may miss the semantic change of kmap() and not get the
behavior the developer intended.  Therefore, #4 was chosen.

Subsequent patches will convert most ~90% of the kmap callers to this new call
leaving about 10% of the existing kmap callers to enable PKS globally.

Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/highmem.h | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 2a9806e3b8d2..ef7813544719 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -60,7 +60,7 @@ static inline void kmap_flush_tlb(unsigned long addr) { }
 #endif
 
 void *kmap_high(struct page *page);
-static inline void *kmap(struct page *page)
+static inline void *__kmap(struct page *page, bool global)
 {
 	void *addr;
 
@@ -74,20 +74,20 @@ static inline void *kmap(struct page *page)
 	 * Even non-highmem pages may have additional access protections which
 	 * need to be checked and potentially enabled.
 	 */
-	dev_page_enable_access(page, true);
+	dev_page_enable_access(page, global);
 	return addr;
 }
 
 void kunmap_high(struct page *page);
 
-static inline void kunmap(struct page *page)
+static inline void __kunmap(struct page *page, bool global)
 {
 	might_sleep();
 	/*
 	 * Even non-highmem pages may have additional access protections which
 	 * need to be checked and potentially disabled.
 	 */
-	dev_page_disable_access(page, true);
+	dev_page_disable_access(page, global);
 	if (!PageHighMem(page))
 		return;
 	kunmap_high(page);
@@ -160,10 +160,10 @@ static inline struct page *kmap_to_page(void *addr)
 
 static inline unsigned long totalhigh_pages(void) { return 0UL; }
 
-static inline void *kmap(struct page *page)
+static inline void *__kmap(struct page *page, bool global)
 {
 	might_sleep();
-	dev_page_enable_access(page, true);
+	dev_page_enable_access(page, global);
 	return page_address(page);
 }
 
@@ -171,9 +171,9 @@ static inline void kunmap_high(struct page *page)
 {
 }
 
-static inline void kunmap(struct page *page)
+static inline void __kunmap(struct page *page, bool global)
 {
-	dev_page_disable_access(page, true);
+	dev_page_disable_access(page, global);
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(page_address(page));
 #endif
@@ -238,6 +238,24 @@ static inline void kmap_atomic_idx_pop(void)
 
 #endif
 
+static inline void *kmap(struct page *page)
+{
+	return __kmap(page, true);
+}
+static inline void kunmap(struct page *page)
+{
+	__kunmap(page, true);
+}
+
+static inline void *kmap_thread(struct page *page)
+{
+	return __kmap(page, false);
+}
+static inline void kunmap_thread(struct page *page)
+{
+	__kunmap(page, false);
+}
+
 /*
  * Prevent people trying to call kunmap_atomic() as if it were kunmap()
  * kunmap_atomic() should get the return value of kmap_atomic, not the page.
-- 
2.28.0.rc0.12.gb6a658bd00c9

