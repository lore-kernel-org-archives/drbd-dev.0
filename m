Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: disconnecting while already disconnecting can
	hang the receiver
Date: Wed, 28 Nov 2007 09:08:21 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47A44@EXNA.corp.stratus.com>
In-Reply-To: 200711281409.50679.philipp.reisner@linbit.com
References: <BD7042533C2F8943A6A4257A9E31C4543D15E5@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47A3F@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47A42@EXNA.corp.stratus.com>
	200711281409.50679.philipp.reisner@linbit.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
Aha!! OK I apologize for this.  We are using ancient code indeed.  I
will update and retest.  We were so busy chasing the other issues that
we kept putting the merge on the back burner.  Sorry..

EM--
-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Wednesday, November 28, 2007 8:10 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: disconnecting while already disconnecting
can hang the receiver

On Tuesday 27 November 2007 22:51:21 Montrose, Ernest wrote:
> Phil,
> Phil,
> Your modification to the original patch will break it actually.  The
> reason is that we can get into "disconnecting" anywhere.  Below I have
> some logs with the problem happening.

Hi Ernest.

You are using some ancient code!

I removed the line breaks from your logs:

On Node0:
# drbdsetup /dev/drbd16 disconnect

Nov 27 16:38:20 node1 kernel: drbd16: peer( Secondary -> Unknown ) conn(
Connected -> Disconnecting ) pdsk( UpToDate -> DUnknown )
Nov 27 16:38:20 node1 kernel: drbd16: Creating new current UUID Nov 27
16:38:20 node1 kernel: drbd16: short read expecting header on sock:
r=3D-512
Nov 27 16:38:20 node1 kernel: drbd16: asender terminated
Nov 27 16:38:20 node1 kernel: drbd16: tl_clear()
Nov 27 16:38:20 node1 kernel: drbd16: Connection closed
Nov 27 16:38:20 node1 kernel: drbd16: Writing meta data super block now.
Nov 27 16:38:20 node1 kernel: drbd16: conn( Disconnecting -> StandAlone
)
Nov 27 16:38:20 node1 kernel: drbd16: receiver terminated

[
Nov 27 16:38:23 node1 kernel: drbd16: conn( StandAlone -> Unconnected )
Nov 27 16:38:23 node1 kernel: drbd16: receiver (re)started
Nov 27 16:38:23 node1 kernel: drbd16: conn( Unconnected -> WFConnection
)
Nov 27 16:38:26 node1 kernel: drbd16: conn( WFConnection ->
WFReportParams )
Nov 27 16:38:26 node1 kernel: drbd16: Handshake successful: DRBD Network
Protocol version 86
Nov 27 16:38:26 node1 kernel: drbd16: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Nov 27 16:38:26 node1 kernel: drbd16: Writing meta data super block now.
Nov 27 16:38:26 node1 kernel: drbd16: conn( WFBitMapS -> SyncSource )
pdsk( UpToDate -> Inconsistent )
Nov 27 16:38:26 node1 kernel: drbd16: Began resync as SyncSource (will
sync 4 KB [1 bits set]).
Nov 27 16:38:26 node1 kernel: drbd16: Writing meta data super block now.
Nov 27 16:38:26 node1 kernel: drbd16: Resync done (total 1 sec; paused 0
sec; 4 K/sec)
Nov 27 16:38:26 node1 kernel: drbd16: conn( SyncSource -> Connected )
pdsk( Inconsistent -> UpToDate )
Nov 27 16:38:27 node1 kernel: drbd16: Writing meta data super block now.
]

=3D=3D=3D=3D=3D=3DOn Node1=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Nov 27 16:38:20 node0 kernel: drbd16: peer( Primary -> Unknown ) conn(
Connected -> TearDown ) pdsk( UpToDate -> DUnknown )
Nov 27 16:38:20 node0 kernel: drbd16: Writing meta data super block now.
Nov 27 16:38:20 node0 kernel: drbd16: meta connection shut down by peer.
Nov 27 16:38:20 node0 kernel: drbd16: asender terminated
Nov 27 16:38:20 node0 kernel: drbd16: tl_clear()
Nov 27 16:38:20 node0 kernel: drbd16: Connection closed
Nov 27 16:38:20 node0 kernel: drbd16: conn( TearDown -> Unconnected )
Nov 27 16:38:20 node0 kernel: drbd16: drbd_disconnect: ##5# EM-- Done
but waiting 30 seconds######

