Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 28D78103B4D4
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 00:58:46 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so2685528pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 15:58:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 8 Aug 2012 15:58:39 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120808225839.GG6983@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-9-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344290921-25154-9-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 08/12] block: Introduce new bio_split()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On Mon, Aug 06, 2012 at 03:08:37PM -0700, Kent Overstreet wrote:
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

Umm.... I don't know.  This is rather confusing.  The function may
return new or old bios?  What's the rationale behind it?  Return
ERR_PTR(-EINVAL) instead?

> + *
> + * The newly allocated bio will point to @bio's bi_io_vec, if the split was on a
> + * bvec boundry; it is the caller's responsibility to ensure that @bio is not
> + * freed before the split.

This is somewhat error-prone.  Given how splits are used now, this
might not be a big issue but it isn't difficult to imagine how this
could go subtly wrong.  More on this.

> + *
> + * BIG FAT WARNING:
> + *
> + * If you're calling this from under generic_make_request() (i.e.
> + * current->bio_list != NULL), you should mask out __GFP_WAIT and punt to
> + * workqueue if the allocation fails. Otherwise, your code will probably
> + * deadlock.

If the condition is detectable, WARN_ON_ONCE() please.

> + * You can't allocate more than once from the same bio pool without submitting
> + * the previous allocations (so they'll eventually complete and deallocate
> + * themselves), but if you're under generic_make_request() those previous
> + * allocations won't submit until you return . And if you have to split bios,
                                               ^
					       extra space
> + * you should expect that some bios will require multiple splits.
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

Ummm... ISTR reviewing this code and getting confused by bio_alloc
inside bio_for_each_segment() loop and commenting something about
that.  Yeah, this one.

  http://thread.gmane.org/gmane.linux.kernel.device-mapper.devel/15790/focus=370

So, I actually have reviewed this but didn't get any response and
majority of the issues I raised aren't addressed and you sent the
patch to me again?  What the hell, Kent?

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

Is this safe?  Why isn't this chaining completion of split bio to the
original one?

Thanks.

-- 
tejun
