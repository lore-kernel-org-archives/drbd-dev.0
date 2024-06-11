Return-Path: <hare@suse.de>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 67321420918
	for <drbd-dev@lists.linbit.com>; Tue, 11 Jun 2024 10:18:21 +0200 (CEST)
Message-ID: <4032635d-a17f-44e5-a547-b175fa271945@suse.de>
Date: Tue, 11 Jun 2024 10:12:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 02/26] sd: move zone limits setup out of
	sd_read_block_characteristics
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20240611051929.513387-1-hch@lst.de>
	<20240611051929.513387-3-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240611051929.513387-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: nvdimm@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, linux-mtd@lists.infradead.org,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yu Kuai <yukuai3@huawei.com>, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, Mike Snitzer <snitzer@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-mmc@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	virtualization@lists.linux.dev, Lars Ellenberg <lars.ellenberg@linbit.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
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

On 6/11/24 07:19, Christoph Hellwig wrote:
> Move a bit of code that sets up the zone flag and the write granularity
> into sd_zbc_read_zones to be with the rest of the zoned limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/sd.c     | 21 +--------------------
>   drivers/scsi/sd_zbc.c | 13 ++++++++++++-
>   2 files changed, 13 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 85b45345a27739..5bfed61c70db8f 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3308,29 +3308,10 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp,
>   		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
>   	}
>   
> -
> -#ifdef CONFIG_BLK_DEV_ZONED /* sd_probe rejects ZBD devices early otherwise */
> -	if (sdkp->device->type == TYPE_ZBC) {
> -		lim->zoned = true;
> -
> -		/*
> -		 * Per ZBC and ZAC specifications, writes in sequential write
> -		 * required zones of host-managed devices must be aligned to
> -		 * the device physical block size.
> -		 */
> -		lim->zone_write_granularity = sdkp->physical_block_size;
> -	} else {
> -		/*
> -		 * Host-aware devices are treated as conventional.
> -		 */
> -		lim->zoned = false;
> -	}
> -#endif /* CONFIG_BLK_DEV_ZONED */
> -
>   	if (!sdkp->first_scan)
>   		return;
>   
> -	if (lim->zoned)
> +	if (sdkp->device->type == TYPE_ZBC)

Why not sd_is_zoned()?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

