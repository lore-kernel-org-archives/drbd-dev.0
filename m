Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0D02D1055F56
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id F1E8A1B4369
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:46 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lxjvYFYB-wj1 for <drbd-dev@lists.linbit.com>;
	Thu, 26 Jul 2012 11:35:46 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id D738F1B4368
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:46 +0200 (CEST)
Resent-Message-ID: <20120726093546.GX29767@soda.linbit>
Received: from natasha.panasas.com (natasha.panasas.com [67.152.220.90])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E598D1019A78
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2012 13:19:13 +0200 (CEST)
Message-ID: <500FD32F.2010809@panasas.com>
Date: Wed, 25 Jul 2012 14:06:23 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
To: Kent Overstreet <koverstreet@google.com>
References: <1343160689-12378-1-git-send-email-koverstreet@google.com>
	<1343160689-12378-2-git-send-email-koverstreet@google.com>
In-Reply-To: <1343160689-12378-2-git-send-email-koverstreet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v4 01/12] block: Generalized bio pool freeing
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 07/24/2012 11:11 PM, Kent Overstreet wrote:

> With the old code, when you allocate a bio from a bio pool you have to
> implement your own destructor that knows how to find the bio pool the
> bio was originally allocated from.
> 
> This adds a new field to struct bio (bi_pool) and changes
> bio_alloc_bioset() to use it. This makes various bio destructors
> unnecessary, so they're then deleted.
> 
> Signed-off-by: Kent Overstreet <koverstreet@google.com>

<snip>

> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
> index fd47950..be65582 100644
> --- a/drivers/target/target_core_iblock.c
> +++ b/drivers/target/target_core_iblock.c
> @@ -447,14 +447,6 @@ static void iblock_complete_cmd(struct se_cmd *cmd)
>  	kfree(ibr);
>  }
>  
> -static void iblock_bio_destructor(struct bio *bio)
> -{
> -	struct se_cmd *cmd = bio->bi_private;
> -	struct iblock_dev *ib_dev = cmd->se_dev->dev_ptr;
> -
> -	bio_free(bio, ib_dev->ibd_bio_set);
> -}
> -
>  static struct bio *
>  iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num)
>  {
> @@ -475,8 +467,15 @@ iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num)
>  	}
>  
>  	bio->bi_bdev = ib_dev->ibd_bd;
> +<<<<<<< HEAD
>  	bio->bi_private = cmd;
>  	bio->bi_destructor = iblock_bio_destructor;
> +||||||| merged common ancestors
> +	bio->bi_private = task;
> +	bio->bi_destructor = iblock_bio_destructor;
> +=======
> +	bio->bi_private = task;
> +>>>>>>> block: Generalized bio pool freeing
>  	bio->bi_end_io = &iblock_bio_done;
>  	bio->bi_sector = lba;
>  	return bio;


You left out a rebase merge conflict. Did you allmodconfig compile
these patches?

Boaz

> diff --git a/fs/bio.c b/fs/bio.c
> index 73922ab..1c6c8b7 100644
> --- a/fs/bio.c
> +++ b/fs/bio.c
> @@ -271,10 +271,6 @@ EXPORT_SYMBOL(bio_init);
>   *   bio_alloc_bioset will try its own mempool to satisfy the allocation.
>   *   If %__GFP_WAIT is set then we will block on the internal pool waiting
>   *   for a &struct bio to become free.
> - *
> - *   Note that the caller must set ->bi_destructor on successful return
> - *   of a bio, to do the appropriate freeing of the bio once the reference
> - *   count drops to zero.
>   **/
>  struct bio *bio_alloc_bioset(gfp_t gfp_mask, int nr_iovecs, struct bio_set *bs)
>  {
> @@ -289,6 +285,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, int nr_iovecs, struct bio_set *bs)
>  	bio = p + bs->front_pad;
>  
>  	bio_init(bio);
> +	bio->bi_pool = bs;
>  
>  	if (unlikely(!nr_iovecs))
>  		goto out_set;
> @@ -315,11 +312,6 @@ err_free:
>  }
>  EXPORT_SYMBOL(bio_alloc_bioset);
>  
> -static void bio_fs_destructor(struct bio *bio)
> -{
> -	bio_free(bio, fs_bio_set);
> -}
> -
>  /**
>   *	bio_alloc - allocate a new bio, memory pool backed
>   *	@gfp_mask: allocation mask to use
> @@ -341,12 +333,7 @@ static void bio_fs_destructor(struct bio *bio)
>   */
>  struct bio *bio_alloc(gfp_t gfp_mask, unsigned int nr_iovecs)
>  {
> -	struct bio *bio = bio_alloc_bioset(gfp_mask, nr_iovecs, fs_bio_set);
> -
> -	if (bio)
> -		bio->bi_destructor = bio_fs_destructor;
> -
> -	return bio;
> +	return bio_alloc_bioset(gfp_mask, nr_iovecs, fs_bio_set);
>  }
>  EXPORT_SYMBOL(bio_alloc);
>  
> @@ -422,7 +409,11 @@ void bio_put(struct bio *bio)
>  	if (atomic_dec_and_test(&bio->bi_cnt)) {
>  		bio_disassociate_task(bio);
>  		bio->bi_next = NULL;
> -		bio->bi_destructor(bio);
> +
> +		if (bio->bi_pool)
> +			bio_free(bio, bio->bi_pool);
> +		else
> +			bio->bi_destructor(bio);
>  	}
>  }
>  EXPORT_SYMBOL(bio_put);
> @@ -473,12 +464,11 @@ EXPORT_SYMBOL(__bio_clone);
>   */
>  struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
>  {
> -	struct bio *b = bio_alloc_bioset(gfp_mask, bio->bi_max_vecs, fs_bio_set);
> +	struct bio *b = bio_alloc(gfp_mask, bio->bi_max_vecs);
>  
>  	if (!b)
>  		return NULL;
>  
> -	b->bi_destructor = bio_fs_destructor;
>  	__bio_clone(b, bio);
>  
>  	if (bio_integrity(bio)) {
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 0edb65d..293547e 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -80,6 +80,9 @@ struct bio {
>  	struct bio_integrity_payload *bi_integrity;  /* data integrity */
>  #endif
>  
> +	/* If bi_pool is non NULL, bi_destructor is not called */
> +	struct bio_set		*bi_pool;
> +
>  	bio_destructor_t	*bi_destructor;	/* destructor */
>  
>  	/*


