Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 18C68101E04F
	for <drbd-dev@lists.linbit.com>; Mon,  8 Sep 2014 15:38:17 +0200 (CEST)
Date: Mon, 8 Sep 2014 15:38:16 +0200
From: Lars <lars.ellenberg@linbit.com>
To: Imre Palik <imrep.amz@gmail.com>
Message-ID: <20140908133816.GF9353@soda.linbit>
References: <1409942478-29135-1-git-send-email-imrep.amz@gmail.com>
	<20140907095834.GA2332@hein> <540DA998.7060807@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <540DA998.7060807@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Palik, Imre" <imrep@amazon.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Matt Wilson <msw@amazon.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3] drbd: fix throttling on newly created DM
 backing devices
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

On Mon, Sep 08, 2014 at 03:05:28PM +0200, Imre Palik wrote:
> On 09/07/14 11:58, Lars wrote:
> >On Fri, Sep 05, 2014 at 08:41:18PM +0200, Imre Palik wrote:
> >>From: "Palik, Imre" <imrep@amazon.de>
> >>
> >>If the drbd backing device is a new device mapper device (e.g., a
> >>dm-linear mapping of an existing block device that contains data), the
> >>counters are initially 0 even though the device contains useful
> >>data. This causes throttling until something accesses the drbd device
> >>or the backing device.
> >
> >What was wrong with my previous proposal?
> 
> Sorry, I haven't realised you added a proposal to your reply.  It
> seems, I really needed that extra sleep during the weekend ...
> 
> Your proposal is good.  Of course, I like my last one a slightly
> better.  But as they say, beauty is in the eye of the beholder :-)
> 
> >How does changing the signedness help with
> >rs_last_events not being properly initialized?
> 
> It only helps with reasoning.  I reason with modular arithmetic way
> easier than with signed integer overflows.  Accidentally, 0 is a
> good initialisation value in case of unsigned arithmetic.
> 
> >Are you sure you have also considered all wrap-around cases?
> >
> >Maybe you are too focused on your particular corner case
> >(disk_stats starting with 0).
> >Maybe I'm just thick right now, so please explain.
> 
> The idea is that 0 is the smallest possible value for an unsigned,
> and curr_events is monotonically increasing (mod 2^32) .

The problem is: it is not :-(

It's a difference between stats that are increased by the
block core at (usually) completion time, and an atomic_t
that is increased by DRBD at just before (or just after) submittion.

Depending very much on stress in the IO subsystem,
and overall timing of events, a later call may see a smaller
"curr_events" (because rs_last_sect_ev has already increased,
but the disk stats have not yet noticed).

With unsigned, that may wrap around to UINT_MAX, which we don't want.

> This
> means, initially either curr_events > 64, that is, we enter the
> loop, and do the initialisation, or it will be bigger than 64 at
> most when we want to start throttle in an ideal world (after no more
> than 64 sectors of activity).
> 
> Basically, while you initialise rs_last_events to an ideal value
> with some calculation, I choose a safe static value.  I am content
> with both approaches.  I think, as a subsystem maintainer, you
> should choose the one you like better.  If you choose yours, then
> you can add
> Reviewed-by: Imre Palik <imrep@amazon.de>

Thanks,

	Lars

