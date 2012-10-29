Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 531371013804
	for <drbd-dev@lists.linbit.com>; Mon, 29 Oct 2012 11:22:35 +0100 (CET)
Date: Mon, 29 Oct 2012 11:22:33 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Alessandro Bono <alessandro.bono@gmail.com>
Message-ID: <20121029102233.GB18606@soda.linbit>
References: <k6e1m5$n09$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k6e1m5$n09$1@ger.gmane.org>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] fix %preun script in drbd-km.spec from 8.3 package
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Oct 26, 2012 at 01:03:01PM +0000, Alessandro Bono wrote:
> Hi
> 
> %preun script in drbd-km.spec try to unload drbd.ko if present without check kernel version running
> without this patch it's not possible to remove drbd-km package of old kernel

... unless you first unload the current DRBD module as well,
or use rpm -e --noscript.

Which in fact is intentional, to prevent people from "accidentally"
uninstall a module package while the provided module is still in use
(it may have been symlinked in place into some other kernel version
 by some weak-module magic, or explicitly).

But yes, it may be annoying at times.

So maybe
filename=$(modinfo -F filename drbd)
filename=$(readlink "$filename")
rpm -qf $filename
and check if that is in fact the current package?

> --- drbd-8.3.13/drbd-km.spec    2012-10-26 13:43:43.163366400 +0200
> +++ drbd-8.3.13.my/drbd-km.spec 2012-10-26 13:44:33.368384889 +0200
> @@ -80,10 +80,12 @@
>  rm -rf %{buildroot}
> 
>  %preun %{krelver}
> +if [ 'uname -r' = %{kernelversion} ]; then
>  lsmod | grep drbd > /dev/null 2>&1
>  if [ $? -eq 0 ]; then
>      rmmod drbd
>  fi
> +fi
> 
>  %post %{krelver}
>  # hack for distribution kernel packages,                                  

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com
