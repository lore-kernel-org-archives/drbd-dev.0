Return-Path: <paul.clements@steeleye.com>
Message-ID: <427B993F.3080907@steeleye.com>
Date: Fri, 06 May 2005 12:20:15 -0400
From: Paul Clements <paul.clements@steeleye.com>
MIME-Version: 1.0
To: philipp.reisner@linbit.com
References: <4F6A5F5D1AA48F4584FF34E6F57D0518018A85@steelpo1.steeleye.com>
	<42765DEB.6040109@steeleye.com> <42766EF6.4090707@steeleye.com>
In-Reply-To: <42766EF6.4090707@steeleye.com>
Content-Type: multipart/mixed; boundary="------------010205070004070603010608"
Cc: drbd-user@linbit.com, drbd-dev@linbit.com
Subject: [Drbd-dev] Re: BUG: DRBD on Power PC 64-bit with RedHat EL 3
 (2.4.21 kernel) does not work [PATCH]
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.
--------------010205070004070603010608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

OK, here's a patch that fixes this problem. With this, you can now 
'make' at the top level and everything just works.

So, can we expect a 0.7.11 release anytime soon? :)

Thanks,
Paul

Paul Clements wrote:
> We've recently been trying to certify DRBD (we've tried both 0.7.5 and 
> 0.7.10 with the same results) on ppc64 with RHEL3.
> 
> Unfortunately, we have run into two fairly serious issues:
> 
> 1) we had to hack up the source just to get it to build:
> 
> The basic problem is that the adjust_drbd_config_h.sh script is not 
> doing the right thing for RHEL3 on ppc64. RHEL3 has a find_next_bit() 
> function, and on most architectures it's an inline function. However, on 
> ppc64 it's not inline and it's not exported, which means drbd (being a 
> module) can't use it. So we have to actually disable the 
> HAVE_FIND_NEXT_BIT setting in drbd_config.h. Also, there is no 
> arch-specific find_next_bit function for ppc64 in drbd_compat_types.h, 
> so we have to use the generic find_next_bit function that's in that file 
> (by defining USE_GENERIC_FIND_NEXT_BIT in drbd_config.h). Of course, 
> when this function is defined, it conflicts with the previous 
> find_next_bit function declaration from the kernel headers 
> (asm-ppc64/bitops.h). So, we had to rename the generic function to 
> generic_find_next_bit and change all calls in the drbd source (just one 
> in drbd_bitmap.c) to use generic_find_next_bit instead of find_next_bit.
> 
> 
> 2) additionally, the driver appears to start up fine on both machines, 
> but when the resync begins, it quickly stalls and never makes any progress
> 
> 
> Included are the DRBD config and other system information. Please let me 
> know if you need any further information.
> 
> Thanks,
> Paul
> 
> 
> --------
> After starting drbd on the source system (already running on the 
> target), this happens:
> 
> [root@trumpkin root]# cat /proc/drbd
> version: 0.7.5 (api:76/proto:74)
> SVN Revision: 1578 build by root@tumnus, 2005-04-29 10:13:28
>  0: cs:SyncSource st:Secondary/Secondary ld:Consistent
>     ns:128 nr:0 dw:0 dr:128 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
>         [>...................] sync'ed:  0.9% (978816/978944)K
>         finish: 2:43:08 speed: 32 (32) K/sec
> 
> [root@trumpkin root]# cat /proc/drbd
> version: 0.7.5 (api:76/proto:74)
> SVN Revision: 1578 build by root@tumnus, 2005-04-29 10:13:28
>  0: cs:SyncSource st:Secondary/Secondary ld:Consistent
>     ns:128 nr:0 dw:0 dr:128 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
>         [>...................] sync'ed:  0.9% (978816/978944)K
>         finish: 7:28:37 speed: 8 (8) K/sec
> 
> [root@trumpkin root]# cat /proc/drbd
> version: 0.7.5 (api:76/proto:74)
> SVN Revision: 1578 build by root@tumnus, 2005-04-29 10:13:28
>  0: cs:SyncSource st:Secondary/Secondary ld:Consistent
>     ns:128 nr:0 dw:0 dr:128 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
>         [>...................] sync'ed:  0.9% (978816/978944)K
>         finish: 8:09:24 speed: 8 (8) K/sec
> 
> [root@trumpkin root]# uname -a
> Linux trumpkin 2.4.21-27.EL #1 SMP Wed Dec 1 21:53:20 EST 2004 ppc64 
> ppc64 ppc64
>  GNU/Linux
> 
> 
> --------
> On the target, this is reported:
> 
> [root@tumnus root]# cat /proc/drbd
> version: 0.7.5 (api:76/proto:74)
> SVN Revision: 1578 build by root@tumnus, 2005-04-29 10:13:28
>  0: cs:SyncTarget st:Secondary/Secondary ld:Inconsistent
>     ns:0 nr:128 dw:128 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
>         [>...................] sync'ed:  0.9% (978816/978944)K
>         finish: 106:02:18 speed: 0 (0) K/sec
> 
> [root@tumnus root]# cat /proc/drbd
> version: 0.7.5 (api:76/proto:74)
> SVN Revision: 1578 build by root@tumnus, 2005-04-29 10:13:28
>  0: cs:SyncTarget st:Secondary/Secondary ld:Inconsistent
>     ns:0 nr:128 dw:128 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
>         [>...................] sync'ed:  0.9% (978816/978944)K
>         finish: 117:35:37 speed: 0 (0) K/sec
> 
> [root@tumnus root]# cat /proc/drbd
> version: 0.7.5 (api:76/proto:74)
> SVN Revision: 1578 build by root@tumnus, 2005-04-29 10:13:28
>  0: cs:SyncTarget st:Secondary/Secondary ld:Inconsistent
>     ns:0 nr:128 dw:128 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
>         [>...................] sync'ed:  0.9% (978816/978944)K
>         finish: 118:16:24 speed: 0 (0) K/sec
> 
> [root@tumnus root]# uname -a
> Linux tumnus 2.4.21-27.EL #1 SMP Wed Dec 1 21:53:20 EST 2004 ppc64 ppc64 
> ppc64 GNU/Linux


