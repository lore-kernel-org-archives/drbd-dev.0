Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
	[209.85.218.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DFB9C4210C8
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 12:09:23 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id nb11so34395374ejc.5
	for <drbd-dev@lists.linbit.com>; Wed, 05 Oct 2022 03:09:23 -0700 (PDT)
Message-ID: <e23e94f8-13ad-4a10-62de-33e63a62831f@linbit.com>
Date: Wed, 5 Oct 2022 12:09:21 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
References: <20221005050027.39591-1-kch@nvidia.com>
	<20221005050027.39591-6-kch@nvidia.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221005050027.39591-6-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: vincent.fu@samsung.com, vigneshr@ti.com, philipp.reisner@linbit.com,
	linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
	jinpu.wang@ionos.com, tim@cyberelk.net,
	drbd-dev@lists.linbit.com, bvanassche@acm.org, richard@nod.at,
	damien.lemoal@opensource.wdc.com, shinichiro.kawasaki@wdc.com,
	ogeert@linux-m68k.org, josef@toxicpanda.com, efremov@linux.com,
	nbd@other.debian.org, linux-block@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, hare@suse.de,
	ming.lei@redhat.com, axboe@kernel.dk, johannes.thumshirn@wdc.com,
	linux-kernel@vger.kernel.org, mcgrof@kernel.org,
	haris.iqbal@ionos.com, lars.ellenberg@linbit.com
Subject: Re: [Drbd-dev] [RFC PATCH 05/18] drbd: use init disk helper
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

Am 05.10.22 um 07:00 schrieb Chaitanya Kulkarni:
> Add and use the helper to initialize the common fields of struct gendisk
> such as major, first_minor, minors, disk_name, private_data, and ops.
> This initialization is spread all over the block drivers. This avoids
> code repetation of inialization code of gendisk in current block drivers
> and any future ones.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/drbd/drbd_main.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index f3e4db16fd07..58fae122de16 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2706,13 +2706,9 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>  
>  	set_disk_ro(disk, true);
>  
> -	disk->major = DRBD_MAJOR;
> -	disk->first_minor = minor;
> -	disk->minors = 1;
> -	disk->fops = &drbd_ops;
>  	disk->flags |= GENHD_FL_NO_PART;
>  	sprintf(disk->disk_name, "drbd%d", minor);
> -	disk->private_data = device;
> +	init_disk(disk, DRBD_MAJOR, minor, 1, 0, device, &drbd_ops);
>  
>  	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
>  	blk_queue_write_cache(disk->queue, true, true);

This now does a set_capacity(..., 0), which it did not do before.
I'm guessing this does not have any side effects as the capacity should
already be initialized to 0? Do you know this for sure?

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
