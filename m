Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 81672142F3
	for <drbd-dev@lists.linbit.com>; Tue,  7 Sep 2004 13:32:03 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Date: Tue, 7 Sep 2004 13:32:02 +0200
References: <20040819110202.GO9601@marowsky-bree.de>
	<200409071139.29609.philipp.reisner@linbit.com>
	<20040907101343.GA5638@nudl>
In-Reply-To: <20040907101343.GA5638@nudl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409071332.02477.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tuesday 07 September 2004 12:13, Lars Ellenberg wrote:
> On Tue, Sep 07, 2004 at 11:39:29AM +0200, Philipp Reisner wrote:
> > On Saturday 04 September 2004 12:00, Lars Ellenberg wrote:
> > > On Sat, Sep 04, 2004 at 11:48:14AM +0200, Lars Marowsky-Bree wrote:
> > > > Hi,
> > > >
> > > > lge and I have yesterday discussed a 'new' drbd race condition and
> > > > also touched on its resolution.
> > > >
> > > > Scope: in a split-brain, drbd might confirm write to the clients and
> > > > might on a subsequent failover lose the transactions which _have been
> > > > confirmed_. This is not acceptable.
> > > >
> > > > Sequence:
> > > >
> > > > Step N1 Link N2
> > > > 1 P ok S
> > > > 2 P breaks S node1 notices, goes into stand alone,
> > > >     stops waiting for N2 to confirm.
> > > > 3 P broken S S notices, initiates fencing
> > > > 4 x broken P N2 becomes primary
> > > >
> > > > Writes which have been done in between step 2-4 will have been
> > > > confirmed to the higher layers, but are not actually available on N2.
> > > > This is data loss; N2 is still consistent, but lost confirmed
> > > > transaction.
> > > >
> > > > Partially, this is solved by the Oracle-requested "only ever confirm
> > > > if committed to both nodes", but of course then if it's not a broken
> > > > link, but N2 really went down, we'd be blocking on N1 forever, which
> > > > we don't want to do for HA.
> > > >
> > > > So, here's the new sequence to solve this:
> > > >
> > > > Step N1 Link N2
> > > > 1 P ok S
> > > > 2 P(blk) ok X P blocks waiting for acks; heartbeat
> > > >     notices that it has lost N2, and initiates
> > > >     fencing.
> > > > 3 P(blk) ok fenced heartbeat tells drbd on N1 that yes, we
> > > >     know it's dead, we fenced it, no point
> > > >     waiting.
> > > > 4 P ok fenced Cluster proceeds to run.
> > > >
> > > > Now, in this super-safe mode, if now N1 also fails after step 3 but
> > > > before N2 comes back up and is resynced, we need to make sure that N2
> > > > does refuse to become primary itself. This will probably require
> > > > additional magic in the cluster manager to handle correctly, but N2
> > > > needs an additional flag to prevent this from happening by accident.
> > > >
> > > > Lars?
> > >
> > > I think we can do this detection already with the combination of the
> > > Consistent and Connected as well as HaveBeenPrimary flag. Only the
> > > logic needs to be built in.
> >
> > I do not want to "misuse" the Consistent Bit for this.
> >
> > !Consistent  .... means that we are in the middle of a sync.
> >                    = data is not usable at all.
> >  Fenced      .... our data is 100% okay, but not the latest copy.
>
> lets call it "Outdated"
>
> my idea is that a crashed Secondary will come up as !Primary|Connected, so
> it can assume it is outdated. (similar to the choice about wfc-degr...)
>
> we can only possibly lose write transaction in the very moment we
> promote a Secondary to Primary. until we do that, and the harddisk where
> the transactions have been written to is still physically intact, the
> data is still there, though maybe not available.
>
> we can try to make sure that we never promote a Secondary that possibly
> (or knowingly) is outdated.
>
> see below.
>
> > > Most likely right after connection loss the Primary should blocks for a
> > > configurable (default: infinity?) amount of time before giving end_io
> > > events back to the upper layer.
> > > We then need to be able to tell it to resume operation (we can do this,
> > > as soon as we took precautions to prevent the Secondary to become
> > > Primary without being forced or resynced before).
> > >
> > > Or, if the cluster decides to do so, the Secondary has time to STONITH
> > > the Primary (while that is still blocking) and take over.
> > >
> > > I want to include a timeout, so the cluster manager don't need to
> > > know about "peer is dead" notification, it only needs to know about
> > > STONITH.
> >
> > I see. Makes sense, but on the other hand STONITH (more genral:
> > FENCING)  might fail, as LMB points out in one of the other mails.
> >
> > -> We should probabely _not_ offer a timeout here, as soon as
> >    "on-disconnect freeze_io;" is set, it is freezed forever.
> >    Or it gets a "drbdadm resume-io r0" from the cluster manager.
> >
> > > Maybe we want to introduce this functionality as a new wire protocoll,
> > > or only in proto C.
> >
> > I see it controled by the
> >
> > "on-disconnect freeze_io;" option.
> >
> > For N2 we need a "drbdadm fence-off r0" command and for N1 we need
> > a "drbdadm resume-io r0".
> >
> > * The fenced bit gets cleard when the resync is finished.
> > * A node refuses to become primary when the fenced bit is set.
> > * "drbdadm -- --do-what-I-say primary r0" overrules (and cleares?)
> >   the fenced bit
> >
> > To be defined: What should we do at node startup with the fenced bit.
> >                (At least display it at the user-dialog)
>
> I would like to introduce an additional Node state for the o_state:
> Dead. it is never "recognized" internally, but can be set by the
> operator or cluster manager. basically, if we go to WhatEver/Unknown,
> we don't accept anything (since we don't want to risk split brain).
> some higher authority can and needs to resolve this, telling us the peer
> is dead (after a successfull stonith, when we are Secondary and shall be
> promoted).
>
>
> now we have this:
>   P/S --- S/P
>   P/? -:- S/?
>
>  A)
>   if this is in fact (from the pov of heartbeat)
>   P/? -.. XXX
>     we stonith it (just to be sure) and tell it "peer dead"
>   P/D -..
>     (and there it resumes).
>
>  B)
>   if this is in fact (from the pov of heartbeat)
>   P/? XXX S/?
>     - we do nothing
>       (blocks until network is fixed again)
>     - we tell S that it is outdated,
>       then tell P to resume
>     - or we make it (by STONITH) into either A or C
>
>  C)
>   if this is in fact (from the pov of heartbeat)
>   XXX ..- S/?
>     we stonith it (just to be sure) and tell it "peer dead"
>   XXX ..- S/D
>     (and there it accepts to be promoted again).
>
>
> similar after bootup:
>   we refuse to be promoted to Primary from Secondary/Unknown,
>   unless we got an explicit "peer dead" confirmation by someone.
>
> does that make any sense?
>

I like it a lot!

Thus we will not call it "drbdadm resume-io r0" but 
"drbdadm peer-dead r0"

I think the assertion that the peer is dead 
(short "peer-dead")  is a lot easier to understand than
a "resume-io" command.


Also the question at the startup-user-dialog: 

Is the peer dead ? 

Is easier to get right....

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
