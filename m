Return-Path: <yukuai1@huaweicloud.com>
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com
	[45.249.212.56])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DA1264205DE
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 12:38:22 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TjzBs4yYbz4f3jLw
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 19:38:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D9C671A0172
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 19:38:18 +0800 (CST)
Subject: Re: [PATCH 04/16] md: add queue limit helpers
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <20240226103004.281412-1-hch@lst.de>
	<20240226103004.281412-5-hch@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6eb1741e-f336-bfb1-6549-21374ee667fc@huaweicloud.com>
Date: Mon, 26 Feb 2024 19:38:17 +0800
MIME-Version: 1.0
In-Reply-To: <20240226103004.281412-5-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, "yukuai \(C\)" <yukuai3@huawei.com>,
	drbd-dev@lists.linbit.com
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

  Hi,

ÔÚ 2024/02/26 18:29, Christoph Hellwig Ð´µÀ:
> Add a few helpers that wrap the block queue limits API for use in MD.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/md/md.c | 37 +++++++++++++++++++++++++++++++++++++
>   drivers/md/md.h |  3 +++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 75266c34b1f99b..23823823f80c6b 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -5699,6 +5699,43 @@ static const struct kobj_type md_ktype = {
>   
>   int mdp_major = 0;
>   
> +/* stack the limit for all rdevs into lim */
> +void mddev_stack_rdev_limits(struct mddev *mddev, struct queue_limits *lim)
> +{
> +	struct md_rdev *rdev;
> +
> +	rdev_for_each(rdev, mddev) {
> +		queue_limits_stack_bdev(lim, rdev->bdev, rdev->data_offset,
> +					mddev->gendisk->disk_name);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mddev_stack_rdev_limits);
> +
> +/* apply the extra stacking limits from a new rdev into mddev */
> +int mddev_stack_new_rdev(struct mddev *mddev, struct md_rdev *rdev)
> +{
> +	struct queue_limits lim = queue_limits_start_update(mddev->queue);
> +
> +	queue_limits_stack_bdev(&lim, rdev->bdev, rdev->data_offset,
> +				mddev->gendisk->disk_name);
> +	return queue_limits_commit_update(mddev->queue, &lim);
> +}
> +EXPORT_SYMBOL_GPL(mddev_stack_new_rdev);
> +
> +/* update the optimal I/O size after a reshape */
> +void mddev_update_io_opt(struct mddev *mddev, unsigned int nr_stripes)
> +{
> +	struct queue_limits lim;
> +	int ret;
> +
> +	blk_mq_freeze_queue(mddev->queue);
> +	lim = queue_limits_start_update(mddev->queue);
> +	lim.io_opt = lim.io_min * nr_stripes;
> +	ret = queue_limits_commit_update(mddev->queue, &lim);
> +	blk_mq_unfreeze_queue(mddev->queue);

Any reason to use blk_mq_freeze/unfreeze_queue ? I don't think this is
meaningful for raid, this only wait for IO submission, not IO done.

raid should already handle concurrent IO with reshape, so I think this
can just be removed.

Thanks,
Kuai

> +}
> +EXPORT_SYMBOL_GPL(mddev_update_io_opt);
> +
>   static void mddev_delayed_delete(struct work_struct *ws)
>   {
>   	struct mddev *mddev = container_of(ws, struct mddev, del_work);
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 8d881cc597992f..25b19614aa3239 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -860,6 +860,9 @@ void md_autostart_arrays(int part);
>   int md_set_array_info(struct mddev *mddev, struct mdu_array_info_s *info);
>   int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info);
>   int do_md_run(struct mddev *mddev);
> +void mddev_stack_rdev_limits(struct mddev *mddev, struct queue_limits *lim);
> +int mddev_stack_new_rdev(struct mddev *mddev, struct md_rdev *rdev);
> +void mddev_update_io_opt(struct mddev *mddev, unsigned int nr_stripes);
>   
>   extern const struct block_device_operations md_fops;
>   
> 

