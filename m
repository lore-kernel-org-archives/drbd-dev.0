Return-Path: <BATV+ec6d521f801fb612d965+4989+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E8CB41056446
	for <drbd-dev@lists.linbit.com>;
	Fri, 21 Apr 2017 13:30:46 +0200 (CEST)
Date: Fri, 21 Apr 2017 04:30:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Message-ID: <20170421113043.GF12523@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble>
	<149266672944.27388.18032655582081459017.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149266672944.27388.18032655582081459017.stgit@noble>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/11] drbd: use bio_clone_fast() instead of
	bio_clone()
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

On Thu, Apr 20, 2017 at 03:38:49PM +1000, NeilBrown wrote:
> drbd does not modify the bi_io_vec of the cloned bio,
> so there is no need to clone that part.  So bio_clone_fast()
> is the better choice.
> For bio_clone_fast() we need to specify a bio_set.
> We could use fs_bio_set, which bio_clone() uses, or
> drbd_md_io_bio_set, which drbd uses for metadata, but it is
> generally best to avoid sharing bio_sets unless you can
> be certain that there are no interdependencies.
> 
> So create a new bio_set, drbd_io_bio_set, and use bio_clone_fast().
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

All the zeroing of the gblobal variable looks unessecary / stupid.

But given that the surrounding code already does it:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> +	bio = bio_clone_fast(bio_src, GFP_NOIO, drbd_io_bio_set); /* XXX cannot fail!! */

but maybe I'd drop this comment..