=3D=3D=3D=3DIssue disconnect here=3D=3D=3D=3D=3D
# drbdsetup /dev/drbd16 disconnect
No response from the DRBD driver! Is the module loaded?
Nov 27 16:38:26 node0 kernel: drbd16: conn( Unconnected -> Disconnecting
)
Nov 27 16:38:26 node0 kernel: drbd16: drbd_nl_disconnect: EM-- Start
wait_event_interruptible for  mdev->state.conn=3D=3DStandAlone ****
Nov 27 16:38:26 node0 kernel: drbd16: drbd_disconnect: ##5# EM-- Done
##### waiting 30 seconds######
Nov 27 16:38:26 node0 kernel: drbd16: receiver terminated
Nov 27 16:38:26 node0 kernel: drbd16: receiver (re)started
Nov 27 16:38:26 node0 kernel: drbd16: ASSERT( mdev->state.conn >=3D
Unconnected ) in
/sandbox/emontros/devel/trunk/platform/drbd/src/drbd/drbd_receiver.c:715
Nov 27 16:38:26 node0 kernel: drbd16: conn( Disconnecting ->
WFConnection )  =
<=3D<<=3D=3D<<<=3D=3D=3D<<<<=3D=3D=3D=3D<<<<<=3D=3D=3D=3D=3D<<<<<<=3D=3D=3D=
=3D=3D=3D<<<<<<<=3D=3D=3D=3D=3D=3D=3D
Nov 27 16:38:26 node0 kernel: drbd16: conn( WFConnection ->
WFReportParams )
Nov 27 16:38:26 node0 kernel: drbd16: Handshake successful: DRBD Network
Protocol version 86
Nov 27 16:38:26 node0 kernel: drbd16: receive_state: EM-- ....
Nov 27 16:38:26 node0 kernel: drbd16: receive_state: EM-- ....calling
sync_handshake
Nov 27 16:38:26 node0 kernel: drbd16: peer( Unknown -> Primary ) conn(
WFReportParams -> WFBitMapT ) pdsk( DUnknown -> UpToDate )
Nov 27 16:38:26 node0 kernel: drbd16: Writing meta data super block now.
Nov 27 16:38:26 node0 kernel: drbd16: conn( WFBitMapT -> WFSyncUUID )
Nov 27 16:38:26 node0 kernel: drbd16: conn( WFSyncUUID -> SyncTarget )
disk( UpToDate -> Inconsistent )
Nov 27 16:38:26 node0 kernel: drbd16: Began resync as SyncTarget (will
sync 4 KB [1 bits set]).
Nov 27 16:38:26 node0 kernel: drbd16: Writing meta data super block now.
Nov 27 16:38:27 node0 kernel: drbd16: Resync done (total 1 sec; paused 0
sec; 4 K/sec)
Nov 27 16:38:27 node0 kernel: drbd16: conn( SyncTarget -> Connected )
disk( Inconsistent -> UpToDate )
Nov 27 16:38:27 node0 kernel: drbd16: Writing meta data super block now.

Look for the line marked with
"<=3D<<=3D=3D<<<=3D=3D=3D<<<<=3D=3D=3D=3D<<<<<=3D=3D=3D=3D=3D<<<<<<=3D=3D=
=3D=3D=3D=3D<<<<<<<=3D=3D=3D=3D=3D=3D=3D".

This state transition fails (silently) in the current code. See the
attached commit
from Aug 31. In the mean time we did two releases (8.0.6 and 8.0.7) why
is this
patch not in your code-base ?

In the current code the problem you describe is simply not existing.
Here are the logs from my machines:

node0:
[42951113.120000] drbd0: peer( Secondary -> Unknown ) conn( Connected ->
Disconnecting ) pdsk( UpToDate -> DUnknown )
[42951113.120000] drbd0: sock was shut down by peer
[42951113.120000] drbd0: short read expecting header on sock: r=3D0
[42951113.120000] drbd0: meta connection shut down by peer.
[42951113.120000] drbd0: asender terminated
[42951113.120000] drbd0: tl_clear()
[42951113.120000] drbd0: Connection closed
[42951113.120000] drbd0: Writing meta data super block now.
[42951113.120000] drbd0: conn( Disconnecting -> StandAlone )
[42951113.120000] drbd0: receiver terminated
[42951113.960000] drbd0: conn( StandAlone -> Unconnected )
[42951113.960000] drbd0: receiver (re)started
[42951113.960000] drbd0: conn( Unconnected -> WFConnection )

node1:
[42951105.980000] drbd0: peer( Secondary -> Unknown ) conn( Connected ->
TearDown ) pdsk( UpToDate -> DUnknown )
[42951105.980000] drbd0: Writing meta data super block now.
[42951105.980000] drbd0: asender terminated
[42951105.980000] drbd0: tl_clear()
[42951105.980000] drbd0: Connection closed
[42951105.980000] drbd0: conn( TearDown -> Unconnected )
[42951105.980000] drbd0: Entering sleep!
[42951107.160000] drbd0: conn( Unconnected -> Disconnecting )
[42951115.990000] drbd0: Leaving sleep!
[42951115.990000] drbd0: receiver terminated
[42951115.990000] drbd0: receiver (re)started
! ** !! Notice here. No state transition to WFConnection !! ** !
[42951115.990000] drbd0: tl_clear()
[42951115.990000] drbd0: Connection closed
[42951115.990000] drbd0: conn( Disconnecting -> StandAlone )
[42951115.990000] drbd0: Entering sleep!
[42951126.000000] drbd0: Leaving sleep!
[42951126.000000] drbd0: receiver terminated

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
