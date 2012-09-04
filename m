Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 437CB1017A2C
	for <drbd-dev@lists.linbit.com>; Wed,  5 Sep 2012 00:52:56 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so11761934pbb.27
	for <drbd-dev@lists.linbit.com>; Tue, 04 Sep 2012 15:52:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 4 Sep 2012 15:46:20 -0700
From: Tejun Heo <tj@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20120904224620.GB9092@dhcp-172-17-108-109.mtv.corp.google.com>
References: <8439412.RChiDciQdh@fat-tyre>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8439412.RChiDciQdh@fat-tyre>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
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

On Tue, Sep 04, 2012 at 02:32:01PM +0200, Philipp Reisner wrote:
> I think commit 1e87901e18 was wrong. Starting with that commit the REQ_FLUSH 
> and REQ_FUA bits get stripped away if the queue does not advertise REQ_FLUSH
> or REQ_FUA support.
> 
> But the REQ_FLUSH bit is also tested for when not merging requests
> (blk_queue_bio()) or when it comes to the elevator (blk_flush_plug_list()).
> 
> So, since this patch the elevator reorders write requests on queues that 
> do not have REQ_FLUSH or REQ_FUA set.
> 
> While on queues that have REQ_FLUSH or REQ_FUA set, the elevator does
> not reorder writes across FLUSHes.

Currently, FLUSH/FUA doesn't enforce any ordering requirement.  File
systems are responsible for draining all writes which have to happen
before and not issue further writes which should come after.  The use
of SOFTBARRIER there is mostly historical.  I *suspect* we should be
able to drop that as RQ_NOMERGE_FLAGS already contain FLUSH and FUA.
Not really looked through it tho.

> I have the impression every file system lets IO drain, and issues a
> flush afterwards with the blkdev_issue_flush() function. BTW that
> function turns into a non-obvious no-op as soon as the queue does not
> have the REQ_FUA or REQ_FLUSH bits set. It does not look like it is
> a no-op by intention.

So, yeah, it is no-op by intention.  We probably should make the
documentation clearer.

Thanks.

-- 
tejun
