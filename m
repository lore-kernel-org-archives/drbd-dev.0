Return-Path: <lars@linbit.com>
Date: Sat, 4 Sep 2004 12:43:38 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [Drbd-dev] Another drbd race
Message-ID: <20040904104338.GA16617@nudl>
References: <20040819110202.GO9601@marowsky-bree.de>
	<20040819113205.GP9601@marowsky-bree.de>
	<R+ahoCHARbsLOMKIahWH0/Q=lge@web.de>
	<200408201452.52512.philipp.reisner@linbit.com>
	</+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
	<20040904094814.GE11820@marowsky-bree.de>
	<20040904100008.GA14645@nudl>
	<20040904101813.GF11820@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040904101813.GF11820@marowsky-bree.de>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Sep 04, 2004 at 12:18:14PM +0200, Lars Marowsky-Bree wrote:
> On 2004-09-04T12:00:08,
>    Lars Ellenberg <lars.ellenberg@linbit.com> said:
> 
> Yep, that should be enough to detect this on the secondary. But:
> 
> > Most likely right after connection loss the Primary should blocks for a
> > configurable (default: infinity?) amount of time before giving end_io
> > events back to the upper layer.
> > We then need to be able to tell it to resume operation (we can do this,
> > as soon as we took precautions to prevent the Secondary to become
> > Primary without being forced or resynced before).
> > 
> > Or, if the cluster decides to do so, the Secondary has time to STONITH
> > the Primary (while that is still blocking) and take over.
> > 
> > I want to include a timeout, so the cluster manager don't need to
> > know about "peer is dead" notification, it only needs to know about
> > STONITH.
> 
> If it defaults to an 'infinite' timeout, which is safe, we need the
> resume operation. (Or rather, notification about the successful "peer is
> dead now" event.) This is easy to add.
> 
> And it is needed, because 
> 
> a) if the fencing _failed_, the primary needs to stay blocked until it
> eventually succeeds. This is a correctness issue.
> 
> a) otherwise drbd would _always_ block for at least that amount of time
> when it lost the secondary, even though it's been fenced since seconds
> (or even we may have fenced it before drbd's internal peer timeout hits,
> in which case it wouldn't ever block). This is a performance issue.
> 
> The combination of a+b gives a very good argument for having a resume
> operation, which the new CRM will be able to drive in a couple of weeks
> ;-)

I did not say we need either/or, I say I want an _additional_ timeout,
which defaults to infinity; so I have the _choice_ to run with a cluster
manager that does only know about stonith (and yes then there still
remains a race, and it might just block for say 2 minutes even if it
won't need to, but it won't lose any writes anymore). Of course we can
optimize, and I'd like to; but we need to be correct first.
so don't argue if you don't disagree.

> > Maybe we want to introduce this functionality as a new wire protocoll,
> > or only in proto C.
> 
> It doesn't actually need to be a new wire protocol, it just needs an
> additional option set (ie, the Oracle mode) and the 'resume' operation
> on the primary; or actually, that could be mapped to an explicit switch
> from WFConnection to StandAlone.

I did not say it needs to be, I suggest it would make sense, and that it
won't make much sense to have that option with proto A or B, because it
would make the user "feel" he never loses writes while the asynchronouse
protocols might lose commits anyways.

The "oracle" option I'd like to call "write quorum", and thats a
different, though related issue. we either make sure it is written to at
least two (we currently can not do more than that) independend stable
storages, or we don't acknowledge the write at all (or maybe even fail
it, if that makes any sense) to the application layer.
we then no longer have service HA (unless we introduce a concept of
additional peers and multiple hot standby mirrors), but we have data
security. this is indeed not a protocol change, but an option.
the implementation of which needs to be verified and improved.
but at least we have it.

	lge
