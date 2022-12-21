Return-Path: <kbusch@kernel.org>
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 316664220C2
	for <drbd-dev@lists.linbit.com>; Wed, 21 Dec 2022 18:09:06 +0100 (CET)
Date: Wed, 21 Dec 2022 10:09:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Message-ID: <Y6M9rJbw3ZMvOeDr@kbusch-mbp.dhcp.thefacebook.com>
References: <20221221040506.1174644-1-gulam.mohamed@oracle.com>
	<20221221040506.1174644-2-gulam.mohamed@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221040506.1174644-2-gulam.mohamed@oracle.com>
Cc: nvdimm@lists.linux.dev, shminderjit.singh@oracle.com,
	linux-kernel@vger.kernel.org, song@kernel.org,
	dm-devel@redhat.com, ira.weiny@intel.com, agk@redhat.com,
	drbd-dev@lists.linbit.com, dave.jiang@intel.com,
	minchan@kernel.org, vishal.l.verma@intel.com,
	konrad.wilk@oracle.com, joe.jin@oracle.com,
	kent.overstreet@gmail.com, ngupta@vflare.org, kch@nvidia.com,
	senozhatsky@chromium.org, snitzer@kernel.org, colyli@suse.de,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	dan.j.williams@intel.com, axboe@kernel.dk,
	linux-raid@vger.kernel.org, martin.petersen@oracle.com,
	rajesh.sivaramasubramaniom@oracle.com,
	philipp.reisner@linbit.com, junxiao.bi@oracle.com,
	lars.ellenberg@linbit.com
Subject: Re: [Drbd-dev] [PATCH for-6.2/block V3 2/2] block: Change the
 granularity of io ticks from ms to ns
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

On Wed, Dec 21, 2022 at 04:05:06AM +0000, Gulam Mohamed wrote:
> +u64  blk_get_iostat_ticks(struct request_queue *q)
> +{
> +       return (blk_queue_precise_io_stat(q) ? ktime_get_ns() : jiffies);
> +}
> +EXPORT_SYMBOL_GPL(blk_get_iostat_ticks);
> +
>  void update_io_ticks(struct block_device *part, u64 now, bool end)
>  {
>  	u64 stamp;
> @@ -968,20 +980,26 @@ EXPORT_SYMBOL(bdev_start_io_acct);
>  u64 bio_start_io_acct(struct bio *bio)
>  {
>  	return bdev_start_io_acct(bio->bi_bdev, bio_sectors(bio),
> -				  bio_op(bio), jiffies);
> +				  bio_op(bio),
> +				  blk_get_iostat_ticks(bio->bi_bdev->bd_queue));
>  }
>  EXPORT_SYMBOL_GPL(bio_start_io_acct);
>  
>  void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
>  		      u64 start_time)
>  {
> +	u64 now;
> +	u64 duration;
> +	struct request_queue *q = bdev_get_queue(bdev);
>  	const int sgrp = op_stat_group(op);
> -	u64 now = READ_ONCE(jiffies);
> -	u64 duration = (unsigned long)now -(unsigned long) start_time;
> +	now = blk_get_iostat_ticks(q);;

I don't think you can rely on the blk_queue_precise_io_stat() flag in
the completion side. The user can toggle this with data in flight, which
means the completion may use different tick units than the start. I
think you'll need to add a flag to the request in the start accounting
side to know which method to use for the completion.

> @@ -951,6 +951,7 @@ ssize_t part_stat_show(struct device *dev,
>  	struct request_queue *q = bdev_get_queue(bdev);
>  	struct disk_stats stat;
>  	unsigned int inflight;
> +	u64 stat_ioticks;
>  
>  	if (queue_is_mq(q))
>  		inflight = blk_mq_in_flight(q, bdev);
> @@ -959,10 +960,13 @@ ssize_t part_stat_show(struct device *dev,
>  
>  	if (inflight) {
>  		part_stat_lock();
> -		update_io_ticks(bdev, jiffies, true);
> +		update_io_ticks(bdev, blk_get_iostat_ticks(q), true);
>  		part_stat_unlock();
>  	}
>  	part_stat_read_all(bdev, &stat);
> +	stat_ioticks = (blk_queue_precise_io_stat(q) ?
> +				div_u64(stat.io_ticks, NSEC_PER_MSEC) :
> +				jiffies_to_msecs(stat.io_ticks));


With the user able to change the precision at will, I think these
io_ticks need to have a consistent unit size. Mixing jiffies and nsecs
is going to create garbage stats output. Could existing io_ticks using
jiffies be converted to jiffies_to_nsecs() so that you only have one
unit to consider?
