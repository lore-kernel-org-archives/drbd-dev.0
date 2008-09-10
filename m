Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Sep 2008 16:13:43 -0400
Message-ID: <DA0E7D869C862D4095C265233CD1D41E011929A3@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Problems with code to disallow connection when peer has
	mismatched UUID
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

A change made to DRBD 8.2 on 3/25/08 (commit e817888f) to forcibly
disconnect in receive_uuids in some cases seems to be causing us
problems in some scenarios - the specific sequence is this (see detailed
trace extracts at the end of this)

. We start with node1 secondary and node0 primary and then disconnect
and reconnect
. This causes us to enter PausedSyncT on node1 and PausedSyncS on node0
(because higher priority devices
  are syncing)
. Now we swap primaryness so node1 is Primary/PausedSyncT/Inconsistent
and node0 is Secondary/PausedSyncS/UpToDate
. Lose connection again - because Node1 is primary, we create a new
current UUID.
. Now we connect again - the code in receive_uuids on Node1 refuses to
connect because it's Primary/Inconsistent and
  the other node is using a different UUID.
. We are now stuck in a loop trying to connect and dropping the
connection continually - no way to fix automatically either
  since no event is generated that a user mode program could use to
trigger recovery.

I'm not sure what the right answer is here, but I have a couple of
observations:
1. When we lose connection and are Primary/Inconsistent, should we
really create a new current UUID? The local data is bad.
2. When trying to connect and we are Primary/Inconsistent, shouldn't we
accept the connection even if the UUIDs are different?
   Surely the uuid handshake will calculate the correct way to
synchronize in this case? It certainly would in the above
   case (and you can see this in the trace from node1)

Here's the code in question:

    if (mdev->state.conn < Connected &&
        mdev->state.disk < Outdated &&
        mdev->state.role =3D=3D Primary &&
        (mdev->ed_uuid & ~((u64)1)) !=3D (p_uuid[Current] & ~((u64)1))) =
{
        ERR("Can only connect to data with current UUID=3D%016llX\n",
            (unsigned long long)mdev->ed_uuid);
        drbd_force_state(mdev,NS(conn,Disconnecting));
        return FALSE;
    }

Any thoughts?
Simon

Trace from node1:

   6719:Aug 18 22:45:05 node1 kernel: drbd38: conn( WFConnection ->
WFReportParams )=20
   6722:Aug 18 22:45:05 node1 kernel: drbd38: drbd_sync_handshake:
   6723:Aug 18 22:45:05 node1 kernel: drbd38: self
CADAA290A29A95F0:0000000000000000:4CC7FE9AE8243C78:0000000000000006
   6724:Aug 18 22:45:05 node1 kernel: drbd38: peer
678FDAD7A9A6D636:CADAA290A29A95F0:8ACAF333A2BE196A:4CC7FE9AE8243C78
   6725:Aug 18 22:45:05 node1 kernel: drbd38: uuid_compare()=3D-1 by =
rule
5
   6726:Aug 18 22:45:05 node1 kernel: drbd38: Becoming sync target due
to disk states.
   6727:Aug 18 22:45:05 node1 kernel: drbd38: peer( Unknown -> Secondary
) conn( WFReportParams -> WFBitMapT ) pdsk( DUnknown -> UpToDate )
peer_isp( 0 -> 1 )=20
   6729:Aug 18 22:45:05 node1 kernel: drbd38: conn( WFBitMapT ->
WFSyncUUID )=20
   6730:Aug 18 22:45:05 node1 kernel: drbd38:  exposed data uuid now
3633090B73366ED2
   6731:Aug 18 22:45:05 node1 kernel: drbd38:  uuid[Current] now
3633090B73366ED2
   6732:Aug 18 22:45:05 node1 kernel: drbd38:  uuid[Bitmap] now
0000000000000000
   6734:Aug 18 22:45:05 node1 kernel: drbd38: conn( WFSyncUUID ->
PausedSyncT )=20
   6735:Aug 18 22:45:05 node1 kernel: drbd38: Began resync as
PausedSyncT (will sync 118668 KB [29667 bits set]).
   7027:Aug 18 22:46:07 node1 kernel: drbd38: role( Secondary -> Primary
)=20
   7437:Aug 18 22:46:39 node1 kernel: drbd38: meta connection shut down
