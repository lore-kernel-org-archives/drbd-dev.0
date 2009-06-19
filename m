Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0B1DE10735BD
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 18:06:08 +0200 (CEST)
Date: Fri, 19 Jun 2009 18:06:07 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20090619160607.GH9526@soda.linbit>
References: <4A3BADD8.8030206@grad.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4A3BADD8.8030206@grad.hr>
Subject: Re: [Drbd-dev] Another compatibility issue
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jun 19, 2009 at 05:25:12PM +0200, Ante Karamatić wrote:
> Hi again
> 
> Here's another issue I'm having. linux/drbd_config.h is right saying:
> 
>  /* 2.6.29 and up no longer have swabb.h */
> 
> But, then doesn't do anything about it. So, proposed diff is attached.

> --- drbd8-8.3.2~/drbd/linux/drbd_config.h       2009-06-19 16:11:44.000000000 +0200
> +++ drbd8-8.3.2/drbd/linux/drbd_config.h        2009-06-19 17:19:00.000000000 +0200
> @@ -74,7 +74,11 @@
>  #define HAVE_LINUX_SCATTERLIST_H
> 
>  /* 2.6.29 and up no longer have swabb.h */
> +#include <linux/version.h>
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
>  #define HAVE_LINUX_BYTEORDER_SWABB_H
> +#endif
> +
> 
>  /* Some vendor kernels < 2.6.7 might define msleep in one or
>   * another way .. */

sorry, but NOnono again.

did you have a look at the output of the make run?

there is this uncool  scripts/adjust_drbd_config_h.sh,
which will take care of, you guessed right, adjusting the drbd_config.h
for whatever kernel source tree you try to compile it again.

and, no, it DOES NOT WORK to trigger on kernel version only.
because of the vendor kernels, which include all sorts of backports.
and they change such things even between very minor package release
number changes.


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
