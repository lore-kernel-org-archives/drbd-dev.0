Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id E47312DF624E
	for <drbd-dev@lists.linbit.com>; Thu, 11 Sep 2008 11:24:51 +0200 (CEST)
Date: Thu, 11 Sep 2008 11:24:51 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Problems with code to disallow connection when peer
	has mismatched UUID
Message-ID: <20080911092451.GB9756@soda.linbit>
References: <DA0E7D869C862D4095C265233CD1D41E011929A3@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DA0E7D869C862D4095C265233CD1D41E011929A3@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Sep 10, 2008 at 04:13:43PM -0400, Graham, Simon wrote:
> A change made to DRBD 8.2 on 3/25/08 (commit e817888f) to forcibly
> disconnect in receive_uuids in some cases seems to be causing us
> problems in some scenarios - the specific sequence is this (see detailed
> trace extracts at the end of this)
> 
> . We start with node1 secondary and node0 primary and then disconnect
> and reconnect
> . This causes us to enter PausedSyncT on node1 and PausedSyncS on node0
> (because higher priority devices
>   are syncing)
> . Now we swap primaryness so node1 is Primary/PausedSyncT/Inconsistent
> and node0 is Secondary/PausedSyncS/UpToDate
> . Lose connection again - because Node1 is primary, we create a new
> current UUID.
> . Now we connect again - the code in receive_uuids on Node1 refuses to
> connect because it's Primary/Inconsistent and
>   the other node is using a different UUID.
> . We are now stuck in a loop trying to connect and dropping the
> connection continually - no way to fix automatically either
>   since no event is generated that a user mode program could use to
> trigger recovery.
> 
> I'm not sure what the right answer is here, but I have a couple of
> observations:
> 1. When we lose connection and are Primary/Inconsistent, should we
> really create a new current UUID? The local data is bad.

I don't think we should.

> 2. When trying to connect and we are Primary/Inconsistent, shouldn't we
> accept the connection even if the UUIDs are different?

And potentially time-warp the content?
No.

>    Surely the uuid handshake will calculate the correct way to
> synchronize in this case? It certainly would in the above
>    case (and you can see this in the trace from node1)

in the handshake, an inconsistent node will always lose, yes.

> Here's the code in question:
> 
>     if (mdev->state.conn < Connected &&
>         mdev->state.disk < Outdated &&
>         mdev->state.role == Primary &&
>         (mdev->ed_uuid & ~((u64)1)) != (p_uuid[Current] & ~((u64)1))) {
>         ERR("Can only connect to data with current UUID=%016llX\n",
>             (unsigned long long)mdev->ed_uuid);
>         drbd_force_state(mdev,NS(conn,Disconnecting));
>         return FALSE;
>     }

that piece of code is to avoid "time warps" of content.
the specific scenario this should protect against is:

Primary, Connected
 connection breaks.
Primary  ---?
 primary generates new "current uuid",
 and continues to write
 local disk breaks
Primary, Diskless, ---?
 connection heals
 
now, if we allow this connection and accept the data of the secondary,
we just jumped back in time.

if however the local disk "heals" (maybe it was an iSCSI disk, and some
switch has been flaky?) we allow it to attach, as it has the same UUID
as we currently have, then allow the connection and resync to happen.

at least that is what "should" happen.

-- 
: Lars Ellenberg                
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
