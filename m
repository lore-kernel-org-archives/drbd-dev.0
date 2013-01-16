Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2C02F1019A3E
	for <drbd-dev@lists.linbit.com>; Wed, 16 Jan 2013 11:26:21 +0100 (CET)
Date: Wed, 16 Jan 2013 11:26:21 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Pallai Roland <dap@magex.hu>
Message-ID: <20130116102621.GI18620@soda.linbit>
References: <CALj=1wh+JA2m9nuhtS_+eyuvvK9GBaY+W2RYc71YPaxh1+PUhw@mail.gmail.com>
	<CALj=1whe16wjWO=DFgqPRz=uwxKQTnSOVNq=FM8RymF1aALVow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALj=1whe16wjWO=DFgqPRz=uwxKQTnSOVNq=FM8RymF1aALVow@mail.gmail.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] /usr/lib/drbd/crm-unfence-peer.sh: fencing rule leak?
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Dec 21, 2012 at 09:21:25PM +0100, Pallai Roland wrote:
> Hi,

Sorry for this long response time.
The message got lost in the moderation queue just before x-mas,
and then again on the list (probably because of the old time stamp).

Comments below.

> I have 3 remote sites in a Pacemaker cluster with quorum, 2 sites has
> DRBD nodes (active-passive). There's one common communication path for
> Corosync and DRBD. One site is preferred as primary. When the primary
> node gets unclean shutdown, other site promoted as primary as
> expected.
> When the failed node reboots, it starts- and *immediately* promotes
> DRBD as expected. Promoting may done before DRBD even connects so it
> goes online with stale data sometimes - I'm using resource fencing
> scripts to prevent this behavior.
> 
> Unfortunately there's a problem triggered by short network blackouts:
> the unfencing script leaks random fencing rules that can prevent
> failover on real outages later. I have a "high" token timeout in
> corosync.conf (180s), thoose short blackouts are not detected by
> Pacemaker at all.
>
> Based on logs I tried to reconstruct what happens:
> 
> * nodeP: the preferred node
> * nodeS: the secondary node (currently is the Pacemaker DC)
> * nodeX: the quorum site (there are the clients)
> 
> 1. network outage; nodeP and nodeX has the quorum
> 2. detected by both DRBD soon (PingAck timeout)
> => Case I:
> 3. nodeP: DRBD fence-peer script called and *finished* successfully
> 4. network restored
> 5. DRBD communication restored, Sync finished almost immediately
> 6. nodeS: crm-unfence-peer.sh called; $have_constraint in
> drbd_peer_fencing() is false, so does nothing and exit [1]
> 7. nodeS: CIB gets replicated, the fencing rule appears in local CIB
> => Case II:
> 3. nodeP: DRBD fence-peer script called and *blocked* somewhere
> 4. network restored
> 5. DRBD communication restored, Sync finished almost immediately
> 6. nodeS: crm-unfence-peer.sh called; $have_constraint in
> drbd_peer_fencing() is false, so does nothing and exit [1]
> 7. nodeP: crm-fence-peer.sh finished
> 8. nodeS: the fencing rule appears in local CIB
> 
> [1] http://git.drbd.org/gitweb.cgi?p=drbd-8.3.git;a=blob;f=scripts/crm-fence-peer.sh;h=dc776a3d1b7f313bcd315bef3029e841de7646cb;hb=HEAD#l298
> 
> Case II. only can happen when outage is short (< $dc_timeout), case I.
> even when outage is longer but there are just a few bytes to Sync -
> otherwise the cluster have time to "finalize" the local CIB.
> 
> Actually this is a race between the communication paths of DRBD and
> Pacemaker so can be solved by separate the paths. Unfortunately I have
> no possibility for that, this is a low cost SOHO project. Another
> solution could be to call the unfence script on the primary node, but
> drbd.conf's handlers does not support this AFAIK.
> So I made a patch for /usr/lib/drbd/crm-unfence-peer.sh that fixed the
> problem (attached), but I'm not sure if this is a proper solution,
> please share your opinion.
> 
> The fencing is used only to prevent split-brain after unclean reboot
> of the preferred node - if there's another solution for this, I can
> drop resource fencing without drawbacks in this setup.
> 
> I'm using version 8.3.7 with Debian Squeeze.
> (Or is it a drbd-user@ question..?)

drbd-dev is actually for *coordination* of development, mostly,
so yes, it should better be suited for drbd-user.

You may need to adjust the various timeouts for DRBD,
and the timeouts in the crm-fence-peer.sh handler as well.

The call to cibadmin is supposed to be synchronous (so unless the
cluster communication is down at that time, the constraint is supposed
to be known on all nodes once cibadmin returns).
Now that you mention it, maybe we need to add --sync-call to the
cibadmin -C invokations.

If the cluster communication was completely down at that point,
at least one node should have been stonithed...

But still, the race, or races, you describe
would still be possible in one form or an other.

The only sane way I see would be to add some logic to the resource agent
monitor section, and try to reliably detect a "healthy" replication (all
nodes "UpToDate"), then "race free" remove a possibly leaked constraint.

Unless cibadmin has a "compare exchange" mode, I don't see how you can
do this race free. Hm, okay, you could protect both "critical sections"
of crm-fence-peer and the resource agent monitor with flock, maybe.

in monitor:
	(
	flock -x -w $some_timeout 42 || exit
	constraint=$(cibadmin -Q | grep_out_the_constraint_if_any)
	if [[ $constraint ]] ; then
		if all_nodes_are_up_to_date; then
			remove_constraint
		fi
	fi
	) 42> /same/lock/file/for/both/scripts

in crm-fence-peer.sh
	(
	# no timeout here.
	flock -x 42 || exit
	place_constraint
	) 42> /same/lock/file/for/both/scripts



-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
