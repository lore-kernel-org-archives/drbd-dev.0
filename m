Return-Path: <BATV+2ba22eccf6f47ffc112e+7192+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 176D34203AB
	for <drbd-dev@lists.linbit.com>; Wed,  3 May 2023 06:20:16 +0200 (CEST)
Date: Tue, 2 May 2023 21:18:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <ZFHgefWofVt24tRl@infradead.org>
References: <20230502092922.175857-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230502092922.175857-1-christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, Thomas Voegtle <tv@lio96.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: do not set REQ_PREFLUSH when
	submitting barrier
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, May 02, 2023 at 11:29:22AM +0200, Christoph Böhmwalder wrote:
>  	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
> -				    REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
> +				    REQ_OP_FLUSH, GFP_NOIO);

This isn't going to work.  flush bios are (somewhat confusingly)
implemented as writes with no data and the preflush flag.  So this
should be:

	REQ_OP_WRITE | REQ_PREFLUSH.

and it looks like whatever flushing this does hasn't wroked for a long
time.