--------------010205070004070603010608
Content-Type: text/plain;
 name="drbd_ppc64_find_next_bit_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drbd_ppc64_find_next_bit_fix.diff"

diff -purN --exclude user --exclude-from /tmp/dontdiff drbd-0.7.10-PRISTINE/drbd/drbd_bitmap.c drbd-0.7.10/drbd/drbd_bitmap.c
--- drbd-0.7.10-PRISTINE/drbd/drbd_bitmap.c	2005-01-12 10:23:45.000000000 -0500
+++ drbd-0.7.10/drbd/drbd_bitmap.c	2005-05-06 11:58:05.000000000 -0400
@@ -33,6 +33,49 @@
 #include <linux/drbd.h>
 #include "drbd_int.h"
 
+/* special handling for ppc64 on 2.4 kernel -- find_next_bit is not exported
+ * so we include it here (verbatim, from linux 2.4.21 sources) */
+#if defined(__powerpc64__) && LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+
+unsigned long find_next_bit(unsigned long *addr, unsigned long size, unsigned long offset)
+{
+        unsigned long *p = addr + (offset >> 6);
+        unsigned long result = offset & ~63UL;
+        unsigned long tmp;
+
+        if (offset >= size)
+                return size;
+        size -= result;
+        offset &= 63UL;
+        if (offset) {
+                tmp = *(p++);
+                tmp &= (~0UL << offset);
+                if (size < 64)
+                        goto found_first;
+                if (tmp)
+                        goto found_middle;
+                size -= 64;
+                result += 64;
+        }
+        while (size & ~63UL) {
+                if ((tmp = *(p++)))
+                        goto found_middle;
+                result += 64;
+                size -= 64;
+        }
+        if (!size)
+                return result;
+        tmp = *p;
+
+found_first:
+        tmp &= (~0UL >> (64 - size));
+        if (tmp == 0UL)        /* Are any bits set? */
+                return result + size; /* Nope. */
+found_middle:
+        return result + __ffs(tmp);
+}
+#endif /* NEED_PPC64_WORKAROUND */
+
 /* OPAQUE outside this file!
  * interface defined in drbd_int.h
  *
diff -purN --exclude user --exclude-from /tmp/dontdiff drbd-0.7.10-PRISTINE/drbd/drbd_compat_types.h drbd-0.7.10/drbd/drbd_compat_types.h
--- drbd-0.7.10-PRISTINE/drbd/drbd_compat_types.h	2004-10-13 05:31:00.000000000 -0400
+++ drbd-0.7.10/drbd/drbd_compat_types.h	2005-05-06 11:54:35.000000000 -0400
@@ -296,8 +296,8 @@ find_next_bit(void * addr, unsigned long
 #undef _x10000
 #undef _xSHIFT
 
-#else
-#warning "You probabely need to copy find_next_bit() from a 2.6.x kernel."
+#elif !defined(__powerpc64__) /* ppc64 is taken care of, see drbd_bitmap.c */
+#warning "You probably need to copy find_next_bit() from a 2.6.x kernel."
 #warning "Or enable low performance generic C-code"
 #warning "(USE_GENERIC_FIND_NEXT_BIT in drbd_config.h)"
 #endif
diff -purN --exclude user --exclude-from /tmp/dontdiff drbd-0.7.10-PRISTINE/scripts/adjust_drbd_config_h.sh drbd-0.7.10/scripts/adjust_drbd_config_h.sh
--- drbd-0.7.10-PRISTINE/scripts/adjust_drbd_config_h.sh	2004-09-21 03:28:35.000000000 -0400
+++ drbd-0.7.10/scripts/adjust_drbd_config_h.sh	2005-05-06 11:33:37.000000000 -0400
@@ -59,7 +59,13 @@ if grep_q "^PATCHLEVEL *= *4" $KDIR/Make
     cat 2>/dev/null $KDIR/include/asm{,/arch}/bitops.h |
     grep_q 'find_next_bit'
   then
-    have_find_next_bit=1
+    # on ppc64, it's declared but not exported, so we use our own copy
+    if grep_q '^CONFIG_PPC64=y' $KDIR/.config
+    then
+      have_find_next_bit=0
+    else
+      have_find_next_bit=1
+    fi
   else
     have_find_next_bit=0
   fi

--------------010205070004070603010608--
