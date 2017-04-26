Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1F9591057FB2
	for <drbd-dev@lists.linbit.com>; Wed, 26 Apr 2017 15:24:38 +0200 (CEST)
Received: by mail-wm0-f42.google.com with SMTP id m123so4277613wma.0
	for <drbd-dev@lists.linbit.com>; Wed, 26 Apr 2017 06:24:38 -0700 (PDT)
Date: Wed, 26 Apr 2017 15:24:36 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Heloise <os@iscas.ac.cn>
Message-ID: <20170426132436.GA15697@soda.linbit>
References: <1493200177-10699-1-git-send-email-os@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493200177-10699-1-git-send-email-os@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd:fix null pointer deref in
	_drbd_md_sync_page_io
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Apr 26, 2017 at 02:49:37AM -0700, Heloise wrote:
> The return value of bio_alloc_drbd can be NULL and is used without

No, apparently it cannot, because it is basically a mempool_alloc()
with GFP_NOIO, it may sleep, but it will loop "forever" and not return NULL.

So rather fix that nonsense in bio_alloc_drbd, see below:

Thanks,

    Lars

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 92c60cb..9ffd940 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -150,15 +150,10 @@ static const struct block_device_operations drbd_ops = {
 
 struct bio *bio_alloc_drbd(gfp_t gfp_mask)
 {
-	struct bio *bio;
-
 	if (!drbd_md_io_bio_set)
 		return bio_alloc(gfp_mask, 1);
 
-	bio = bio_alloc_bioset(gfp_mask, 1, drbd_md_io_bio_set);
-	if (!bio)
-		return NULL;
-	return bio;
+	return bio_alloc_bioset(gfp_mask, 1, drbd_md_io_bio_set);
 }
 
 #ifdef __CHECKER__


> validation, which may cause null-pointer dereference, fix it.
> 
> Signed-off-by: Heloise <os@iscas.ac.cn>
> ---
>  drivers/block/drbd/drbd_actlog.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
> index 8d7bcfa..d6bb30e 100644
> --- a/drivers/block/drbd/drbd_actlog.c
> +++ b/drivers/block/drbd/drbd_actlog.c
> @@ -151,6 +151,10 @@ static int _drbd_md_sync_page_io(struct drbd_device *device,
>  	op_flags |= REQ_SYNC;
>  
>  	bio = bio_alloc_drbd(GFP_NOIO);
> +	if (!bio) {
> +		err = -ENOMEM;
> +		return err;
> +	}
>  	bio->bi_bdev = bdev->md_bdev;
>  	bio->bi_iter.bi_sector = sector;
>  	err = -EIO;
> -- 
> 2.1.0


