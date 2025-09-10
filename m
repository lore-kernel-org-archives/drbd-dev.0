Return-Path: <hare@suse.de>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 67C0416228C
	for <drbd-dev@lists.linbit.com>; Wed, 10 Sep 2025 16:28:12 +0200 (CEST)
Message-ID: <a0834448-35dd-401f-8d66-a957b8e160b2@suse.de>
Date: Wed, 10 Sep 2025 13:41:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] drbd: init
	queue_limits->max_hw_wzeroes_unmap_sectors parameter
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, drbd-dev@lists.linbit.com
References: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
	<20250910111107.3247530-3-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250910111107.3247530-3-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, pmenzel@molgen.mpg.de, martin.petersen@oracle.com,
	john.g.garry@oracle.com, yangerkun@huawei.com,
	yi.zhang@huawei.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, hch@lst.de
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

On 9/10/25 13:11, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The parameter max_hw_wzeroes_unmap_sectors in queue_limits should be
> equal to max_write_zeroes_sectors if it is set to a non-zero value.
> However, when the backend bdev is specified, this parameter is
> initialized to UINT_MAX during the call to blk_set_stacking_limits(),
> while only max_write_zeroes_sectors is adjusted. Therefore, this
> discrepancy triggers a value check failure in blk_validate_limits().
> 
> Since the drvd driver doesn't yet support unmap write zeroes, so fix
> this failure by explicitly setting max_hw_wzeroes_unmap_sectors to
> zero.
> 
> Fixes: 0c40d7cb5ef3 ("block: introduce max_{hw|user}_wzeroes_unmap_sectors to queue limits")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/block/drbd/drbd_nl.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index e09930c2b226..91f3b8afb63c 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1330,6 +1330,7 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device,
>   		lim.max_write_zeroes_sectors = DRBD_MAX_BBIO_SECTORS;
>   	else
>   		lim.max_write_zeroes_sectors = 0;
> +	lim.max_hw_wzeroes_unmap_sectors = 0;
>   
>   	if ((lim.discard_granularity >> SECTOR_SHIFT) >
>   	    lim.max_hw_discard_sectors) {
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
