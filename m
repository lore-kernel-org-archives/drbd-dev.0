Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EEC991019A78
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id E4D8D1B4262
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:39 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ztM1LKIopkKt for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 09:03:39 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id C7E251B4206
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:39 +0200 (CEST)
Resent-Message-ID: <20120525070339.GA12726@soda.linbit>
Received: from natasha.panasas.com (natasha.panasas.com [67.152.220.90])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 869A81017A2C
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 19:19:05 +0200 (CEST)
Message-ID: <4FBE687E.1030605@panasas.com>
Date: Thu, 24 May 2012 19:57:34 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
To: Kent Overstreet <koverstreet@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-10-git-send-email-koverstreet@google.com>
In-Reply-To: <1337817771-25038-10-git-send-email-koverstreet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	vgoyal@redhat.com, yehuda@hq.newdream.net,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 09/14] block: Add an explicit bio flag for
 bios that own their bvec
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 05/24/2012 03:02 AM, Kent Overstreet wrote:

> This is for the new bio splitting code. When we split a bio, if the
> split occured on a bvec boundry we reuse the bvec for the new bio. But
> that means bio_free() can't free it, hence the explicit flag.
> 




How do you insure that the original bio which owns the
bvec is not freed before the split-out bio.

Perhaps calling code needs to make sure by taking an extra
ref on the original bio, or something. If so a big fat comment
at bio_split is do.

And I understand you did not like my suggestion of negating
the meaning of the flag, so the default is zero?
Please say why?

Thanks
Boaz

> Signed-off-by: Kent Overstreet <koverstreet@google.com>
> Change-Id: I040f6b501088e882a9f013d6b6e730ff04e9c1da
> ---
>  fs/bio.c                  |    3 ++-
>  include/linux/bio.h       |    5 -----
>  include/linux/blk_types.h |    1 +
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/bio.c b/fs/bio.c
> index fc4a168..24b1d1c 100644
> --- a/fs/bio.c
> +++ b/fs/bio.c
> @@ -241,7 +241,7 @@ void bio_free(struct bio *bio, struct bio_set *bs)
>  		return;
>  	}
>  
> -	if (bio_has_allocated_vec(bio))
> +	if (bio_flagged(bio, BIO_HAS_VEC))
>  		bvec_free_bs(bs, bio->bi_io_vec, BIO_POOL_IDX(bio));
>  
>  	if (bio_integrity(bio))
> @@ -312,6 +312,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, int nr_iovecs, struct bio_set *bs)
>  			goto err_free;
>  
>  		nr_iovecs = bvec_nr_vecs(idx);
> +		bio->bi_flags |= 1 << BIO_HAS_VEC;
>  	}
>  out_set:
>  	bio->bi_flags |= idx << BIO_POOL_OFFSET;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 35f7c4d..8dd8cae 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -84,11 +84,6 @@ static inline void *bio_data(struct bio *bio)
>  	return NULL;
>  }
>  
> -static inline int bio_has_allocated_vec(struct bio *bio)
> -{
> -	return bio->bi_io_vec && bio->bi_io_vec != bio->bi_inline_vecs;
> -}
> -
>  /*
>   * will die
>   */
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index b6ddbf1..ab2252d 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -101,6 +101,7 @@ struct bio {
>  #define BIO_FS_INTEGRITY 9	/* fs owns integrity data, not block layer */
>  #define BIO_QUIET	10	/* Make BIO Quiet */
>  #define BIO_MAPPED_INTEGRITY 11/* integrity metadata has been remapped */
> +#define BIO_HAS_VEC	12	/* bio_free() should free bvec */
>  #define bio_flagged(bio, flag)	((bio)->bi_flags & (1 << (flag)))
>  
>  /*