by peer.
   7438:Aug 18 22:46:39 node1 kernel: drbd38: peer( Secondary -> Unknown
) conn( PausedSyncT -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
peer_isp( 1 -> 0 )=20
   7456:Aug 18 22:46:39 node1 kernel: drbd38: sock was shut down by peer
   7460:Aug 18 22:46:39 node1 kernel: drbd38: Creating new current UUID
   7461:Aug 18 22:46:39 node1 kernel: drbd38:  uuid[Bitmap] now
3633090B73366ED3
   7462:Aug 18 22:46:39 node1 kernel: drbd38:  exposed data uuid now
A398D35216141B4D
   7463:Aug 18 22:46:39 node1 kernel: drbd38:  uuid[Current] now
A398D35216141B4D
   7464:Aug 18 22:46:39 node1 kernel: drbd38: Writing meta data super
block now.
   7486:Aug 18 22:46:39 node1 kernel: drbd38: Connection closed
   7487:Aug 18 22:46:39 node1 kernel: drbd38: Considering state change
from bad state. Error would be: 'Refusing to be Primary without at least
one UpToDate disk'
   7488:Aug 18 22:46:39 node1 kernel: drbd38:  old =3D { =
cs:NetworkFailure
st:Primary/Unknown ds:Inconsistent/DUnknown ra-- }
   7489:Aug 18 22:46:39 node1 kernel: drbd38:  new =3D { cs:Unconnected
st:Primary/Unknown ds:Inconsistent/DUnknown ra-- }
   7490:Aug 18 22:46:39 node1 kernel: drbd38: conn( NetworkFailure ->
Unconnected )=20
   7491:Aug 18 22:46:39 node1 kernel: drbd38: receiver terminated
   7492:Aug 18 22:46:39 node1 kernel: drbd38: receiver (re)started
   7493:Aug 18 22:46:39 node1 kernel: drbd38: Considering state change
from bad state. Error would be: 'Refusing to be Primary without at least
one UpToDate disk'
   7494:Aug 18 22:46:39 node1 kernel: drbd38:  old =3D { cs:Unconnected
st:Primary/Unknown ds:Inconsistent/DUnknown ra-- }
   7495:Aug 18 22:46:39 node1 kernel: drbd38:  new =3D { cs:WFConnection
st:Primary/Unknown ds:Inconsistent/DUnknown ra-- }
   7496:Aug 18 22:46:39 node1 kernel: drbd38: conn( Unconnected ->
WFConnection )=20
   7560:Aug 18 22:46:40 node1 kernel: drbd38: Handshake successful:
Agreed network protocol version 88
   7561:Aug 18 22:46:40 node1 kernel: drbd38: Considering state change
from bad state. Error would be: 'Refusing to be Primary without at least
one UpToDate disk'
   7562:Aug 18 22:46:40 node1 kernel: drbd38:  old =3D { cs:WFConnection
st:Primary/Unknown ds:Inconsistent/DUnknown ra-- }
   7563:Aug 18 22:46:40 node1 kernel: drbd38:  new =3D { =
cs:WFReportParams
st:Primary/Unknown ds:Inconsistent/DUnknown ra-- }
   7564:Aug 18 22:46:40 node1 kernel: drbd38: conn( WFConnection ->
WFReportParams )=20
   7580:Aug 18 22:46:40 node1 kernel: drbd38: Can only connect to data
with current UUID=3DA398D35216141B4D
   7581:Aug 18 22:46:40 node1 kernel: drbd38: conn( WFReportParams ->
Disconnecting )=20
   7586:Aug 18 22:46:40 node1 kernel: drbd38: Connection closed

Trace from Node0:

   5185:Aug 18 22:45:06 node0 kernel: drbd38: conn( StandAlone ->
Unconnected )=20
   5188:Aug 18 22:45:06 node0 kernel: drbd38: conn( Unconnected ->
WFConnection )=20
   5197:Aug 18 22:45:06 node0 kernel: drbd38: aftr_isp( 0 -> 1 )=20
   5248:Aug 18 22:45:06 node0 kernel: drbd38: Handshake successful:
Agreed network protocol version 88
   5249:Aug 18 22:45:06 node0 kernel: drbd38: conn( WFConnection ->
WFReportParams )=20
   5250:Aug 18 22:45:06 node0 kernel: drbd38: Starting asender thread
(from drbd38_receiver [16796])
   5251:Aug 18 22:45:06 node0 kernel: drbd38: data-integrity-alg:
<not-used>
   5252:Aug 18 22:45:06 node0 kernel: drbd38: drbd_sync_handshake:
   5253:Aug 18 22:45:06 node0 kernel: drbd38: self
678FDAD7A9A6D636:CADAA290A29A95F0:8ACAF333A2BE196A:4CC7FE9AE8243C78
   5254:Aug 18 22:45:06 node0 kernel: drbd38: peer
CADAA290A29A95F0:0000000000000000:4CC7FE9AE8243C78:0000000000000006
   5255:Aug 18 22:45:06 node0 kernel: drbd38: uuid_compare()=3D1 by rule =
7
   5256:Aug 18 22:45:06 node0 kernel: drbd38: Becoming sync source due
to disk states.
   5257:Aug 18 22:45:06 node0 kernel: drbd38: peer( Unknown -> Secondary
) conn( WFReportParams -> WFBitMapS ) pdsk( Outdated -> Inconsistent )
peer_isp( 0 -> 1 )=20
   5258:Aug 18 22:45:06 node0 kernel: drbd38: Writing meta data super
block now.
   5263:Aug 18 22:45:06 node0 kernel: drbd38:  uuid[History_start] now
CADAA290A29A95F0
   5264:Aug 18 22:45:06 node0 kernel: drbd38:  uuid[Bitmap] now
3633090B73366ED2
   5265:Aug 18 22:45:06 node0 kernel: drbd38: conn( WFBitMapS ->
PausedSyncS )=20
   5266:Aug 18 22:45:06 node0 kernel: drbd38: Began resync as
PausedSyncS (will sync 118668 KB [29667 bits set]).
   5267:Aug 18 22:45:06 node0 kernel: drbd38: Writing meta data super
block now.
   5410:Aug 18 22:46:07 node0 kernel: drbd38: peer( Secondary -> Primary
)=20
   5427:Aug 18 22:46:39 node0 kernel: drbd38: PingAck did not arrive in
time.
   5428:Aug 18 22:46:39 node0 kernel: drbd38: peer( Primary -> Unknown )
conn( PausedSyncS -> NetworkFailure ) peer_isp( 1 -> 0 )=20
   5434:Aug 18 22:46:39 node0 kernel: drbd38: Connection closed
   5435:Aug 18 22:46:39 node0 kernel: drbd38: conn( NetworkFailure ->
Unconnected )=20
   5438:Aug 18 22:46:39 node0 kernel: drbd38: conn( Unconnected ->
WFConnection )=20
   5546:Aug 18 22:46:40 node0 kernel: drbd38: Handshake successful:
Agreed network protocol version 88
   5547:Aug 18 22:46:40 node0 kernel: drbd38: conn( WFConnection ->
WFReportParams )=20
   5561:Aug 18 22:46:40 node0 kernel: drbd38: meta connection shut down
by peer.
   5562:Aug 18 22:46:40 node0 kernel: drbd38: conn( WFReportParams ->
NetworkFailure )=20
   5573:Aug 18 22:46:40 node0 kernel: drbd38: Connection closed
   5574:Aug 18 22:46:40 node0 kernel: drbd38: conn( NetworkFailure ->
Unconnected )=20
   5577:Aug 18 22:46:40 node0 kernel: drbd38: conn( Unconnected ->
WFConnection )=20
   5598:Aug 18 22:46:43 node0 kernel: drbd38: Handshake successful:
Agreed network protocol version 88
   5599:Aug 18 22:46:43 node0 kernel: drbd38: conn( WFConnection ->
WFReportParams )=20
   5600:Aug 18 22:46:43 node0 kernel: drbd38: Starting asender thread
(from drbd38_receiver [16796])
   5602:Aug 18 22:46:43 node0 kernel: drbd38: drbd_sync_handshake:
   5603:Aug 18 22:46:43 node0 kernel: drbd38: self
678FDAD7A9A6D636:3633090B73366ED2:CADAA290A29A95F0:8ACAF333A2BE196A
   5604:Aug 18 22:46:43 node0 kernel: drbd38: peer
A398D35216141B4D:3633090B73366ED3:4CC7FE9AE8243C78:0000000000000006
   5605:Aug 18 22:46:43 node0 kernel: drbd38: uuid_compare()=3D100 by =
rule
9
   5606:Aug 18 22:46:43 node0 kernel: drbd38: Becoming sync source due
to disk states.
   5607:Aug 18 22:46:43 node0 kernel: drbd38: peer( Unknown -> Primary )
conn( WFReportParams -> WFBitMapS ) peer_isp( 0 -> 1 )=20
   5609:Aug 18 22:46:43 node0 kernel: drbd38: meta connection shut down
by peer.
   5610:Aug 18 22:46:43 node0 kernel: drbd38: peer( Primary -> Unknown )
conn( WFBitMapS -> NetworkFailure ) peer_isp( 1 -> 0 )=20
   5611:Aug 18 22:46:43 node0 kernel: drbd38: asender terminated
   5612:Aug 18 22:46:43 node0 kernel: drbd38: Terminating asender thread

