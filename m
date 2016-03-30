Return-Path: <BATV+ce0ae62d478fb9371428+4602+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B47D11056421
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 19:19:42 +0200 (CEST)
Date: Wed, 30 Mar 2016 10:19:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@canonical.com>
Message-ID: <20160330171927.GA13320@infradead.org>
References: <1459354637-17415-1-git-send-email-ming.lei@canonical.com>
	<1459354637-17415-3-git-send-email-ming.lei@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459354637-17415-3-git-send-email-ming.lei@canonical.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	xfs@oss.sgi.com, Jens Axboe <axboe@fb.com>,
	Boaz Harrosh <boaz@plexistor.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v1 2/8] block: make 'struct bvec_iter' not
 depend on CONFIG_BLOCK
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

On Thu, Mar 31, 2016 at 12:17:11AM +0800, Ming Lei wrote:
> We will use bvec iterator to implement iterate_bvec(): lib/iov_iter.c.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
>  include/linux/blk_types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 86a38ea..fd8527b 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -26,8 +26,6 @@ struct bio_vec {
>  	unsigned int	bv_offset;
>  };
>  
> -#ifdef CONFIG_BLOCK
> -
>  struct bvec_iter {
>  	sector_t		bi_sector;	/* device address in 512 byte
>  						   sectors */
> @@ -39,6 +37,8 @@ struct bvec_iter {
>  						   current bvec */
>  };

I didn't catch this earlier, but shouldn't this also move to
bvec_iter.h? Or maybe just create a linux/bvec.h for the bvec, bvec_iter
and bvec iter macros given that those are the types used outside the
block layer as well.
