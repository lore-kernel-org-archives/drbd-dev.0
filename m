Return-Path: <Lars.Ellenberg@linbit.com>
Date: Mon, 20 Sep 2004 18:03:42 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: linux-ha-dev@lists.linux-ha.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC] Handling of internal split-brain in multiple
	state resources
Message-ID: <bssllma/59fU4MzbzTYqnts=lge@web.de>
References: <20040910185553.GU7359@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910185553.GU7359@marowsky-bree.de>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-09-10 20:55:53 +0200
\ Lars Marowsky-Bree:
> Hi there,
> 
> this is a call for help on how to handle internal split brain with
> multiple state / replicated resources in the new CRM. I'm cc'ing the
> drbd-dev list because I'm using drbd as the example in the discussion,
> for it is the one replicated resource type we best understand. But the
> problem is applicable to all such scenarios, which is why I'd like to
> continue the discussion on the linux-ha-dev list.
> 
> My intent here is to first explain the problem, our goals, and discuss
> some approaches to solving it, none of which currently satisfy me, and
> thus I'm asking for feedback ;-) Anything from criticism to new angles
> on the problem or an approach to the solution is welcome.  It's also a
> braindump for myself of the discussions I've had with lge in the hope of
> better understanding the problem.  Maybe someone finds it helpful.
> 
> I will assume the reader has read the wiki page on Multiple Incarnations
> and Multiple States...
> 
> 
> PROBLEM:
> 
> With replicated resources managed by the CRM (and correct handling of
> replicated resources is a stated goal of the CRM work), we can run into
> the case where the resource internally loses it's ability to replicate
> due to a software bug, link failure or whatever; but the CRM itself,
> running on top of the heartbeat infrastructure, may still be able to
> talk to both incarnations.
> 
> I think in most scenarios, we will want to continue to operate in
> degraded mode; ie with only one of the two nodes. This implies that the
> data is _diverging_ between the two nodes, and there's transactions
> being committed on the active node which are not replicated. Thus,
> essentially, we have lost the ability to failover when a second fault
> occurs and takes down the active node. So there's certain
> double-failures from which this does not protect, but it can still
> protect against a single failure.
> 
> We need to make sure the node which we are not proceeding with knows
> this and marks it's data as 'outdated', 'desync' or whatever.
> 
> (In a strict replicated scenario where a write quorum of two or higher
> is required, the only option would be to freeze all IO until the
> internal split brain is resolved. This is requested by some database
> vendors and some customers (ie banks), but then addressed by either
> bringing a hot-spare for the replication target online and/or using
> additional redundant replication links. Thus, it is a different
> problem.)
> 
> The problem arises from the overlap of this scenario with the 'one node
> down' scenario from the point of view of the resource itself as I will
> go on to try and show.
> 
> Consider first the complex solution:
> 
> Time	N1	Link	N2
> 1	Master	ok	Replica		Everything's fine.
> 2	Master	fail	Replica		Link fails, one of the two nodes
> 					notices.
> 
> (It does not matter whether N1 or N2 tells us first that it noticed the
> loss of internal connectivity; first it's very very unlikely that only
> one incarnation notices the split-brain, and second it doesn't matter,
> for the vote by one incarnation is sufficient.)
> 
> Notice that this failure case is _not_ a regular monitoring failure; the
> incarnations themselves are still just fine. (Or they should report a
> real monitoring failure instead.) This means 'monitor' needs more
> semantics, essentially a special return code.
> 
> Essentially, at this point in time, the Master has to suspend IO for a
> while, because the WriteAcks from the Replica are obviously not
> arriving. (This already happens with drbd protocol C.)
> 
> We need to explicitly tell N1 that it is allowed to proceed, and that
> the N2 knows that from that point on, it's local data is Outdated (which
> is a special case of 'Inconsistent') and must refuse to become Master
> unless forced manually (with "--I-want-to-lose-transactions"). Sequence
> obviously is to first tell N2 'mark-desync' and only when that completed
> successfully then allow N1 to resume.
> 
> This is, from the master resource point of view, identical to:
> 
> Time	N1	Link	N2
> 1	Master	ok	Replica		
> 2	Master	ok	crash
> 
> Master freezes, tells us about it's internal split-brain, and we
> eventually tell it that yeah, we know, we have fenced N2 (post-fence is
> equivalent to a post-mark-desync notification). Here it also doesn't
> matter whether we receive the notification from N1 before or after we
> have noticed that N2 went down or failed. N2 has to know that if it
> crashed while being connected to a Master, it's by definition outdated.
> 
> 
> The uglyness arises, as hinted at above, from the overlap with another
> failure case, which I'm now going to illustrate.
> 
> Time	N1	Link	N2
> 1	Master	ok	Replica		Everything's fine.
> 2	crash	ok	Replica
> 
> If we notice that N1 is crashed first, that's fine. Everything will
> happen just as always, and N2 can proceed as soon as it sees the
> post-fence/stop notification, which it will see before being promoted to
> master or even being asked about it.
> 
> But, from the point of view of the replicated resource on N2, this is
> indistinguishable from the split-brain; all it knows is that it lost
> connection to it's peer. So it goes on to report this.
> 
> If this event occurs before we have noticed a monitoring failure or full
> node failure on N1 and were using the recovery method explained so far,
> we are going to assume an internal split-brain, and tell N2 to mark
> itself outdated, and then try to tell N1 to resume.  Oops. No more
> talky-talky to N1, and we just told N2 it's supposed to refuse to become
> master.
> 
> So, this requires special logic - whenever one incarnation reports an
> internal split-brain, we actively need to go and verify the status of
> the other incarnations first.
> 
> In which case we'd notice that, ah, N1 is down or experiencing a local
> resource failure, and instead of outdating N2, would fence / stop N1 and
> then promote N2.
> 
> This is the special logic I don't much like. As Rusty put it in his
> keynote, "Fear of complexity" is good for programmers. And this reeks of
> it - extending the monitor semantics, needing an additional command on
> the secondary, _and_ needing to talk to all incarnations and then
> figuring out what to do. (I don't want to think much about partitions
> with >2 resources involved.) Alas, the problem seems to be real.


