Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B6C761055F6A
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id AD64B1B4368
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:49 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bYtCYqFB2rq0 for <drbd-dev@lists.linbit.com>;
	Thu, 26 Jul 2012 11:35:49 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 8E51E1B4369
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:49 +0200 (CEST)
Resent-Message-ID: <20120726093549.GD29767@soda.linbit>
Received: from natasha.panasas.com (natasha.panasas.com [67.152.220.90])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E7633100542F
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2012 14:06:10 +0200 (CEST)
Message-ID: <500FE114.1000707@panasas.com>
Date: Wed, 25 Jul 2012 15:05:40 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
To: Kent Overstreet <koverstreet@google.com>
References: <1343160689-12378-1-git-send-email-koverstreet@google.com>
	<1343160689-12378-11-git-send-email-koverstreet@google.com>
In-Reply-To: <1343160689-12378-11-git-send-email-koverstreet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v4 10/12] block: Add bio_clone_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 07/24/2012 11:11 PM, Kent Overstreet wrote:

ACK-by: Boaz Harrosh <bharrosh@panasas.com>

> Signed-off-by: Kent Overstreet <koverstreet@google.com>


Thanks looks nice

> ---
>  drivers/block/osdblk.c |    3 +--
>  fs/bio.c               |   13 +++++++++++++
>  fs/exofs/ore.c         |    5 ++---
>  include/linux/bio.h    |    1 +
>  4 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/osdblk.c b/drivers/block/osdblk.c
> index 87311eb..1bbc681 100644
> --- a/drivers/block/osdblk.c
> +++ b/drivers/block/osdblk.c
> @@ -266,11 +266,10 @@ static struct bio *bio_chain_clone(struct bio *old_chain, gfp_t gfpmask)
>  	struct bio *tmp, *new_chain = NULL, *tail = NULL;
>  
>  	while (old_chain) {
> -		tmp = bio_kmalloc(gfpmask, old_chain->bi_max_vecs);
> +		tmp = bio_clone_kmalloc(old_chain, gfpmask);
>  		if (!tmp)
>  			goto err_out;
>  
> -		__bio_clone(tmp, old_chain);
>  		tmp->bi_bdev = NULL;
>  		gfpmask &= ~__GFP_WAIT;
>  		tmp->bi_next = NULL;
> diff --git a/fs/bio.c b/fs/bio.c
> index fa6dee4..9d0ceb2 100644
> --- a/fs/bio.c
> +++ b/fs/bio.c
> @@ -499,6 +499,19 @@ struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(bio_clone);
>  
> +struct bio *bio_clone_kmalloc(struct bio *bio, gfp_t gfp_mask)
> +{
> +	struct bio *b = bio_kmalloc(gfp_mask, bio->bi_max_vecs);
> +
> +	if (!b)
> +		return NULL;
> +
> +	__bio_clone(b, bio);
> +
> +	return b;
> +}
> +EXPORT_SYMBOL(bio_clone_kmalloc);
> +
>  /**
>   *	bio_get_nr_vecs		- return approx number of vecs
>   *	@bdev:  I/O target
> diff --git a/fs/exofs/ore.c b/fs/exofs/ore.c
> index 24a49d4..a8d92fc 100644
> --- a/fs/exofs/ore.c
> +++ b/fs/exofs/ore.c
> @@ -814,8 +814,8 @@ static int _write_mirror(struct ore_io_state *ios, int cur_comp)
>  			struct bio *bio;
>  
>  			if (per_dev != master_dev) {
> -				bio = bio_kmalloc(GFP_KERNEL,
> -						  master_dev->bio->bi_max_vecs);
> +				bio = bio_clone_kmalloc(master_dev->bio,
> +							GFP_KERNEL);
>  				if (unlikely(!bio)) {
>  					ORE_DBGMSG(
>  					      "Failed to allocate BIO size=%u\n",
> @@ -824,7 +824,6 @@ static int _write_mirror(struct ore_io_state *ios, int cur_comp)
>  					goto out;
>  				}
>  
> -				__bio_clone(bio, master_dev->bio);
>  				bio->bi_bdev = NULL;
>  				bio->bi_next = NULL;
>  				per_dev->offset = master_dev->offset;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 9720544..e180f1d 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -221,6 +221,7 @@ extern int bio_phys_segments(struct request_queue *, struct bio *);
>  
>  extern void __bio_clone(struct bio *, struct bio *);
>  extern struct bio *bio_clone(struct bio *, gfp_t);
> +struct bio *bio_clone_kmalloc(struct bio *, gfp_t);
>  
>  extern void bio_init(struct bio *);
>  extern void bio_reset(struct bio *);


