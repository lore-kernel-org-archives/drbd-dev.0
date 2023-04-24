Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
	[209.85.128.48])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BE1E1420358
	for <drbd-dev@lists.linbit.com>; Mon, 24 Apr 2023 10:26:32 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
	5b1f17b1804b1-3f195b164c4so15950965e9.1
	for <drbd-dev@lists.linbit.com>; Mon, 24 Apr 2023 01:26:32 -0700 (PDT)
Message-ID: <42c89d18-b68f-a7d0-921a-6f45b54da356@linbit.com>
Date: Mon, 24 Apr 2023 10:26:30 +0200
MIME-Version: 1.0
To: Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	hch@infradead.org, djwong@kernel.org, minchan@kernel.org,
	senozhatsky@chromium.org
References: <20230421195807.2804512-1-mcgrof@kernel.org>
	<20230421195807.2804512-3-mcgrof@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20230421195807.2804512-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: p.raghav@samsung.com, linux-xfs@vger.kernel.org, da.gomez@samsung.com,
	patches@lists.linux.dev, willy@infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, dm-devel@redhat.com, hare@suse.de,
	linux-fsdevel@vger.kernel.org, kbusch@kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/5] drbd: use PAGE_SECTORS_SHIFT and
	PAGE_SECTORS
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

Am 21.04.23 um 21:58 schrieb Luis Chamberlain:
> Replace common constants with generic versions.
> This produces no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/block/drbd/drbd_bitmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
> index 6ac8c54b44c7..b556e6634f13 100644
> --- a/drivers/block/drbd/drbd_bitmap.c
> +++ b/drivers/block/drbd/drbd_bitmap.c
> @@ -1000,7 +1000,7 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
>  	unsigned int len;
>  
>  	first_bm_sect = device->ldev->md.md_offset + device->ldev->md.bm_offset;
> -	on_disk_sector = first_bm_sect + (((sector_t)page_nr) << (PAGE_SHIFT-SECTOR_SHIFT));
> +	on_disk_sector = first_bm_sect + (((sector_t)page_nr) << PAGE_SECTORS_SHIFT);
>  
>  	/* this might happen with very small
>  	 * flexible external meta data device,
> @@ -1008,7 +1008,7 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
>  	last_bm_sect = drbd_md_last_bitmap_sector(device->ldev);
>  	if (first_bm_sect <= on_disk_sector && last_bm_sect >= on_disk_sector) {
>  		sector_t len_sect = last_bm_sect - on_disk_sector + 1;
> -		if (len_sect < PAGE_SIZE/SECTOR_SIZE)
> +		if (len_sect < PAGE_SECTORS)
>  			len = (unsigned int)len_sect*SECTOR_SIZE;
>  		else
>  			len = PAGE_SIZE;

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
