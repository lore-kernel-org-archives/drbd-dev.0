Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 55EC6105571D
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4E69045E3EF
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:04 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id p55HSiYghwzF for <drbd-dev@lists.linbit.com>;
	Wed, 27 May 2015 10:58:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2F0642A0E92
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:04 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iUpFiAxTYjej for <drbd-dev@lists.linbit.com>;
	Wed, 27 May 2015 10:58:04 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 0450A45E41B
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:03 +0200 (CEST)
Resent-Message-ID: <20150527085803.GB18767@soda.linbit>
From: Jeff Moyer <jmoyer@redhat.com>
To: Ming Lin <mlin@kernel.org>
References: <1430980461-5235-1-git-send-email-mlin@kernel.org>
	<1430980461-5235-2-git-send-email-mlin@kernel.org>
Date: Mon, 18 May 2015 12:52:03 -0400
In-Reply-To: <1430980461-5235-2-git-send-email-mlin@kernel.org> (Ming Lin's
	message of "Wed, 6 May 2015 23:34:11 -0700")
Message-ID: <x49twv9kevg.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>, dm-devel@redhat.com,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
	Jim Paris <jim@jtan.com>, Minchan Kim <minchan@kernel.org>,
	Dongsu Park <dpark@posteo.net>, drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 01/11] block: make generic_make_request
	handle arbitrarily sized bios
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

Ming Lin <mlin@kernel.org> writes:

> diff --git a/block/blk-core.c b/block/blk-core.c
> index fd154b9..909f317 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -617,6 +617,10 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
>  	if (q->id < 0)
>  		goto fail_q;
>  
> +	q->bio_split = bioset_create(4, 0);
> +	if (!q->bio_split)
> +		goto fail_id;
> +

Arbitrary numbers should be documented.

> +static struct bio *blk_bio_discard_split(struct request_queue *q,
> +					 struct bio *bio,
> +					 struct bio_set *bs)
> +{
> +	unsigned int max_discard_sectors, granularity;
> +	int alignment;
> +	sector_t tmp;
> +	unsigned split_sectors;
> +
> +	/* Zero-sector (unknown) and one-sector granularities are the same.  */
> +	granularity = max(q->limits.discard_granularity >> 9, 1U);
> +
> +	max_discard_sectors = min(q->limits.max_discard_sectors, UINT_MAX >> 9);
> +	max_discard_sectors -= max_discard_sectors % granularity;
> +
> +	if (unlikely(!max_discard_sectors)) {
> +		/* XXX: warn */
> +		return NULL;
> +	}
> +
> +	if (bio_sectors(bio) <= max_discard_sectors)
> +		return NULL;
> +
> +	split_sectors = max_discard_sectors;
> +
> +	/*
> +	 * If the next starting sector would be misaligned, stop the discard at
> +	 * the previous aligned sector.
> +	 */
> +	alignment = (q->limits.discard_alignment >> 9) % granularity;
> +
> +	tmp = bio->bi_iter.bi_sector + split_sectors - alignment;
> +	tmp = sector_div(tmp, granularity);
> +
> +	if (split_sectors > tmp)
> +		split_sectors -= tmp;
> +
> +	return bio_split(bio, split_sectors, GFP_NOIO, bs);

Much of this function is cut-n-paste from blk-lib.c.  Is there any way
to factor it out?

> +static struct bio *blk_bio_segment_split(struct request_queue *q,
> +					 struct bio *bio,
> +					 struct bio_set *bs)
> +{

Funny name for a function that also merges segments.  ;-)  I admit I am
at a loss for coming up with a better name that won't overflow 80
columns.

Other than that, this looks sane.

Cheers,
Jeff
