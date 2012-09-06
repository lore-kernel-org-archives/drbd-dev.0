Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 98ECF103B4A3
	for <drbd-dev@lists.linbit.com>; Thu,  6 Sep 2012 23:29:58 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so3916314pbb.27
	for <drbd-dev@lists.linbit.com>; Thu, 06 Sep 2012 14:29:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 6 Sep 2012 14:29:52 -0700
From: Tejun Heo <tj@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Message-ID: <20120906212952.GP29092@google.com>
References: <8439412.RChiDciQdh@fat-tyre>
	<20120904224620.GB9092@dhcp-172-17-108-109.mtv.corp.google.com>
	<3029802.oqG0dEY71l@fat-tyre>
	<20120905084915.GF3195@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120905100724.GA27527@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120905100724.GA27527@soda.linbit>
Subject: Re: [Drbd-dev] FLUSH/FUA documentation & code discrepancy
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On Wed, Sep 05, 2012 at 12:07:24PM +0200, Lars Ellenberg wrote:
> So reiterating the situation:
> 
> If I'd submit a non-empty bio with FLUSH/FUA set,
> on a queue that does support flush, we get to
> 	blk_queue_bio()
> 		if (bio->bi_rw & (REQ_FLUSH | REQ_FUA)) {
> 			spin_lock_irq(q->queue_lock);
> 			where = ELEVATOR_INSERT_FLUSH;
> 			goto get_rq;
> 
> This bio ends up *not* being merged or reordered by the elevator.
> (and, by means of flush/fua not by the hardware, either, obviously)
> 
> If the queue does not support it, flags are stripped away in
> generic_make_request_checks(), and we will not take that branch
> in blk_queue_bio(), but enter the normal elevator code path,
> attempting a merge, or doing ELEVATOR_INSERT_SORT.

which is an implementation detail.

> This same bio, happening to be submitted on a different IO stack,
> now *is* being reordered in the elevator already,
> even before being sent to the hardware.

and this is perfectly fine.

I really don't see what problem you're trying to solve here.  The
ordering requirement is weak.  Certain implementation path uses
stronger requirement for convenience / historical reasons.  If any
change makes sense, it's relaxing the unnecessarily strict ordering if
possible.

What actual problem are you seeing?

Thanks.

-- 
tejun
