Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [86.59.100.100])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A60D2104B1B0
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2009 13:14:14 +0200 (CEST)
Date: Thu, 7 May 2009 13:14:14 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20090507111414.GB8753@soda.linbit>
References: <1241687771-28759-1-git-send-email-mika@grml.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1241687771-28759-1-git-send-email-mika@grml.org>
Subject: Re: [Drbd-dev] [PATCH] Support use of HAVE_LINUX_BYTEORDER_SWABB_H
	for kernel	versions older than 2.6.29
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 07, 2009 at 11:16:11AM +0200, Michael Prokop wrote:
> 
> Signed-off-by: Michael Prokop <mika@grml.org>
> 
> diff --git a/drbd/linux/drbd_config.h b/drbd/linux/drbd_config.h
> index 4d323f7..ac14997 100644
> --- a/drbd/linux/drbd_config.h
> +++ b/drbd/linux/drbd_config.h
> @@ -74,7 +74,10 @@ extern const char *drbd_buildtag(void);
>  #define HAVE_LINUX_SCATTERLIST_H
>  
>  /* 2.6.29 and up no longer have swabb.h */
> -//#define HAVE_LINUX_BYTEORDER_SWABB_H
> +#include <linux/version.h>
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
> +#define HAVE_LINUX_BYTEORDER_SWABB_H
> +#endif
>  
>  /* Some vendor kernels < 2.6.7 might define msleep in one or
>   * another way .. */

Thanks. But unneccessary.
For the other settings, scripts/adjust_drbd_config_h.sh has to be run
anyways, which also takes care of this setting.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
