Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
	[209.85.208.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A0453420FB4
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 11:28:39 +0200 (CEST)
Received: by mail-ed1-f51.google.com with SMTP id d10so1934531edj.0
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 02:28:39 -0700 (PDT)
Message-ID: <57862355-5c67-804d-0e4f-7c10ad5d411d@linbit.com>
Date: Wed, 6 Apr 2022 11:28:36 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
	<20220406060516.409838-7-hch@lst.de>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406060516.409838-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/27] drbd: cleanup decide_on_discard_support
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

Am 06.04.22 um 08:04 schrieb Christoph Hellwig:
> Sanitize the calling conventions and use a goto label to cleanup the
> code flow.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_nl.c | 68 +++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 02030c9c4d3b1..40bb0b356a6d6 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1204,38 +1204,42 @@ static unsigned int drbd_max_discard_sectors(struct drbd_connection *connection)
>  }
>  
>  static void decide_on_discard_support(struct drbd_device *device,
> -			struct request_queue *q,
> -			struct request_queue *b,
> -			bool discard_zeroes_if_aligned)
> +		struct drbd_backing_dev *bdev)
>  {
> -	/* q = drbd device queue (device->rq_queue)
> -	 * b = backing device queue (device->ldev->backing_bdev->bd_disk->queue),
> -	 *     or NULL if diskless
> -	 */
> -	struct drbd_connection *connection = first_peer_device(device)->connection;
> -	bool can_do = b ? blk_queue_discard(b) : true;
> -
> -	if (can_do && connection->cstate >= C_CONNECTED && !(connection->agreed_features & DRBD_FF_TRIM)) {
> -		can_do = false;
> -		drbd_info(connection, "peer DRBD too old, does not support TRIM: disabling discards\n");
> -	}
> -	if (can_do) {
> -		/* We don't care for the granularity, really.
> -		 * Stacking limits below should fix it for the local
> -		 * device.  Whether or not it is a suitable granularity
> -		 * on the remote device is not our problem, really. If
> -		 * you care, you need to use devices with similar
> -		 * topology on all peers. */
> -		blk_queue_discard_granularity(q, 512);
> -		q->limits.max_discard_sectors = drbd_max_discard_sectors(connection);
> -		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> -		q->limits.max_write_zeroes_sectors = drbd_max_discard_sectors(connection);
> -	} else {
> -		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> -		blk_queue_discard_granularity(q, 0);
> -		q->limits.max_discard_sectors = 0;
> -		q->limits.max_write_zeroes_sectors = 0;
> +	struct drbd_connection *connection =
> +		first_peer_device(device)->connection;
> +	struct request_queue *q = device->rq_queue;
> +
> +	if (bdev && !blk_queue_discard(bdev->backing_bdev->bd_disk->queue))
> +		goto not_supported;
> +
> +	if (connection->cstate >= C_CONNECTED &&
> +	    !(connection->agreed_features & DRBD_FF_TRIM)) {
> +		drbd_info(connection,
> +			"peer DRBD too old, does not support TRIM: disabling discards\n");
> +		goto not_supported;
>  	}
> +
> +	/*
> +	 * We don't care for the granularity, really.
> +	 *
> +	 * Stacking limits below should fix it for the local device.  Whether or
> +	 * not it is a suitable granularity on the remote device is not our
> +	 * problem, really. If you care, you need to use devices with similar
> +	 * topology on all peers.
> +	 */
> +	blk_queue_discard_granularity(q, 512);
> +	q->limits.max_discard_sectors = drbd_max_discard_sectors(connection);
> +	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> +	q->limits.max_write_zeroes_sectors =
> +		drbd_max_discard_sectors(connection);
> +	return;
> +
> +not_supported:
> +	blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> +	blk_queue_discard_granularity(q, 0);
> +	q->limits.max_discard_sectors = 0;
> +	q->limits.max_write_zeroes_sectors = 0;
>  }
>  
>  static void fixup_discard_if_not_supported(struct request_queue *q)
> @@ -1273,7 +1277,6 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
>  	unsigned int max_segments = 0;
>  	struct request_queue *b = NULL;
>  	struct disk_conf *dc;
> -	bool discard_zeroes_if_aligned = true;
>  
>  	if (bdev) {
>  		b = bdev->backing_bdev->bd_disk->queue;
> @@ -1282,7 +1285,6 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
>  		rcu_read_lock();
>  		dc = rcu_dereference(device->ldev->disk_conf);
>  		max_segments = dc->max_bio_bvecs;
> -		discard_zeroes_if_aligned = dc->discard_zeroes_if_aligned;
>  		rcu_read_unlock();
>  
>  		blk_set_stacking_limits(&q->limits);
> @@ -1292,7 +1294,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
>  	/* This is the workaround for "bio would need to, but cannot, be split" */
>  	blk_queue_max_segments(q, max_segments ? max_segments : BLK_MAX_SEGMENTS);
>  	blk_queue_segment_boundary(q, PAGE_SIZE-1);
> -	decide_on_discard_support(device, q, b, discard_zeroes_if_aligned);
> +	decide_on_discard_support(device, bdev);
>  
>  	if (b) {
>  		blk_stack_limits(&q->limits, &b->limits, 0);

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
