Return-Path: <lmb@suse.de>
Date: Fri, 10 Sep 2004 20:55:53 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-ha-dev@lists.linux-ha.org
Message-ID: <20040910185553.GU7359@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [RFC] Handling of internal split-brain in multiple state
	resources
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi there,

this is a call for help on how to handle internal split brain with
multiple state / replicated resources in the new CRM. I'm cc'ing the
drbd-dev list because I'm using drbd as the example in the discussion,
for it is the one replicated resource type we best understand. But the
problem is applicable to all such scenarios, which is why I'd like to
continue the discussion on the linux-ha-dev list.

My intent here is to first explain the problem, our goals, and discuss
some approaches to solving it, none of which currently satisfy me, and
thus I'm asking for feedback ;-) Anything from criticism to new angles
on the problem or an approach to the solution is welcome.  It's also a
braindump for myself of the discussions I've had with lge in the hope of
better understanding the problem.  Maybe someone finds it helpful.

I will assume the reader has read the wiki page on Multiple Incarnations
and Multiple States...


PROBLEM:

With replicated resources managed by the CRM (and correct handling of
replicated resources is a stated goal of the CRM work), we can run into
the case where the resource internally loses it's ability to replicate
due to a software bug, link failure or whatever; but the CRM itself,
running on top of the heartbeat infrastructure, may still be able to
talk to both incarnations.

I think in most scenarios, we will want to continue to operate in
degraded mode; ie with only one of the two nodes. This implies that the
data is _diverging_ between the two nodes, and there's transactions
being committed on the active node which are not replicated. Thus,
essentially, we have lost the ability to failover when a second fault
occurs and takes down the active node. So there's certain
double-failures from which this does not protect, but it can still
protect against a single failure.

We need to make sure the node which we are not proceeding with knows
this and marks it's data as 'outdated', 'desync' or whatever.

(In a strict replicated scenario where a write quorum of two or higher
is required, the only option would be to freeze all IO until the
internal split brain is resolved. This is requested by some database
vendors and some customers (ie banks), but then addressed by either
bringing a hot-spare for the replication target online and/or using
additional redundant replication links. Thus, it is a different
problem.)

The problem arises from the overlap of this scenario with the 'one node
down' scenario from the point of view of the resource itself as I will
go on to try and show.

Consider first the complex solution:

Time	N1	Link	N2
1	Master	ok	Replica		Everything's fine.
2	Master	fail	Replica		Link fails, one of the two nodes
					notices.

(It does not matter whether N1 or N2 tells us first that it noticed the
loss of internal connectivity; first it's very very unlikely that only
one incarnation notices the split-brain, and second it doesn't matter,
for the vote by one incarnation is sufficient.)

Notice that this failure case is _not_ a regular monitoring failure; the
incarnations themselves are still just fine. (Or they should report a
real monitoring failure instead.) This means 'monitor' needs more
semantics, essentially a special return code.

Essentially, at this point in time, the Master has to suspend IO for a
while, because the WriteAcks from the Replica are obviously not
arriving. (This already happens with drbd protocol C.)

We need to explicitly tell N1 that it is allowed to proceed, and that
the N2 knows that from that point on, it's local data is Outdated (which
is a special case of 'Inconsistent') and must refuse to become Master
unless forced manually (with "--I-want-to-lose-transactions"). Sequence
obviously is to first tell N2 'mark-desync' and only when that completed
successfully then allow N1 to resume.

This is, from the master resource point of view, identical to:

Time	N1	Link	N2
1	Master	ok	Replica		
2	Master	ok	crash

Master freezes, tells us about it's internal split-brain, and we
eventually tell it that yeah, we know, we have fenced N2 (post-fence is
equivalent to a post-mark-desync notification). Here it also doesn't
matter whether we receive the notification from N1 before or after we
have noticed that N2 went down or failed. N2 has to know that if it
crashed while being connected to a Master, it's by definition outdated.


The uglyness arises, as hinted at above, from the overlap with another
failure case, which I'm now going to illustrate.

Time	N1	Link	N2
1	Master	ok	Replica		Everything's fine.
2	crash	ok	Replica

If we notice that N1 is crashed first, that's fine. Everything will
happen just as always, and N2 can proceed as soon as it sees the
post-fence/stop notification, which it will see before being promoted to
master or even being asked about it.

But, from the point of view of the replicated resource on N2, this is
indistinguishable from the split-brain; all it knows is that it lost
connection to it's peer. So it goes on to report this.

If this event occurs before we have noticed a monitoring failure or full
node failure on N1 and were using the recovery method explained so far,
we are going to assume an internal split-brain, and tell N2 to mark
itself outdated, and then try to tell N1 to resume.  Oops. No more
talky-talky to N1, and we just told N2 it's supposed to refuse to become
master.

So, this requires special logic - whenever one incarnation reports an
internal split-brain, we actively need to go and verify the status of
the other incarnations first.

In which case we'd notice that, ah, N1 is down or experiencing a local
resource failure, and instead of outdating N2, would fence / stop N1 and
then promote N2.

This is the special logic I don't much like. As Rusty put it in his
keynote, "Fear of complexity" is good for programmers. And this reeks of
it - extending the monitor semantics, needing an additional command on
the secondary, _and_ needing to talk to all incarnations and then
figuring out what to do. (I don't want to think much about partitions
with >2 resources involved.) Alas, the problem seems to be real.

Here's some other alternatives I've thought about which seem simpler,
but which I then noticed don't solve the problem completely.


A) Rely on the internal split-brain timeout being larger than our
deadtime of N1 and the resource monitoring interval.

This _seems_ to solve it - because then the problematic ordering does
not occur, but relies quite a bit on timing. And if the resource on N2
notices, for example, a connection loss immediately, this basically
can't be made to work. Oh yeah, it can be worked around by adding delays
etc, but that smells a bit dung-ish, too.


B) Instead of reporting the split-brain on both nodes as a special case,
fail the monitoring operation on the secondary instead. In response to
this, we'd act just as we always would, and try to stop the replica (and
maybe even try to move it somewhere else). As soon as the primary
receives this stop/fence post-notification, it is allowed to resume, and
the data on the replica is implicitly outdated until resynced.

Unfortunately, this again runs into the race as above. If the secondary
notices first and fails, we are going to respond by stopping it; but,
woah, now we figure the primary is screwed, but we just outdated /
stopped the secondary, which now refuses to become a master. So we
cannot continue.


C) Claim the damn problem is not ours to solve and that the internal
replication must be designed redundantly too. ;-) And the race _is_
fairly unlikely...


Maybe I'm over-estimating the complexity with the approach suggested,
but this is a hard problem and I definetely want to run my thoughts past
the public to make sure it's bullet proof.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

