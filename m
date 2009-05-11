Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [86.59.100.100])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 05F131005438
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2009 17:09:44 +0200 (CEST)
Date: Mon, 11 May 2009 17:09:44 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20090511150944.GB8835@soda.linbit>
References: <20090511144347.GA8972@nik-comp.linuxbox.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090511144347.GA8972@nik-comp.linuxbox.cz>
Subject: Re: [Drbd-dev] [PATCH] 2.6.30 related fixes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, May 11, 2009 at 04:43:47PM +0200, Nikola Ciprich wrote:
> Hi,
> linux 1faa16d22877f4839bd433547d770c676d1d964c changes congestion logic to sync/async
> based. attached patch causes use of BDI_async_congested instead of old BDI_write_congested
> for new kernels
> 
> in addition, 99b76233803beab302123d243eea9e41149804f3 removes proc::owner attribute.
> according to commit comment, its use should just be removed, so second patch does just that.
> everything seems to work then.
> please apply.
> regards
> nik
> 

thanks, but too late.
I guess we have to push to public more frequently.

> -- 
> -------------------------------------
> Nikola CIPRICH
> LinuxBox.cz, s.r.o.
> 28. rijna 168, 709 01 Ostrava
> 
> tel.:   +420 596 603 142
> fax:    +420 596 621 273
> mobil:  +420 777 093 799
> 
> www.linuxbox.cz
> 
> mobil servis: +420 737 238 656
> email servis: servis@linuxbox.cz
> -------------------------------------

> diff -Naur drbd-8.3.1/drbd/drbd_wrappers.h drbd-8.3.1-fix-BDI_write_congested/drbd/drbd_wrappers.h
> --- drbd-8.3.1/drbd/drbd_wrappers.h	2009-03-26 15:58:33.000000000 +0100
> +++ drbd-8.3.1-fix-BDI_write_congested/drbd/drbd_wrappers.h	2009-05-11 16:10:21.836674009 +0200
> @@ -55,6 +55,10 @@
>  	return 0;
>  }
>  
> +#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,29)
> +#define BDI_write_congested BDI_async_congested
> +#endif
> +
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,24)
>  /* Before Linux-2.6.24 bie_endio() had the size of the bio as second argument.
>     See 6712ecf8f648118c3363c142196418f89a510b90 */

> diff -Naur drbd-8.3.1/drbd/drbd_main.c drbd-8.3.1-remove-proc-owner/drbd/drbd_main.c
> --- drbd-8.3.1/drbd/drbd_main.c	2009-03-26 15:58:33.000000000 +0100
> +++ drbd-8.3.1-remove-proc-owner/drbd/drbd_main.c	2009-05-11 16:13:33.936999632 +0200
> @@ -3116,7 +3116,6 @@
>  	}
>  
>  	drbd_proc->proc_fops = &drbd_proc_fops;
> -	drbd_proc->owner = THIS_MODULE;
>  #else
>  # error "Currently drbd depends on the proc file system (CONFIG_PROC_FS)"
>  #endif


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
