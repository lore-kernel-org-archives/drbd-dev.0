Return-Path: <lars@linbit.com>
Date: Tue, 7 Sep 2004 14:05:02 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Message-ID: <20040907120502.GA12518@nudl>
References: <20040819110202.GO9601@marowsky-bree.de>
	<200409071139.29609.philipp.reisner@linbit.com>
	<20040907101343.GA5638@nudl>
	<200409071332.02477.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409071332.02477.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 07, 2004 at 01:32:02PM +0200, Philipp Reisner wrote:
> > I would like to introduce an additional Node state for the o_state:
> > Dead. it is never "recognized" internally, but can be set by the
> > operator or cluster manager. basically, if we go to WhatEver/Unknown,
> > we don't accept anything (since we don't want to risk split brain).
> > some higher authority can and needs to resolve this, telling us the peer
> > is dead (after a successfull stonith, when we are Secondary and shall be
> > promoted).
> >
> >
> > now we have this:
> >   P/S --- S/P
> >   P/? -:- S/?
> >
> >  A)
> >   if this is in fact (from the pov of heartbeat)
> >   P/? -.. XXX
> >     we stonith it (just to be sure) and tell it "peer dead"
> >   P/D -..
> >     (and there it resumes).
> >
> >  B)
> >   if this is in fact (from the pov of heartbeat)
> >   P/? XXX S/?
> >     - we do nothing
> >       (blocks until network is fixed again)
> >     - we tell S that it is outdated,
> >       then tell P to resume
> >     - or we make it (by STONITH) into either A or C
> >
> >  C)
> >   if this is in fact (from the pov of heartbeat)
> >   XXX ..- S/?
> >     we stonith it (just to be sure) and tell it "peer dead"
> >   XXX ..- S/D
> >     (and there it accepts to be promoted again).
> >
> >
> > similar after bootup:
> >   we refuse to be promoted to Primary from Secondary/Unknown,
> >   unless we got an explicit "peer dead" confirmation by someone.
> >
> > does that make any sense?
> >
> 
> I like it a lot!
> 
> Thus we will not call it "drbdadm resume-io r0" but 
> "drbdadm peer-dead r0"
> 
> I think the assertion that the peer is dead 
> (short "peer-dead")  is a lot easier to understand than
> a "resume-io" command.
> 
> 
> Also the question at the startup-user-dialog: 
> 
> Is the peer dead ? 
> 
> Is easier to get right....


maybe we still need to have this a two-stage process:
after reboot, and we remain in Secondary/Unknown,
we need to be told "peer dead", but we also need to get the confirmation
"up-to-date" (just to cover our ass).

when it was just a connection loss, we *are* up-to-date, and just need the
confirmation "peer dead"; or we get the confirmation "link dead, peer
alive", which basically is "you are outdated!".

just so we cannot be blamed for "automatically losing transactions",
even in a multiple failure scenario.

	lge
