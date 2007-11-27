Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: disconnecting while already disconnecting can
	hang the receiver
Date: Tue, 27 Nov 2007 11:36:12 +0100
References: <BD7042533C2F8943A6A4257A9E31C4543D15E5@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C4543D15E5@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711271136.12545.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 19 November 2007 00:11:36 Montrose, Ernest wrote:
> Hi all,
> There is problem that manifest itself this way:
>
> Consider 2 nodes A and B,  "A" issues a disconnect to r2, B gets into
> drbd_receiver.c: drbd_disconnect().  While B is disconnecting, it gets a
> "disconnect" request for r2.  This hangs the receiver.
>
> I am thinking that we should just not allow the state transition to
> "disconnecting" if we are already doing so. We could redefine "Standalone"
> to mean less then or equal to "TearDown" in some cases.  I include a patch
> to show this.
>

Hi Ernest,

I tried hard to reproduce/understand this. I tried with various 
instrumentations but I can not reproduce this. 

I assumed that it "hangs" in the drbd_state_lock() function, but
I could not find it by experiment nor by drawing timing diagrams.

Could you provide some LOGs of this event ?

Thanks!

The best I get:

Node1:
[42951592.560000] drbd0: state_locked
[42951592.560000] drbd0: state_unlocked
[42951592.560000] drbd0: peer( Secondary -> Unknown ) conn( Connected -> Disconnecting ) pdsk( UpToDate -> DUnknown )
[42951592.560000] drbd0: state_locked
[42951592.560000] drbd0: state_unlocked
[42951592.560000] drbd0: Writing meta data super block now.
[42951592.560000] drbd0: sock was shut down by peer
[42951592.560000] drbd0: short read expecting header on sock: r=0
[42951592.560000] drbd0: sock_recvmsg returned -104
[42951592.560000] drbd0: asender terminated
[42951592.560000] drbd0: tl_clear()
[42951592.560000] drbd0: Connection closed
[42951592.560000] drbd0: conn( Disconnecting -> StandAlone )
[42951592.560000] drbd0: receiver terminated

Node2:
[42951603.570000] drbd0: state_locked
[42951603.570000] drbd0: peer( Secondary -> Unknown ) conn( Connected -> TearDown ) pdsk( UpToDate -> DUnknown )
[42951603.570000] drbd0: Writing meta data super block now.
[42951603.570000] drbd0: state_unlocked
[42951603.570000] drbd0: conn( TearDown -> Disconnecting )
[42951603.570000] drbd0: asender terminated
[42951603.570000] drbd0: tl_clear()
[42951603.570000] drbd0: Connection closed
[42951603.570000] drbd0: conn( Disconnecting -> StandAlone )
[42951603.570000] drbd0: receiver terminated

Of course the state transition TearDown -> Disconnecting is not right/fine, but
I can not reproduce a hang of the receiver...

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
