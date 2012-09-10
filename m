Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 917581013802
	for <drbd-dev@lists.linbit.com>; Tue, 11 Sep 2012 00:54:48 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so3606776pbb.27
	for <drbd-dev@lists.linbit.com>; Mon, 10 Sep 2012 15:54:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 10 Sep 2012 15:54:42 -0700
From: Tejun Heo <tj@kernel.org>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Message-ID: <20120910225442.GE7677@google.com>
References: <8439412.RChiDciQdh@fat-tyre>
	<20120904224620.GB9092@dhcp-172-17-108-109.mtv.corp.google.com>
	<3029802.oqG0dEY71l@fat-tyre>
	<20120905084915.GF3195@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120905100724.GA27527@soda.linbit>
	<20120906212952.GP29092@google.com>
	<20120907084221.GD7028@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120907084221.GD7028@soda.linbit>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org
Subject: Re: [Drbd-dev] FLUSH/FUA documentation & code discrepancy
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello, Lars.

On Fri, Sep 07, 2012 at 10:42:21AM +0200, Lars Ellenberg wrote:
> We have a kernel thread that is receiving data blocks,
> and some "boundary" information (in the sense that between such
> boundaries, we have a reorder domain, where requests may reorder freely,
> but no requests may be reordered across such boundaries).

What purpose does this boundary serve?  Why is it necessary?  Which
driver is this?

> This same thread submits the assembled bios.
> 
> With the old, stronger, BIO_RW_BARRIER implementation,
> if it was supported, we could just submit the first bio of a reorder
> domain (plus some special cases) with that flag,
> and could keep receiving -> assembling -> submitting.

Yes, but the actual request processing would continue to stall as
block layer would have been draining requests continuously.

> Now, we assumed that with FLUSH/FUA, we can do the same.
> And we could, as long as it is supported through the whole stack.
> 
> But if it is not supported at some level in the stack, we must first drain.
> 
> And since it is all "transparent", we just cannot determine
> if the whole stack does or does not support it.
> 
> So we have to drain always.

The driver was hitching on BARRIER for draining.  As that's gone now,
if you want the same behavior, the driver would need to drain itself.

> We did not realize that. 
> In certain cases, where we submitted in the right order, and even
> indicated what we thought would amount to at least a "soft barrier"
> (reorder boundary) for the elevator, we ended up with data corruption
> because the elevator never sees these indicators, and reorders.
> 
> Fine, our mistake/misunderstanding of the drain requirement.
> That's fixed now, we do always drain
> (unless specifically configured not to, where the admin takes the blame
> if that does not work on his stack).
> 
> 
> To always drain is also a performance hit, as we would rather keep
> receiving data and assembling bios and submitting them.

Is the performance hit measureable?  Block BARRIER support had some
optimizations but it still had to constantly drain all the same.

> We can possibly work around that by introducing an additional submitter thread,
> or at least our own list where we queue assembled bios until the lower
> level device queue drains.
> 
> But we'd rather have the elevator see the FLUSH/FUA,
> and treat them as at least a soft barrier/reorder boundary.
> 
> I may be wrong here, but all the necessary bits for this seem to be in
> place already, if the information would even reach the elevator in one
> way or other, and not be completely stripped away early.
> 
> What would you rather see, the elevator recognizing reorder boundaries?
> Or additional higher level queueing and extra thread/work queue/whatever?
> 
> Both are fine with me, I'm just asking for an opinion.

First of all, using FLUSH/FUA for such purpose is an error-prone
abuse.  You're trying to exploit an implementation detail which may
change at any time.  I think what you want is to be able to specify
REQ_SOFTBARRIER on bio submission, which shouldn't be too hard but I'm
still lost why this is necessary.  Can you please explain it a bit
more?

Thanks.

-- 
tejun
