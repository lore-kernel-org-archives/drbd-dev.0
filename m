Return-Path: <htejun@gmail.com>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B51CD1017A2C
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:38:38 +0200 (CEST)
Received: by dadv36 with SMTP id v36so14864893dad.27
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 09:38:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 24 May 2012 09:38:31 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120524163831.GE27983@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-4-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337817771-25038-4-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 03/14] block: Add bio_clone_bioset()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, May 23, 2012 at 05:02:40PM -0700, Kent Overstreet wrote:
> This consolidates some code, and will help in a later patch changing how
> bio cloning works.

Which consolidations are happening and which drivers are being
affected how?

> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index e6e7b19..e5076f2 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1062,26 +1062,19 @@ static struct bio *split_bvec(struct bio *bio, sector_t sector,
>   * Creates a bio that consists of range of complete bvecs.
>   */
>  static struct bio *clone_bio(struct bio *bio, sector_t sector,
> -			     unsigned short idx, unsigned short bv_count,
> +			     unsigned short bv_count,
>  			     unsigned int len, struct bio_set *bs)
>  {
>  	struct bio *clone;
>  
> -	clone = bio_alloc_bioset(GFP_NOIO, bio->bi_max_vecs, bs);
> -	__bio_clone(clone, bio);
> +	clone = bio_clone_bioset(bio, GFP_NOIO, bs);
>  	clone->bi_sector = sector;
> -	clone->bi_idx = idx;
> -	clone->bi_vcnt = idx + bv_count;
> +	clone->bi_vcnt = bv_count;
>  	clone->bi_size = to_bytes(len);
> -	clone->bi_flags &= ~(1 << BIO_SEG_VALID);

Why is this safe?  If it's only bioset related API changes, why are
there other changes at all?  If the new clone interface can handle
bioset fine, do we still need to expose __bio_clone()?

> -	if (bio_integrity(bio)) {
> -		bio_integrity_clone(clone, bio, GFP_NOIO, bs);
> -
> -		if (idx != bio->bi_idx || clone->bi_size < bio->bi_size)
> -			bio_integrity_trim(clone,
> -					   bio_sector_offset(bio, idx, 0), len);
> -	}
> +	if (bio_integrity(bio) &&
> +	    clone->bi_size < bio->bi_size)
> +		bio_integrity_trim(clone, 0, len);

Why is idx != bi_idx test dropped?

I'm gonna stop here on this series.  It doesn't seem like the issues
pointed out before have been addressed.  I recommend spending more
effort on patch descriptions.  Writing descriptions is not only
important for reviewing and history but it's a good step in ensuring
the patches are sane and properly split.  If you can't explain each
change in the patch, it generally means either the changes themselves
are wrong or wrongly split.

Thanks.

-- 
tejun
