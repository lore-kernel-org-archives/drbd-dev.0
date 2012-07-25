Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C427F1055F61
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id BE6A61B4369
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:48 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F7Qm9I1xcfyi for <drbd-dev@lists.linbit.com>;
	Thu, 26 Jul 2012 11:35:48 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id A5E031B4368
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:48 +0200 (CEST)
Resent-Message-ID: <20120726093548.GB29767@soda.linbit>
Received: from natasha.panasas.com (natasha.panasas.com [67.152.220.90])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 08F891019A78
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2012 13:56:10 +0200 (CEST)
Message-ID: <500FDEBC.9050607@panasas.com>
Date: Wed, 25 Jul 2012 14:55:40 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
To: Kent Overstreet <koverstreet@google.com>
References: <1343160689-12378-1-git-send-email-koverstreet@google.com>
	<1343160689-12378-9-git-send-email-koverstreet@google.com>
In-Reply-To: <1343160689-12378-9-git-send-email-koverstreet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v4 08/12] block: Introduce new bio_split()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 07/24/2012 11:11 PM, Kent Overstreet wrote:

> The new bio_split() can split arbitrary bios - it's not restricted to
> single page bios, like the old bio_split() (previously renamed to
> bio_pair_split()). It also has different semantics - it doesn't allocate
> a struct bio_pair, leaving it up to the caller to handle completions.
> 
> Signed-off-by: Kent Overstreet <koverstreet@google.com>
> ---
>  fs/bio.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 99 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/bio.c b/fs/bio.c
> index 5d02aa5..a15e121 100644
> --- a/fs/bio.c
> +++ b/fs/bio.c
> @@ -1539,6 +1539,105 @@ struct bio_pair *bio_pair_split(struct bio *bi, int first_sectors)
>  EXPORT_SYMBOL(bio_pair_split);
>  
>  /**
> + * bio_split - split a bio
> + * @bio:	bio to split
> + * @sectors:	number of sectors to split from the front of @bio
> + * @gfp:	gfp mask
> + * @bs:		bio set to allocate from
> + *
> + * Allocates and returns a new bio which represents @sectors from the start of
> + * @bio, and updates @bio to represent the remaining sectors.
> + *
> + * If bio_sectors(@bio) was less than or equal to @sectors, returns @bio
> + * unchanged.
> + *
> + * The newly allocated bio will point to @bio's bi_io_vec, if the split was on a
> + * bvec boundry; it is the caller's responsibility to ensure that @bio is not
> + * freed before the split.
> + *
> + * If bio_split() is running under generic_make_request(), it's not safe to
> + * allocate more than one bio from the same bio set. Therefore, if it is running
> + * under generic_make_request() it masks out __GFP_WAIT when doing the
> + * allocation. The caller must check for failure if there's any possibility of
> + * it being called from under generic_make_request(); it is then the caller's
> + * responsibility to retry from a safe context (by e.g. punting to workqueue).
> + */
> +struct bio *bio_split(struct bio *bio, int sectors,
> +		      gfp_t gfp, struct bio_set *bs)
> +{
> +	unsigned idx, vcnt = 0, nbytes = sectors << 9;
> +	struct bio_vec *bv;
> +	struct bio *ret = NULL;
> +
> +	BUG_ON(sectors <= 0);
> +
> +	/*
> +	 * If we're being called from underneath generic_make_request() and we
> +	 * already allocated any bios from this bio set, we risk deadlock if we
> +	 * use the mempool. So instead, we possibly fail and let the caller punt
> +	 * to workqueue or somesuch and retry in a safe context.
> +	 */
> +	if (current->bio_list)
> +		gfp &= ~__GFP_WAIT;


NACK!

If as you said above in the comment:
	if there's any possibility of it being called from under generic_make_request();
        it is then the caller's responsibility to ...

So all the comment needs to say is: 
	... caller's responsibility to not set __GFP_WAIT at gfp.

And drop this here. It is up to the caller to decide. If the caller wants he can do
"if (current->bio_list)" by his own.

This is a general purpose utility you might not know it's context.
for example with osdblk above will break.

Thanks
Boaz

> +
> +	if (sectors >= bio_sectors(bio))
> +		return bio;
> +
> +	trace_block_split(bdev_get_queue(bio->bi_bdev), bio,
> +			  bio->bi_sector + sectors);
> +
> +	bio_for_each_segment(bv, bio, idx) {
> +		vcnt = idx - bio->bi_idx;
> +
> +		if (!nbytes) {
> +			ret = bio_alloc_bioset(gfp, 0, bs);
> +			if (!ret)
> +				return NULL;
> +
> +			ret->bi_io_vec = bio_iovec(bio);
> +			ret->bi_flags |= 1 << BIO_CLONED;
> +			break;
> +		} else if (nbytes < bv->bv_len) {
> +			ret = bio_alloc_bioset(gfp, ++vcnt, bs);
> +			if (!ret)
> +				return NULL;
> +
> +			memcpy(ret->bi_io_vec, bio_iovec(bio),
> +			       sizeof(struct bio_vec) * vcnt);
> +
> +			ret->bi_io_vec[vcnt - 1].bv_len = nbytes;
> +			bv->bv_offset	+= nbytes;
> +			bv->bv_len	-= nbytes;
> +			break;
> +		}
> +
> +		nbytes -= bv->bv_len;
> +	}
> +
> +	ret->bi_bdev	= bio->bi_bdev;
> +	ret->bi_sector	= bio->bi_sector;
> +	ret->bi_size	= sectors << 9;
> +	ret->bi_rw	= bio->bi_rw;
> +	ret->bi_vcnt	= vcnt;
> +	ret->bi_max_vecs = vcnt;
> +	ret->bi_end_io	= bio->bi_end_io;
> +	ret->bi_private	= bio->bi_private;
> +
> +	bio->bi_sector	+= sectors;
> +	bio->bi_size	-= sectors << 9;
> +	bio->bi_idx	 = idx;
> +
> +	if (bio_integrity(bio)) {
> +		bio_integrity_clone(ret, bio, gfp, bs);
> +		bio_integrity_trim(ret, 0, bio_sectors(ret));
> +		bio_integrity_trim(bio, bio_sectors(ret), bio_sectors(bio));
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(bio_split);
> +
> +/**
>   *      bio_sector_offset - Find hardware sector offset in bio
>   *      @bio:           bio to inspect
>   *      @index:         bio_vec index


