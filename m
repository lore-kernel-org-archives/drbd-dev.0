Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: disconnecting while already disconnecting can
	hang the receiver
Date: Tue, 27 Nov 2007 08:06:46 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47A3F@EXNA.corp.stratus.com>
In-Reply-To: 200711271136.12545.philipp.reisner@linbit.com
References: <BD7042533C2F8943A6A4257A9E31C4543D15E5@EXNA.corp.stratus.com>
	200711271136.12545.philipp.reisner@linbit.com
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
I looked at my notes...To reproduce this you can fake the condition this
way:
* Issue a disconnect on node0 for r5.
* Locally on node1 we will get into drbd_receiver.c:drbd_disconnect()
and while there in drbd_disconnect() (Put a small delay there or
something); issue a "drbdsetup /dev/drbd5 disconnect".

This last drbdsetup will time out with " No response from the DRBD
driver! Is the module loaded?"
But the driver will be waiting forever in
drbd_nl.c:drbd_nl_disconnect().

Hope that helps. If not I'll back out my fix and sent you the exact
instrumentation to reproduce it.

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Tuesday, November 27, 2007 5:36 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: disconnecting while already disconnecting
can hang the receiver

On Monday 19 November 2007 00:11:36 Montrose, Ernest wrote:
> Hi all,
> There is problem that manifest itself this way:
>
> Consider 2 nodes A and B,  "A" issues a disconnect to r2, B gets into
> drbd_receiver.c: drbd_disconnect().  While B is disconnecting, it gets
a
> "disconnect" request for r2.  This hangs the receiver.
>
> I am thinking that we should just not allow the state transition to
> "disconnecting" if we are already doing so. We could redefine
"Standalone"
> to mean less then or equal to "TearDown" in some cases.  I include a
patch
> to show this.
>

Hi Ernest,

I tried hard to reproduce/understand this. I tried with various=20
instrumentations but I can not reproduce this.=20

I assumed that it "hangs" in the drbd_state_lock() function, but
I could not find it by experiment nor by drawing timing diagrams.

Could you provide some LOGs of this event ?

Thanks!

The best I get:

Node1:
[42951592.560000] drbd0: state_locked
[42951592.560000] drbd0: state_unlocked
[42951592.560000] drbd0: peer( Secondary -> Unknown ) conn( Connected ->
Disconnecting ) pdsk( UpToDate -> DUnknown )
[42951592.560000] drbd0: state_locked
[42951592.560000] drbd0: state_unlocked
[42951592.560000] drbd0: Writing meta data super block now.
[42951592.560000] drbd0: sock was shut down by peer
[42951592.560000] drbd0: short read expecting header on sock: r=3D0
[42951592.560000] drbd0: sock_recvmsg returned -104
[42951592.560000] drbd0: asender terminated
[42951592.560000] drbd0: tl_clear()
[42951592.560000] drbd0: Connection closed
[42951592.560000] drbd0: conn( Disconnecting -> StandAlone )
[42951592.560000] drbd0: receiver terminated

Node2:
[42951603.570000] drbd0: state_locked
[42951603.570000] drbd0: peer( Secondary -> Unknown ) conn( Connected ->
TearDown ) pdsk( UpToDate -> DUnknown )
[42951603.570000] drbd0: Writing meta data super block now.
[42951603.570000] drbd0: state_unlocked
[42951603.570000] drbd0: conn( TearDown -> Disconnecting )
[42951603.570000] drbd0: asender terminated
[42951603.570000] drbd0: tl_clear()
[42951603.570000] drbd0: Connection closed
[42951603.570000] drbd0: conn( Disconnecting -> StandAlone )
[42951603.570000] drbd0: receiver terminated

Of course the state transition TearDown -> Disconnecting is not
right/fine, but
I can not reproduce a hang of the receiver...

-phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
