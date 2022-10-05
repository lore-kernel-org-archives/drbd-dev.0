Return-Path: <fthain@linux-m68k.org>
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
	[64.147.123.24])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C24A9421779
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 09:00:52 +0200 (CEST)
Date: Wed, 5 Oct 2022 17:54:48 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20221005050027.39591-16-kch@nvidia.com>
Message-ID: <78eb3d46-de71-a20c-ed5a-efc6ce71f571@linux-m68k.org>
References: <20221005050027.39591-1-kch@nvidia.com>
	<20221005050027.39591-16-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: vincent.fu@samsung.com, vigneshr@ti.com, philipp.reisner@linbit.com,
	haris.iqbal@ionos.com, miquel.raynal@bootlin.com,
	jinpu.wang@ionos.com, tim@cyberelk.net,
	drbd-dev@lists.linbit.com, bvanassche@acm.org, richard@nod.at,
	damien.lemoal@opensource.wdc.com, geert@linux-m68k.org,
	shinichiro.kawasaki@wdc.com, josef@toxicpanda.com,
	efremov@linux.com, nbd@other.debian.org,
	linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	hare@suse.de, ming.lei@redhat.com, axboe@kernel.dk,
	johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
	mcgrof@kernel.org, linux-mtd@lists.infradead.org, lars.ellenberg@linbit.com
Subject: Re: [Drbd-dev] [RFC PATCH 15/18] swim: use init disk helper
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

On Tue, 4 Oct 2022, Chaitanya Kulkarni wrote:

> Add and use the helper to initialize the common fields of struct gendisk
> such as major, first_minor, minors, disk_name, private_data, and ops.
> This initialization is spread all over the block drivers. This avoids
> code repetation of inialization code of gendisk in current block drivers
> and any future ones.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/swim.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 42b4b6828690..7fa4b2766367 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -835,15 +835,12 @@ static int swim_floppy_init(struct swim_priv *swd)
>  
>  	for (drive = 0; drive < swd->floppy_count; drive++) {
>  		swd->unit[drive].disk->flags = GENHD_FL_REMOVABLE;
> -		swd->unit[drive].disk->major = FLOPPY_MAJOR;
> -		swd->unit[drive].disk->first_minor = drive;
> -		swd->unit[drive].disk->minors = 1;
>  		sprintf(swd->unit[drive].disk->disk_name, "fd%d", drive);
> -		swd->unit[drive].disk->fops = &floppy_fops;
>  		swd->unit[drive].disk->flags |= GENHD_FL_NO_PART;
>  		swd->unit[drive].disk->events = DISK_EVENT_MEDIA_CHANGE;
>  		swd->unit[drive].disk->private_data = &swd->unit[drive];
> -		set_capacity(swd->unit[drive].disk, 2880);
> +		init_disk(swd->unit[drive].disk, FLOPPY_MAJOR, drive, 1, 2880,
> +				&swd->unit[drive], &floopy_dops);
>  		err = add_disk(swd->unit[drive].disk);
>  		if (err)
>  			goto exit_put_disks;
> 

You typo'd the ops struct. By inspection, I'd say your patches 11/18 and 
16/18 will not compile either.
