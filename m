Return-Path: <BATV+347c3dad313745b9998d+6260+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 224564202F4
	for <drbd-dev@lists.linbit.com>; Tue, 13 Oct 2020 13:26:37 +0200 (CEST)
Date: Tue, 13 Oct 2020 12:25:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: ira.weiny@intel.com
Message-ID: <20201013112544.GA5249@infradead.org>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
	<20201009195033.3208459-25-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009195033.3208459-25-ira.weiny@intel.com>
Cc: linux-aio@kvack.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	linux-mmc@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-kselftest@vger.kernel.org, samba-technical@lists.samba.org,
	Thomas Gleixner <tglx@linutronix.de>, drbd-dev@lists.linbit.com,
	devel@driverdev.osuosl.org, cluster-devel@redhat.com,
	linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
	x86@kernel.org, ceph-devel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, intel-wired-lan@lists.osuosl.org,
	xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>, linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org, linux-um@lists.infradead.org,
	intel-gfx@lists.freedesktop.org, ecryptfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, reiserfs-devel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH RFC PKS/PMEM 24/58] fs/freevxfs: Utilize new
	kmap_thread()
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

> -	kaddr = kmap(pp);
> +	kaddr = kmap_thread(pp);
>  	memcpy(kaddr, vip->vii_immed.vi_immed + offset, PAGE_SIZE);
> -	kunmap(pp);
> +	kunmap_thread(pp);

You only Cced me on this particular patch, which means I have absolutely
no idea what kmap_thread and kunmap_thread actually do, and thus can't
provide an informed review.

That being said I think your life would be a lot easier if you add
helpers for the above code sequence and its counterpart that copies
to a potential hughmem page first, as that hides the implementation
details from most users.
