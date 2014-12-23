Return-Path: <BATV+7878fa151e225da5a09b+4139+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A861B1045C29
	for <drbd-dev@lists.linbit.com>; Tue, 23 Dec 2014 11:34:09 +0100 (CET)
Date: Tue, 23 Dec 2014 02:16:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dongsu Park <dongsu.park@profitbricks.com>
Message-ID: <20141223101614.GA13138@infradead.org>
References: <cover.1419241597.git.dongsu.park@profitbricks.com>
	<d26a9a0fc9a7d1529c115785ee5935d5750782bd.1419241597.git.dongsu.park@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d26a9a0fc9a7d1529c115785ee5935d5750782bd.1419241597.git.dongsu.park@profitbricks.com>
Cc: Jens Axboe <axboe@kernel.dk>, Oleg Drokin <oleg.drokin@intel.com>,
	Nitin Gupta <ngupta@vflare.org>,
	Mike Snitzer <snitzer@redhat.com>, Ming Lin <mlin@minggr.net>,
	Minchan Kim <minchan@kernel.org>, Neil Brown <neilb@suse.de>,
	Jiri Kosina <jkosina@suse.cz>, Ming Lei <ming.lei@canonical.com>,
	linux-kernel@vger.kernel.org, Jim Paris <jim@jtan.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>, Geoff Levand <geoff@infradead.org>,
	Kent Overstreet <kmo@daterainc.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Dilger <andreas.dilger@intel.com>, dm-devel@redhat.com,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC PATCH 01/17] block: make generic_make_request
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

> +void blk_queue_split(struct request_queue *q, struct bio **bio,
> +		     struct bio_set *bs)
> +{
> +	struct bio *split;
> +
> +	if ((*bio)->bi_rw & REQ_DISCARD)
> +		split = blk_bio_discard_split(q, *bio, bs);
> +	else if ((*bio)->bi_rw & REQ_WRITE_SAME)
> +		split = blk_bio_write_same_split(q, *bio, bs);
> +	else
> +		split = blk_bio_segment_split(q, *bio, q->bio_split);
> +
> +	if (split) {
> +		bio_chain(split, *bio);
> +		generic_make_request(*bio);
> +		*bio = split;
> +	}
> +}
> +EXPORT_SYMBOL(blk_queue_split);

I think blk_queue_split needs to explicitly skip BLOCK_PC bios.  Those
are SCSI pass through ioctls that we can't split due to their opaque
nature.

