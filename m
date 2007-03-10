Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1E9A52E06986
	for <drbd-dev@lists.linbit.com>; Sat, 10 Mar 2007 12:42:47 +0100 (CET)
Date: Sat, 10 Mar 2007 12:42:46 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] make KDIR=... kernel-patch fails
Message-ID: <20070310114246.GA26492@barkeeper1.linbit>
References: <45F1DCB7.3020303@aj.net-lab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45F1DCB7.3020303@aj.net-lab.net>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2007-03-09 23:16:23 +0100
\ Andreas John:
> Hello,
> I try to patch drbd into the kernel. IIRC this is not longer possible
> since late 0.7.x released (>=.22 ??).
> 
> Currently even on 8.0.0 and 8.0.1 the helper scrips fails on a 2.6.20.1:
> 
> ----
> buildbox-etch:/usr/src/linux-vserver/linux-2.6.20.1/drbd-8.0.1# make
> KDIR=/usr/src/linux-vserver/linux-2.6.20.1 kernel-patch
> make -C drbd drbd_buildtag.c
> make[1]: Entering directory
> `/usr/src/linux-vserver/linux-2.6.20.1/drbd-8.0.1/drbd'
> make[1]: Leaving directory
> `/usr/src/linux-vserver/linux-2.6.20.1/drbd-8.0.1/drbd'
> set -o errexit; \
>         kbase=$(basename /usr/src/linux-vserver/linux-2.6.20.1); \
>         d=patch-$kbase-drbd-8.0.1; \
>         test -e $d && cp -fav --backup=numbered $d $d; \
>         bash scripts/patch-kernel /usr/src/linux-vserver/linux-2.6.20.1
> . > $d
> rm: cannot remove `linux-2.6.20.1-drbd/drivers/block/drbd/mempool*': No
> such file or directory
> make: *** [kernel-patch] Error 1
> -----
> 
> I can supress the error by patching two lines in the
> scripts/patch-kernel script:
> 
> 
> -------
> --- scripts/patch-kernel.sav    2007-02-25 16:25:42.000000000 +0100
> +++ scripts/patch-kernel        2007-02-25 16:26:02.000000000 +0100
> @@ -100,9 +100,10 @@
>  cp -a $DRBD/drbd/Makefile-2.$KDIR_PATCHLEVEL  $DRBD_SUB/Makefile
> 
>  # remove some backports
> -test "$KDIR_PATCHLEVEL" = 6 && rm $DRBD_SUB/mempool*
> +# remove some backports
> +test "$KDIR_PATCHLEVEL" = 6 && if [ -e $DRBD_SUB/mempool* ]; then rm
> $DRBD_SUB/mempool*; fi
>  grep "HLIST_HEAD_INIT" $KERNEL/include/linux/list.h >/dev/null &&
> -       rm $DRBD_SUB/hlist.h
> +        if [ -e $DRBD_SUB/hlist.h ]; then rm $DRBD_SUB/hlist.h; fi
> 
>  # disable __arch_um__ to_virt() hack
>  sed -e 's/^#ifdef __arch_um__/#if 0/' \
> ---------
> 
> The generated patch applies fine,

I even removed those lines altogether.
we no longer have these files,
they have been kernel 2.4 compatibility.

> but when compiling the kernel with
> drdb as module, the compile runs fails. I assume some part of the patch
> is missing.
> 
> Kernel Hacking is out-of-scope of my skills, so I simply report here
> what I found out.

thanks for the report.
sorry, but I "officially don't care" right now.
though, we will do some effort later this year
to try and get drbd into the kernel.org kernel.
so when I have time, I'll have a look.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
