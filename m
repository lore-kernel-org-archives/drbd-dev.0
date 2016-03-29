Return-Path: <BATV+6cc4c2ca6091f98ba507+4601+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B05CF1056332
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 09:26:26 +0200 (CEST)
Date: Tue, 29 Mar 2016 00:26:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@canonical.com>
Message-ID: <20160329072617.GB18920@infradead.org>
References: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
	<1458627149-12988-2-git-send-email-ming.lei@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458627149-12988-2-git-send-email-ming.lei@canonical.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Boaz Harrosh <boaz@plexistor.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	xfs@oss.sgi.com, linux-block@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 1/8] block: move bvec iterator into
 include/linux/bvec_iter.h
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

> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -31,6 +31,7 @@
>  
>  /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
>  #include <linux/blk_types.h>
> +#include <linux/bvec_iter.h>
>  
>  #define BIO_DEBUG
>  
> @@ -40,10 +41,6 @@
>  #define BIO_BUG_ON
>  #endif
>  
> -#define BIO_MAX_PAGES		256
> -#define BIO_MAX_SIZE		(BIO_MAX_PAGES << PAGE_CACHE_SHIFT)
> -#define BIO_MAX_SECTORS		(BIO_MAX_SIZE >> 9)

I see no reason why these should be moved out of bio.h.

Otherwise this looks fine to me.
