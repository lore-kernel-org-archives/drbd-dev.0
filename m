Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id ECD82420426
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:42 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id l10so12264076wrr.10
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:42 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	d11sm14283898wrm.64.2020.06.13.02.58.41
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:42 -0700 (PDT)
Resent-Message-ID: <20200613095840.GW4222@soda.linbit>
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net
	[5.45.199.163])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 402E94202C3
	for <drbd-dev@lists.linbit.com>; Mon, 25 May 2020 14:35:09 +0200 (CEST)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20200525113014.345997-1-hch@lst.de>
	<20200525113014.345997-2-hch@lst.de>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <fafb94a9-cdce-5ea0-e73f-9463766a9f19@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200525113014.345997-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Cc: linux-nvdimm@lists.01.org, linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>, dm-devel@redhat.com,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 01/16] block: add disk/bio-based accounting
	helpers
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
Date: Sat, 13 Jun 2020 10:19:18 -0000

On 25/05/2020 14.29, Christoph Hellwig wrote:
> Add two new helpers to simplify I/O accounting for bio based drivers.
> Currently these drivers use the generic_start_io_acct and
> generic_end_io_acct helpers which have very cumbersome calling
> conventions, don't actually return the time they started accounting,
> and try to deal with accounting for partitions, which can't happen
> for bio based drivers.  The new helpers will be used to subsequently
> replace uses of the old helpers.
> 
> The main function is the bio based wrappes in blkdev.h, but for zram
> which wants to account rw_page based I/O lower level routines are
> provided as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c       | 34 ++++++++++++++++++++++++++++++++++
>   include/linux/blkdev.h | 26 ++++++++++++++++++++++++++
>   2 files changed, 60 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 77e57c2e8d602..8973104f88d90 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1432,6 +1432,40 @@ void blk_account_io_start(struct request *rq, bool new_io)
>   	part_stat_unlock();
>   }
>   
> +unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
> +		unsigned int op)
> +{
> +	struct hd_struct *part = &disk->part0;
> +	const int sgrp = op_stat_group(op);
> +	unsigned long now = READ_ONCE(jiffies);
> +
> +	part_stat_lock();
> +	update_io_ticks(part, now, false);
> +	part_stat_inc(part, ios[sgrp]);
> +	part_stat_add(part, sectors[sgrp], sectors);
> +	part_stat_local_inc(part, in_flight[op_is_write(op)]);
> +	part_stat_unlock();
> +
> +	return now;
> +}
> +EXPORT_SYMBOL(disk_start_io_acct);
> +
> +void disk_end_io_acct(struct gendisk *disk, unsigned int op,
> +		unsigned long start_time)
> +{
> +	struct hd_struct *part = &disk->part0;
> +	const int sgrp = op_stat_group(op);
> +	unsigned long now = READ_ONCE(jiffies);
> +	unsigned long duration = now - start_time;

I think it would be better to leave this jiffies legacy nonsense in
callers and pass here request duration in nanoseconds.

So rewriting them to nanoseconds later wouldn't touch generic code.

> +
> +	part_stat_lock();
> +	update_io_ticks(part, now, true);
> +	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
> +	part_stat_local_dec(part, in_flight[op_is_write(op)]);
> +	part_stat_unlock();
> +}
> +EXPORT_SYMBOL(disk_end_io_acct);
> +
>   /*
>    * Steal bios from a request and add them to a bio list.
>    * The request must not have been partially completed before.
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 7d10f4e632325..76d01a8a13b80 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1892,4 +1892,30 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
>   		wake_up_process(waiter);
>   }
>   
> +unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
> +		unsigned int op);
> +void disk_end_io_acct(struct gendisk *disk, unsigned int op,
> +		unsigned long start_time);
> +
> +/**
> + * bio_start_io_acct - start I/O accounting for bio based drivers
> + * @bio:	bio to start account for
> + *
> + * Returns the start time that should be passed back to bio_end_io_acct().
> + */
> +static inline unsigned long bio_start_io_acct(struct bio *bio)
> +{
> +	return disk_start_io_acct(bio->bi_disk, bio_sectors(bio), bio_op(bio));
> +}
> +
> +/**
> + * bio_end_io_acct - end I/O accounting for bio based drivers
> + * @bio:	bio to end account for
> + * @start:	start time returned by bio_start_io_acct()
> + */
> +static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
> +{
> +	return disk_end_io_acct(bio->bi_disk, bio_op(bio), start_time);
> +}
> +
>   #endif
> 
