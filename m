Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8646D1012A92
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 01:15:59 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so2709045pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 16:15:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 8 Aug 2012 16:15:52 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120808231552.GJ6983@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-11-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344290921-25154-11-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 10/12] block: Add bio_clone_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Aug 06, 2012 at 03:08:39PM -0700, Kent Overstreet wrote:

How about the following?

There was no API to kmalloc bio and clone and osdblk was using
explicit bio_kmalloc() + __bio_clone().  (my guess here) As this is
inconvenient and there will be more users of it in the future, add
bio_clone_kmalloc() and use it in osdblk.

> Acked-by: Boaz Harrosh <bharrosh@panasas.com>
> Signed-off-by: Kent Overstreet <koverstreet@google.com>
> ---
>  drivers/block/osdblk.c |    3 +--
>  fs/bio.c               |   13 +++++++++++++
>  fs/exofs/ore.c         |    5 ++---
>  include/linux/bio.h    |    1 +
>  4 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/osdblk.c b/drivers/block/osdblk.c
> index 87311eb..1bbc681 100644
> --- a/drivers/block/osdblk.c
> +++ b/drivers/block/osdblk.c
> @@ -266,11 +266,10 @@ static struct bio *bio_chain_clone(struct bio *old_chain, gfp_t gfpmask)
>  	struct bio *tmp, *new_chain = NULL, *tail = NULL;
>  
>  	while (old_chain) {
> -		tmp = bio_kmalloc(gfpmask, old_chain->bi_max_vecs);
> +		tmp = bio_clone_kmalloc(old_chain, gfpmask);
>  		if (!tmp)
>  			goto err_out;
>  
> -		__bio_clone(tmp, old_chain);
>  		tmp->bi_bdev = NULL;
>  		gfpmask &= ~__GFP_WAIT;
>  		tmp->bi_next = NULL;
> diff --git a/fs/bio.c b/fs/bio.c
> index f0c865b..77b9313 100644
> --- a/fs/bio.c
> +++ b/fs/bio.c
> @@ -497,6 +497,19 @@ struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(bio_clone);
>  

/**

PLEASE.

> +struct bio *bio_clone_kmalloc(struct bio *bio, gfp_t gfp_mask)
> +{
> +	struct bio *b = bio_kmalloc(gfp_mask, bio->bi_max_vecs);

Can't we use %NULL bioset as an indication to allocate from kmalloc
instead of duping interfaces like this?

Thanks.

-- 
tejun
