Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AD4FD1018D52
	for <drbd-dev@lists.linbit.com>; Thu, 15 Nov 2018 10:11:18 +0100 (CET)
Date: Thu, 15 Nov 2018 10:03:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Message-ID: <20181115090310.GB14284@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
	<20181114160219.28328-15-hch@lst.de>
	<CAPDyKFrEWQdOKHu2FeyzPvLCDrRa+QouG6OjEzf=JF1yxoTRgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrEWQdOKHu2FeyzPvLCDrRa+QouG6OjEzf=JF1yxoTRgw@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 14/16] mmc: stop abusing the request
	queue_lock pointer
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

On Wed, Nov 14, 2018 at 06:56:41PM +0100, Ulf Hansson wrote:
> >         } else {
> > @@ -397,6 +397,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
> >         int ret;
> >
> >         mq->card = card;
> > +       mq->lock = lock;
> 
> Unless I am mistaken, it seems like the "lock" can also be removed as
> an in-parameter to mmc_init_queue() - and instead do the
> spin_lock_init() in here.
> 
> Moreover, that means we should drop the "lock" from the struct
> mmc_blk_data and instead move it to struct mmc_queue (rather than
> having a pointer to it.)

Which sounds like a sensible idead indeed, I'll look into it.
