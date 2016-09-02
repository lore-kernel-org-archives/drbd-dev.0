Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 13A251028A59
	for <drbd-dev@lists.linbit.com>; Fri,  2 Sep 2016 10:18:38 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Baoyou Xie <baoyou.xie@linaro.org>
Date: Fri, 02 Sep 2016 10:18:35 +0200
Message-ID: <1741789.BtBaIYKiRQ@fat-tyre>
In-Reply-To: <1472727473-25593-1-git-send-email-baoyou.xie@linaro.org>
References: <1472727473-25593-1-git-send-email-baoyou.xie@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: lars.ellenberg@linbit.com, xie.baoyou@zte.com.cn,
	linux-kernel@vger.kernel.org, arnd@arndb.de, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: mark symbols static where possible
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Baoyou,

thanks for the patch. I applied it to our tree. Will be sent to
one of the next merge windows...

best regards,
 Phil
Am Donnerstag, 1. September 2016, 18:57:53 CEST schrieb Baoyou Xie:
> We get a few warnings when building kernel with W=1:
> drivers/block/drbd/drbd_receiver.c:1224:6: warning: no previous prototype
> for 'one_flush_endio' [-Wmissing-prototypes]
> drivers/block/drbd/drbd_req.c:1450:6: warning: no previous prototype for
> 'send_and_submit_pending' [-Wmissing-prototypes]
> drivers/block/drbd/drbd_main.c:924:6: warning: no previous prototype for
> 'assign_p_sizes_qlim' [-Wmissing-prototypes] ....
> 
> In fact, these functions are only used in the file in which they are
> declared and don't need a declaration, but can be made static.
> So this patch marks these functions with 'static'.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  drivers/block/drbd/drbd_main.c     | 4 +++-
>  drivers/block/drbd/drbd_receiver.c | 2 +-
>  drivers/block/drbd/drbd_req.c      | 3 ++-
>  drivers/block/drbd/drbd_worker.c   | 3 ++-
>  4 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 100be55..f0aa746 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -921,7 +921,9 @@ void drbd_gen_and_send_sync_uuid(struct drbd_peer_device
> *peer_device) }
> 
>  /* communicated if (agreed_features & DRBD_FF_WSAME) */
> -void assign_p_sizes_qlim(struct drbd_device *device, struct p_sizes *p,
> struct request_queue *q) +static void
> +assign_p_sizes_qlim(struct drbd_device *device, struct p_sizes *p,
> +					struct request_queue *q)
>  {
>  	if (q) {
>  		p->qlim->physical_block_size = 
cpu_to_be32(queue_physical_block_size(q));
> diff --git a/drivers/block/drbd/drbd_receiver.c
> b/drivers/block/drbd/drbd_receiver.c index 942384f..432f39a 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -1221,7 +1221,7 @@ struct one_flush_context {
>  	struct issue_flush_context *ctx;
>  };
> 
> -void one_flush_endio(struct bio *bio)
> +static void one_flush_endio(struct bio *bio)
>  {
>  	struct one_flush_context *octx = bio->bi_private;
>  	struct drbd_device *device = octx->device;
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index de279fe..c725bf5 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -1447,7 +1447,8 @@ static bool prepare_al_transaction_nonblock(struct
> drbd_device *device, return !list_empty(pending);
>  }
> 
> -void send_and_submit_pending(struct drbd_device *device, struct list_head
> *pending) +static void
> +send_and_submit_pending(struct drbd_device *device, struct list_head
> *pending) {
>  	struct drbd_request *req, *tmp;
> 
> diff --git a/drivers/block/drbd/drbd_worker.c
> b/drivers/block/drbd/drbd_worker.c index c6755c9..70f2706 100644
> --- a/drivers/block/drbd/drbd_worker.c
> +++ b/drivers/block/drbd/drbd_worker.c
> @@ -194,7 +194,8 @@ void drbd_peer_request_endio(struct bio *bio)
>  	}
>  }
> 
> -void drbd_panic_after_delayed_completion_of_aborted_request(struct
> drbd_device *device) +static void
> +drbd_panic_after_delayed_completion_of_aborted_request(struct drbd_device
> *device) {
>  	panic("drbd%u %s/%u potential random memory corruption caused by delayed
> completion of aborted local request\n", device->minor,
> device->resource->name, device->vnr);


