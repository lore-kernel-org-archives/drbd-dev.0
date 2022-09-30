Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
	[209.85.208.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7EA264203DF
	for <drbd-dev@lists.linbit.com>; Fri, 30 Sep 2022 19:02:47 +0200 (CEST)
Received: by mail-ed1-f41.google.com with SMTP id a13so6817291edj.0
	for <drbd-dev@lists.linbit.com>; Fri, 30 Sep 2022 10:02:47 -0700 (PDT)
Message-ID: <10dbb972-a61a-6b89-b08b-d53e8a2a6cc7@linbit.com>
Date: Fri, 30 Sep 2022 19:02:45 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Michael D Labriola <veggiemike@sourceruckus.org>
References: <20220908211337.17090-1-veggiemike@sourceruckus.org>
	<20220908211337.17090-4-veggiemike@sourceruckus.org>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220908211337.17090-4-veggiemike@sourceruckus.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 3/3] drbd: use bio_alloc_clone() instead of
 bio_clone_fast()
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

Am 08.09.22 um 23:13 schrieb Michael D Labriola:
> Between 5.17 and 5.18, bio_clone_fast() was modified to take a
> block_device and the function was renamed.  This commit migrates to
> the new usage.
> 
> Upstream commits:
> abfc426d block: pass a block_device to bio_clone_fast
> 
> Signed-off-by: Michael D Labriola <veggiemike@sourceruckus.org>
> ---
>  drbd/drbd_req.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
> index fc7dfb8d..06ba8ce8 100644
> --- a/drbd/drbd_req.c
> +++ b/drbd/drbd_req.c
> @@ -1715,7 +1715,7 @@ drbd_request_prepare(struct drbd_device *device, struct bio *bio,
>  	req->start_jif = bio_start_io_acct(req->master_bio);
>  
>  	if (get_ldev(device)) {
> -		req->private_bio  = bio_clone_fast(bio, GFP_NOIO, &drbd_io_bio_set);
> +		req->private_bio  = bio_alloc_clone(bio->bi_bdev, bio, GFP_NOIO, &drbd_io_bio_set);
>  		req->private_bio->bi_private = req;
>  		req->private_bio->bi_end_io = drbd_request_endio;
>  	}

Thanks for the patch!

Applied as
https://github.com/LINBIT/drbd/commit/945b5e58ad1761c1f6e874e0db7aee7f42d11827.

(And fixed up in
https://github.com/LINBIT/drbd/commit/7e7111b94b8ef100a6e3b5fea084105122ad0546
;)

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
