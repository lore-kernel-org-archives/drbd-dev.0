Return-Path: <keescook@chromium.org>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
	[209.85.214.195])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2CA6D420235
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 16:34:57 +0200 (CEST)
Received: by mail-pl1-f195.google.com with SMTP id y17so2246788plb.8
	for <drbd-dev@lists.linbit.com>; Thu, 04 Jun 2020 07:34:57 -0700 (PDT)
Date: Thu, 4 Jun 2020 07:34:54 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Message-ID: <202006040728.8797FAA4@keescook>
References: <20200603233203.1695403-2-keescook@chromium.org>
	<874krr8dps.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874krr8dps.fsf@nanos.tec.linutronix.de>
Cc: Andy Whitcroft <apw@canonical.com>, clang-built-linux@googlegroups.com,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 01/10] x86/mm/numa: Remove
	uninitialized_var() usage
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

On Thu, Jun 04, 2020 at 09:58:07AM +0200, Thomas Gleixner wrote:
> Kees Cook <keescook@chromium.org> writes:
> > -#ifdef NODE_NOT_IN_PAGE_FLAGS
> > -	pfn_align = node_map_pfn_alignment();
> > -	if (pfn_align && pfn_align < PAGES_PER_SECTION) {
> > -		printk(KERN_WARNING "Node alignment %LuMB < min %LuMB, rejecting NUMA config\n",
> > -		       PFN_PHYS(pfn_align) >> 20,
> > -		       PFN_PHYS(PAGES_PER_SECTION) >> 20);
> > -		return -EINVAL;
> > +	if (IS_ENABLED(NODE_NOT_IN_PAGE_FLAGS)) {
> 
> Hrm, clever ...
> 
> > +		unsigned long pfn_align = node_map_pfn_alignment();
> > +
> > +		if (pfn_align && pfn_align < PAGES_PER_SECTION) {
> > +			pr_warn("Node alignment %LuMB < min %LuMB, rejecting NUMA config\n",
> > +				PFN_PHYS(pfn_align) >> 20,
> > +				PFN_PHYS(PAGES_PER_SECTION) >> 20);
> > +			return -EINVAL;
> > +		}
> >  	}
> > -#endif
> >  	if (!numa_meminfo_cover_memory(mi))
> >  		return -EINVAL;
> >  
> > diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
> > index 71283739ffd2..1a4cdec2bd29 100644
> > --- a/include/linux/page-flags-layout.h
> > +++ b/include/linux/page-flags-layout.h
> > @@ -100,7 +100,7 @@
> >   * there.  This includes the case where there is no node, so it is implicit.
> >   */
> >  #if !(NODES_WIDTH > 0 || NODES_SHIFT == 0)
> > -#define NODE_NOT_IN_PAGE_FLAGS
> > +#define NODE_NOT_IN_PAGE_FLAGS 1
> 
> but if we ever lose the 1 then the above will silently compile the code
> within the IS_ENABLED() section out.

That's true, yes. I considered two other ways to do this:

1) smallest patch, but more #ifdef:

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 59ba008504dc..fbf5231a3d35 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -541,7 +541,9 @@ static void __init numa_clear_kernel_node_hotplug(void)
 
 static int __init numa_register_memblks(struct numa_meminfo *mi)
 {
-	unsigned long uninitialized_var(pfn_align);
+#ifdef NODE_NOT_IN_PAGE_FLAGS
+	unsigned long pfn_align;
+#endif
 	int i, nid;
 
 	/* Account for nodes with cpus and no memory */

2) medium size, weird style:

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 59ba008504dc..0df7ba9b21b2 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -541,7 +541,6 @@ static void __init numa_clear_kernel_node_hotplug(void)
 
 static int __init numa_register_memblks(struct numa_meminfo *mi)
 {
-	unsigned long uninitialized_var(pfn_align);
 	int i, nid;
 
 	/* Account for nodes with cpus and no memory */
@@ -570,12 +569,15 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 	 * whether its granularity is fine enough.
 	 */
 #ifdef NODE_NOT_IN_PAGE_FLAGS
-	pfn_align = node_map_pfn_alignment();
-	if (pfn_align && pfn_align < PAGES_PER_SECTION) {
-		printk(KERN_WARNING "Node alignment %LuMB < min %LuMB, rejecting NUMA config\n",
-		       PFN_PHYS(pfn_align) >> 20,
-		       PFN_PHYS(PAGES_PER_SECTION) >> 20);
-		return -EINVAL;
+	{
+		unsigned long pfn_align = node_map_pfn_alignment();
+
+		if (pfn_align && pfn_align < PAGES_PER_SECTION) {
+			pr_warn("Node alignment %LuMB < min %LuMB, rejecting NUMA config\n",
+			       PFN_PHYS(pfn_align) >> 20,
+			       PFN_PHYS(PAGES_PER_SECTION) >> 20);
+			return -EINVAL;
+		}
 	}
 #endif
 	if (!numa_meminfo_cover_memory(mi))

and 3 is what I sent: biggest, but removes #ifdef

Any preference?

Thanks!

-- 
Kees Cook
