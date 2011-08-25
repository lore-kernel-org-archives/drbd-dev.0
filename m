Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4B19E1055700
	for <drbd-dev@lists.linbit.com>; Fri, 26 Aug 2011 14:31:21 +0200 (CEST)
Resent-Message-ID: <20110826123121.GP14479@barkeeper1-xen.linbit>
Received: from labridge.com (unknown [206.117.179.246])
	(using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4115E10556D5
	for <drbd-dev@lists.linbit.com>; Thu, 25 Aug 2011 21:16:30 +0200 (CEST)
From: Joe Perches <joe@perches.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-69-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
	<1314284934-17999-69-git-send-email-philipp.reisner@linbit.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 25 Aug 2011 11:16:25 -0700
Message-ID: <1314296185.15882.75.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 068/118] drbd: conn_printk() a dev_printk()
 alike for drbd's connections
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, 2011-08-25 at 17:08 +0200, Philipp Reisner wrote:
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> ---
>  drivers/block/drbd/drbd_int.h  |    9 +++++++++
>  drivers/block/drbd/drbd_main.c |   16 +++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletions(-)

Couple of issues with this patch.

> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
[]
> @@ -102,6 +102,15 @@ struct drbd_tconn;
[]
> +extern void conn_printk(const char *level, struct drbd_tconn *tconn, const char *fmt, ...);

This should be 

extern __attribute__((format (printf, 3, 4)))
void conn_printk(const char *level, struct drbd_tconn *tconn, const char  *fmt, ...);

to have gcc validate the printf format and arguments.

> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
[]
> @@ -170,6 +170,18 @@ int _get_ldev_if_state(struct drbd_conf *mdev, enum drbd_disk_state mins)
>  
>  #endif
>  
> +/* printk functions for connections
> + */
> +void conn_printk(const char *level, struct drbd_tconn *tconn, const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	printk("%sd-con %s: ", level, tconn->name);
> +	va_start(args, fmt);
> +	vprintk(fmt, args);
> +	va_end(args);

And using printk then vprintk is susceptible
to another thread interleaving a different
message between the printk and the vprintk.

Using struct va_format and %pV is better
because no message interleaving is possible.

ie:

void conn_printk(const char *level, struct drbd_tconn *tconn, const char *fmt, ...)
{
	struct va_format vaf;
	va_list args;

	va_start(args, fmt);

	vaf.fmt = fmt;
	vaf.va = &args;

	printk("%sd-con %s: %pV", level, tconn->name, &vaf);

	va_end(args);
}

