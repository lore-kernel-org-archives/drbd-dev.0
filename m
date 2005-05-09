Return-Path: <Lars.Ellenberg@linbit.com>
Date: Mon, 9 May 2005 15:24:32 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com, drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] Re: BUG: DRBD on Power PC 64-bit with RedHat EL 3
	(2.4.21 kernel) does not work [PATCH]
Message-ID: <Ucki2Rp3N9W7xR6Fb5ySj7U=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427B993F.3080907@steeleye.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2005-05-06 12:20:15 -0400
\ Paul Clements:
> OK, here's a patch that fixes this problem. With this, you can now
> 'make' at the top level and everything just works.

> diff -purN --exclude user --exclude-from /tmp/dontdiff drbd-0.7.10-PRISTINE/drbd/drbd_bitmap.c drbd-0.7.10/drbd/drbd_bitmap.c
> --- drbd-0.7.10-PRISTINE/drbd/drbd_bitmap.c	2005-01-12 10:23:45.000000000 -0500
> +++ drbd-0.7.10/drbd/drbd_bitmap.c	2005-05-06 11:58:05.000000000 -0400
> @@ -33,6 +33,49 @@
>  #include <linux/drbd.h>
>  #include "drbd_int.h"
>  
> +/* special handling for ppc64 on 2.4 kernel -- find_next_bit is not exported
> + * so we include it here (verbatim, from linux 2.4.21 sources) */
> +#if defined(__powerpc64__) && LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> +
> +unsigned long find_next_bit(unsigned long *addr, unsigned long size, unsigned long offset)
> +{
   ...
> +}
> +#endif /* NEED_PPC64_WORKAROUND */

which is exactly the same as the "generic" version, used when
"USE_GENERIC_FIND_NEXT_BIT" is on...

> diff -purN --exclude user --exclude-from /tmp/dontdiff drbd-0.7.10-PRISTINE/scripts/adjust_drbd_config_h.sh drbd-0.7.10/scripts/adjust_drbd_config_h.sh
> --- drbd-0.7.10-PRISTINE/scripts/adjust_drbd_config_h.sh	2004-09-21 03:28:35.000000000 -0400
> +++ drbd-0.7.10/scripts/adjust_drbd_config_h.sh	2005-05-06 11:33:37.000000000 -0400
> @@ -59,7 +59,13 @@ if grep_q "^PATCHLEVEL *= *4" $KDIR/Make
>      cat 2>/dev/null $KDIR/include/asm{,/arch}/bitops.h |
>      grep_q 'find_next_bit'
>    then
> -    have_find_next_bit=1
> +    # on ppc64, it's declared but not exported, so we use our own copy
> +    if grep_q '^CONFIG_PPC64=y' $KDIR/.config
> +    then
> +      have_find_next_bit=0
> +    else
> +      have_find_next_bit=1
> +    fi
>    else
>      have_find_next_bit=0
>    fi

therefore I'd rather grep for "external .* find_next_bit",
and then swithc on USE_GENERIC_FIND_NEXT_BIT.
maybe one could even overload the HAVE_FIND_NEXT_BIT
with inline vs. external information.

I'll have a look tomorrow.


	Lars Ellenberg

-- 
please use the "List-Reply" function of your email client.
