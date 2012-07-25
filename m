Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 606FC1055F61
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 575181B4369
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:48 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ilngPGM0rbsj for <drbd-dev@lists.linbit.com>;
	Thu, 26 Jul 2012 11:35:48 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 390111B4368
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:48 +0200 (CEST)
Resent-Message-ID: <20120726093548.GA29767@soda.linbit>
Received: from natasha.panasas.com (natasha.panasas.com [67.152.220.90])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C18401005438
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2012 13:40:23 +0200 (CEST)
Message-ID: <500FDB0D.4070605@panasas.com>
Date: Wed, 25 Jul 2012 14:39:57 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
To: Kent Overstreet <koverstreet@google.com>
References: <1343160689-12378-1-git-send-email-koverstreet@google.com>
	<1343160689-12378-6-git-send-email-koverstreet@google.com>
In-Reply-To: <1343160689-12378-6-git-send-email-koverstreet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v4 05/12] block: Kill bi_destructor
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 07/24/2012 11:11 PM, Kent Overstreet wrote:

> Now that we've got generic code for freeing bios allocated from bio
> pools, this isn't needed anymore.
> 
> This also changes the semantics of bio_free() a bit - it now also frees
> bios allocated by bio_kmalloc(). It's also no longer exported, as
> without bi_destructor there should be no need for it to be called
> anywhere else.
> 
> Signed-off-by: Kent Overstreet <koverstreet@google.com>

<snip>

> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
> index be65582..9338d0602 100644
> --- a/drivers/target/target_core_iblock.c
> +++ b/drivers/target/target_core_iblock.c
> @@ -467,15 +467,7 @@ iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num)
>  	}
>  
>  	bio->bi_bdev = ib_dev->ibd_bd;
> -<<<<<<< HEAD
>  	bio->bi_private = cmd;
> -	bio->bi_destructor = iblock_bio_destructor;
> -||||||| merged common ancestors
> -	bio->bi_private = task;
> -	bio->bi_destructor = iblock_bio_destructor;
> -=======
> -	bio->bi_private = task;
> ->>>>>>> block: Generalized bio pool freeing
>  	bio->bi_end_io = &iblock_bio_done;
>  	bio->bi_sector = lba;
>  	return bio;


Merge conflict allmodconfig compilation please?

> diff --git a/fs/bio.c b/fs/bio.c
> index 252e253..a301071 100644
> --- a/fs/bio.c
> +++ b/fs/bio.c
> @@ -56,6 +56,9 @@ static struct biovec_slab bvec_slabs[BIOVEC_NR_POOLS] __read_mostly = {
>   */
>  struct bio_set *fs_bio_set;
>  
> +/* Only used as a sentinal value */
> +static struct bio_set bio_kmalloc_pool;
> +


Id rather if you use a define like:
#define BIO_KMALLOC_POOL ((void *)~0)

So any code access actually crashes in the bug case where
this leaks out. (And there is no actual unused storage allocated)

BTW I like this reuse of the bi_pool member as a flag as well.

Thanks
Boaz

>  /*
>   * Our slab pool management
>   */
> @@ -232,10 +235,21 @@ fallback:
>  	return bvl;
>  }
>  
> -void bio_free(struct bio *bio, struct bio_set *bs)
> +void bio_free(struct bio *bio)
>  {
> +	struct bio_set *bs = bio->bi_pool;
>  	void *p;
>  
> +	BUG_ON(!bs);
> +
> +	if (bs == &bio_kmalloc_pool) {
> +		/* Bio was allocated by bio_kmalloc() */
> +		if (bio_integrity(bio))
> +			bio_integrity_free(bio, fs_bio_set);
> +		kfree(bio);
> +		return;
> +	}
> +
>  	if (bio_has_allocated_vec(bio))
>  		bvec_free_bs(bs, bio->bi_io_vec, BIO_POOL_IDX(bio));
>  
> @@ -347,13 +361,6 @@ struct bio *bio_alloc(gfp_t gfp_mask, unsigned int nr_iovecs)
>  }
>  EXPORT_SYMBOL(bio_alloc);
>  
> -static void bio_kmalloc_destructor(struct bio *bio)
> -{
> -	if (bio_integrity(bio))
> -		bio_integrity_free(bio, fs_bio_set);
> -	kfree(bio);
> -}
> -
>  /**
>   * bio_kmalloc - allocate a bio for I/O using kmalloc()
>   * @gfp_mask:   the GFP_ mask given to the slab allocator
> @@ -380,7 +387,7 @@ struct bio *bio_kmalloc(gfp_t gfp_mask, unsigned int nr_iovecs)
>  	bio->bi_flags |= BIO_POOL_NONE << BIO_POOL_OFFSET;
>  	bio->bi_max_vecs = nr_iovecs;
>  	bio->bi_io_vec = bio->bi_inline_vecs;
> -	bio->bi_destructor = bio_kmalloc_destructor;
> +	bio->bi_pool = &bio_kmalloc_pool;
>  
>  	return bio;
>  }
> @@ -418,12 +425,7 @@ void bio_put(struct bio *bio)
>  	 */
>  	if (atomic_dec_and_test(&bio->bi_cnt)) {
>  		bio_disassociate_task(bio);
> -		bio->bi_next = NULL;
> -
> -		if (bio->bi_pool)
> -			bio_free(bio, bio->bi_pool);
> -		else
> -			bio->bi_destructor(bio);
> +		bio_free(bio);
>  	}
>  }
>  EXPORT_SYMBOL(bio_put);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index ba60319..393c87e 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -216,7 +216,7 @@ extern struct bio *bio_alloc(gfp_t, unsigned int);
>  extern struct bio *bio_kmalloc(gfp_t, unsigned int);
>  extern struct bio *bio_alloc_bioset(gfp_t, int, struct bio_set *);
>  extern void bio_put(struct bio *);
> -extern void bio_free(struct bio *, struct bio_set *);
> +extern void bio_free(struct bio *);
>  
>  extern void bio_endio(struct bio *, int);
>  struct request_queue;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 40411e2..fa45a12 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -84,11 +84,8 @@ struct bio {
>  	struct bio_integrity_payload *bi_integrity;  /* data integrity */
>  #endif
>  
> -	/* If bi_pool is non NULL, bi_destructor is not called */
>  	struct bio_set		*bi_pool;
>  
> -	bio_destructor_t	*bi_destructor;	/* destructor */
> -
>  	/*
>  	 * We can inline a number of vecs at the end of the bio, to avoid
>  	 * double allocations for a small number of bio_vecs. This member