if a resource not in "Primary" state reports that it does no longer know
about its peer, there is no need to hurry and mark it outdated.
we just do nothing (well, or as an optimisation trigger an immediate
monitoring poll on the Primary, or even on all other peers).
nothing bad can happen.
since a passive replica can not do any harm, there is no point in
forcing it to refuse anything...

if it really was a primary crash, we will eventually recognize and do
the failover. if it is "just" a communication problem between the
replicas, the master will soon notice itself, too, freeze io, and
wait for confirmation of some fence operation (whether this is stonith
or "mark-outdated" is not important to the master). then it will
continue.

the point why we are concerned at all is that if the Primary lost
connection to its peer, and continues to just confirm transactions,
it may have been a total communications loss, and the CRM may decide to
fence it, and fail over to the other node. in wich case transactions
that have been committed and confirmed between the connection loss event
and the actual stonith and failover are lost.

since the resource does not know, it has to block io until it gets
confirmation that the peer won't consider this node dead and continue in
master mode while this node still is in master mode... 
confirmation can be given when the CRM still can see the peer (and mark
it outdated), or if it can no longer see the peer (and stonith it).

the algorithm within the CRM is
 res = some replicating resource which no longer sees its peer
 if res is in master state
    fence the peer (by marking it outdated or stonithing it)
    tell res about that, and to continue
 if res is in passive state
    trigger immediate monitoring of the peer(s),
    but otherwise do nothing


	Lars

btw, sorry for the master,active,primary,slave,passive,secondary
confusion... we should probably agree on some terminology :-/
