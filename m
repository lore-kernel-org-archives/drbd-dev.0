Return-Path: <yukuai1@huaweicloud.com>
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com
	[45.249.212.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A7BD342060E
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 12:48:46 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tjz0M4wT3z4f3jQY
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 19:29:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 03FC71A0568
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 19:29:11 +0800 (CST)
Subject: Re: [PATCH 06/16] md/raid1: use the atomic queue limit update APIs
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <20240226103004.281412-1-hch@lst.de>
	<20240226103004.281412-7-hch@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b4828284-87ec-693b-e2c3-84bdafcbda65@huaweicloud.com>
Date: Mon, 26 Feb 2024 19:29:08 +0800
MIME-Version: 1.0
In-Reply-To: <20240226103004.281412-7-hch@lst.de>
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
> Build the queue limits outside the queue and apply them using
> queue_limits_set.  Also remove the bogus ->gendisk and ->queue NULL
> checks in the are while touching it.

The checking of mddev->gendisk can't be removed, because this is used to
distinguish dm-raid and md/raid. And the same for following patches.

Thanks,
Kuai

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/md/raid1.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 286f8b16c7bde7..752ff99736a636 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1791,10 +1791,9 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   	for (mirror = first; mirror <= last; mirror++) {
>   		p = conf->mirrors + mirror;
>   		if (!p->rdev) {
> -			if (mddev->gendisk)
> -				disk_stack_limits(mddev->gendisk, rdev->bdev,
> -						  rdev->data_offset << 9);
> -
> +			err = mddev_stack_new_rdev(mddev, rdev);
> +			if (err)
> +				return err;
>   			p->head_position = 0;
>   			rdev->raid_disk = mirror;
>   			err = 0;
> @@ -3089,9 +3088,9 @@ static struct r1conf *setup_conf(struct mddev *mddev)
>   static void raid1_free(struct mddev *mddev, void *priv);
>   static int raid1_run(struct mddev *mddev)
>   {
> +	struct queue_limits lim;
>   	struct r1conf *conf;
>   	int i;
> -	struct md_rdev *rdev;
>   	int ret;
>   
>   	if (mddev->level != 1) {
> @@ -3118,15 +3117,12 @@ static int raid1_run(struct mddev *mddev)
>   	if (IS_ERR(conf))
>   		return PTR_ERR(conf);
>   
> -	if (mddev->queue)
> -		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
> -
> -	rdev_for_each(rdev, mddev) {
> -		if (!mddev->gendisk)
> -			continue;
> -		disk_stack_limits(mddev->gendisk, rdev->bdev,
> -				  rdev->data_offset << 9);
> -	}
> +	blk_set_stacking_limits(&lim);
> +	lim.max_write_zeroes_sectors = 0;
> +	mddev_stack_rdev_limits(mddev, &lim);
> +	ret = queue_limits_set(mddev->queue, &lim);
> +	if (ret)
> +		goto abort;
>   
>   	mddev->degraded = 0;
>   	for (i = 0; i < conf->raid_disks; i++)
> 

