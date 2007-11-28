Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: disconnecting while already disconnecting can
	hang the receiver
Date: Wed, 28 Nov 2007 14:09:50 +0100
References: <BD7042533C2F8943A6A4257A9E31C4543D15E5@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47A3F@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47A42@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47A42@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eiWTHK6G9s4lx8G"
Message-Id: <200711281409.50679.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_eiWTHK6G9s4lx8G
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

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

Nov 27 16:38:20 node1 kernel: drbd16: peer( Secondary -> Unknown ) conn( Connected -> Disconnecting ) pdsk( UpToDate -> DUnknown )
Nov 27 16:38:20 node1 kernel: drbd16: Creating new current UUID Nov 27 16:38:20 node1 kernel: drbd16: short read expecting header on sock: r=-512
Nov 27 16:38:20 node1 kernel: drbd16: asender terminated
Nov 27 16:38:20 node1 kernel: drbd16: tl_clear()
Nov 27 16:38:20 node1 kernel: drbd16: Connection closed
Nov 27 16:38:20 node1 kernel: drbd16: Writing meta data super block now.
Nov 27 16:38:20 node1 kernel: drbd16: conn( Disconnecting -> StandAlone )
Nov 27 16:38:20 node1 kernel: drbd16: receiver terminated

[
Nov 27 16:38:23 node1 kernel: drbd16: conn( StandAlone -> Unconnected )
Nov 27 16:38:23 node1 kernel: drbd16: receiver (re)started
Nov 27 16:38:23 node1 kernel: drbd16: conn( Unconnected -> WFConnection )
Nov 27 16:38:26 node1 kernel: drbd16: conn( WFConnection -> WFReportParams )
Nov 27 16:38:26 node1 kernel: drbd16: Handshake successful: DRBD Network Protocol version 86
Nov 27 16:38:26 node1 kernel: drbd16: peer( Unknown -> Secondary ) conn( WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Nov 27 16:38:26 node1 kernel: drbd16: Writing meta data super block now.
Nov 27 16:38:26 node1 kernel: drbd16: conn( WFBitMapS -> SyncSource ) pdsk( UpToDate -> Inconsistent )
Nov 27 16:38:26 node1 kernel: drbd16: Began resync as SyncSource (will sync 4 KB [1 bits set]).
Nov 27 16:38:26 node1 kernel: drbd16: Writing meta data super block now.
Nov 27 16:38:26 node1 kernel: drbd16: Resync done (total 1 sec; paused 0 sec; 4 K/sec)
Nov 27 16:38:26 node1 kernel: drbd16: conn( SyncSource -> Connected ) pdsk( Inconsistent -> UpToDate )
Nov 27 16:38:27 node1 kernel: drbd16: Writing meta data super block now.
]

======On Node1============
Nov 27 16:38:20 node0 kernel: drbd16: peer( Primary -> Unknown ) conn( Connected -> TearDown ) pdsk( UpToDate -> DUnknown )
Nov 27 16:38:20 node0 kernel: drbd16: Writing meta data super block now.
Nov 27 16:38:20 node0 kernel: drbd16: meta connection shut down by peer.
Nov 27 16:38:20 node0 kernel: drbd16: asender terminated
Nov 27 16:38:20 node0 kernel: drbd16: tl_clear()
Nov 27 16:38:20 node0 kernel: drbd16: Connection closed
Nov 27 16:38:20 node0 kernel: drbd16: conn( TearDown -> Unconnected )
Nov 27 16:38:20 node0 kernel: drbd16: drbd_disconnect: ##5# EM-- Done but waiting 30 seconds######

====Issue disconnect here=====
# drbdsetup /dev/drbd16 disconnect
No response from the DRBD driver! Is the module loaded?
Nov 27 16:38:26 node0 kernel: drbd16: conn( Unconnected -> Disconnecting )
Nov 27 16:38:26 node0 kernel: drbd16: drbd_nl_disconnect: EM-- Start wait_event_interruptible for  mdev->state.conn==StandAlone ****
Nov 27 16:38:26 node0 kernel: drbd16: drbd_disconnect: ##5# EM-- Done ##### waiting 30 seconds######
Nov 27 16:38:26 node0 kernel: drbd16: receiver terminated
Nov 27 16:38:26 node0 kernel: drbd16: receiver (re)started
Nov 27 16:38:26 node0 kernel: drbd16: ASSERT( mdev->state.conn >= Unconnected ) in /sandbox/emontros/devel/trunk/platform/drbd/src/drbd/drbd_receiver.c:715
Nov 27 16:38:26 node0 kernel: drbd16: conn( Disconnecting -> WFConnection )  <=<<==<<<===<<<<====<<<<<=====<<<<<<======<<<<<<<=======
Nov 27 16:38:26 node0 kernel: drbd16: conn( WFConnection -> WFReportParams )
Nov 27 16:38:26 node0 kernel: drbd16: Handshake successful: DRBD Network Protocol version 86
Nov 27 16:38:26 node0 kernel: drbd16: receive_state: EM-- ....
Nov 27 16:38:26 node0 kernel: drbd16: receive_state: EM-- ....calling sync_handshake
Nov 27 16:38:26 node0 kernel: drbd16: peer( Unknown -> Primary ) conn( WFReportParams -> WFBitMapT ) pdsk( DUnknown -> UpToDate )
Nov 27 16:38:26 node0 kernel: drbd16: Writing meta data super block now.
Nov 27 16:38:26 node0 kernel: drbd16: conn( WFBitMapT -> WFSyncUUID )
Nov 27 16:38:26 node0 kernel: drbd16: conn( WFSyncUUID -> SyncTarget ) disk( UpToDate -> Inconsistent )
Nov 27 16:38:26 node0 kernel: drbd16: Began resync as SyncTarget (will sync 4 KB [1 bits set]).
Nov 27 16:38:26 node0 kernel: drbd16: Writing meta data super block now.
Nov 27 16:38:27 node0 kernel: drbd16: Resync done (total 1 sec; paused 0 sec; 4 K/sec)
Nov 27 16:38:27 node0 kernel: drbd16: conn( SyncTarget -> Connected ) disk( Inconsistent -> UpToDate )
Nov 27 16:38:27 node0 kernel: drbd16: Writing meta data super block now.

Look for the line marked with "<=<<==<<<===<<<<====<<<<<=====<<<<<<======<<<<<<<=======".

This state transition fails (silently) in the current code. See the attached commit
from Aug 31. In the mean time we did two releases (8.0.6 and 8.0.7) why is this
patch not in your code-base ?

In the current code the problem you describe is simply not existing.
Here are the logs from my machines:

node0:
[42951113.120000] drbd0: peer( Secondary -> Unknown ) conn( Connected -> Disconnecting ) pdsk( UpToDate -> DUnknown )
[42951113.120000] drbd0: sock was shut down by peer
[42951113.120000] drbd0: short read expecting header on sock: r=0
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
[42951105.980000] drbd0: peer( Secondary -> Unknown ) conn( Connected -> TearDown ) pdsk( UpToDate -> DUnknown )
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
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :

--Boundary-00=_eiWTHK6G9s4lx8G
Content-Type: text/x-diff; charset="iso-8859-1";
	name="baec52c8af1da0b23a38978e358c24066ff08ef7.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="baec52c8af1da0b23a38978e358c24066ff08ef7.diff"

commit baec52c8af1da0b23a38978e358c24066ff08ef7
Author: Philipp Reisner <philipp.reisner@linbit.com>
Date:   Fri Aug 31 21:24:39 2007 +0000

    r3043: When you let DRBD connect to an listening TCP port and close
    that, then allowing it to connect a second time you trigger
    an workaround from the DRBD-0.7 days. It is printed to the
    syslog as "My msock connect got accepted onto peer's sock!".
    The the receiver sleeps for connect_int/2.
    
    When you droped the network config during this time with
    "drbdadm disconnect", you hit an OOPS.
    
    The root of this bug was the the
    
    if(drbd_request_state(mdev,NS(conn,WFConnection)) < SS_Success ) ...
    
    statement in drbd_connect() elevated the connection state from
    StandAlone to WFConnection. Later we dereference mdev->net_conf
    and OOPS...
    
    I fixed this by allowing that state change only when the connection
    state before was >= Unconnected (I.e. we had a network config).

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 571cec0..b8d4751 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -595,6 +595,9 @@ STATIC int is_valid_state_transition(drbd_dev* mdev,drbd_state_t ns,drbd_state_t
 	if( ns.disk > Attaching && os.disk == Diskless)
 		rv=SS_IsDiskLess;
 
+	if ( ns.conn == WFConnection && os.conn < Unconnected )
+		rv=SS_NoNetConfig;
+
 	return rv;
 }
 
diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index dfa5b22..86ff8b4 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -706,16 +706,18 @@ STATIC Drbd_Packet_Cmd drbd_recv_fp(drbd_dev *mdev,struct socket *sock)
  *   0 oops, did not work out, please try again
  *  -1 peer talks different language,
  *     no point in trying again, please go standalone.
+ *  -2 We do not have a network config...
  */
 int drbd_connect(drbd_dev *mdev)
 {
 	struct socket *s, *sock,*msock;
 	int try,h;
 
-	D_ASSERT(mdev->state.conn >= Unconnected);
 	D_ASSERT(!mdev->data.socket);
 
-	if(drbd_request_state(mdev,NS(conn,WFConnection)) < SS_Success ) return 0;
+	if (_drbd_request_state(mdev,NS(conn,WFConnection),0) < SS_Success )
+		return -2;
+
 	clear_bit(DISCARD_CONCURRENT, &mdev->flags);
 
 	sock  = NULL;
@@ -2688,6 +2690,7 @@ STATIC void drbd_disconnect(drbd_dev *mdev)
 	int rv=SS_UnknownError;
 
 	D_ASSERT(mdev->state.conn < Connected);
+	if (mdev->state.conn == StandAlone) return;
 	/* FIXME verify that:
 	 * the state change magic prevents us from becoming >= Connected again
 	 * while we are still cleaning up.
@@ -3102,7 +3105,7 @@ int drbdd_init(struct Drbd_thread *thi)
 			drbd_disconnect(mdev);
 			schedule_timeout(HZ);
 		}
-		if( h < 0 ) {
+		if( h == -1 ) {
 			WARN("Discarding network configuration.\n");
 			drbd_force_state(mdev,NS(conn,Disconnecting));
 		}
diff --git a/drbd/drbd_strings.c b/drbd/drbd_strings.c
index 6afbc69..30a6c80 100644
--- a/drbd/drbd_strings.c
+++ b/drbd/drbd_strings.c
@@ -80,7 +80,8 @@ static const char *drbd_state_sw_errors[] = {
 	[-SS_CW_FailedByPeer] = "State changed was refused by peer node",
 	[-SS_IsDiskLess] = 
 		"Device is diskless, the requesed operation requires a disk",
-	[-SS_DeviceInUse] = "Device is held open by someone"
+	[-SS_DeviceInUse] = "Device is held open by someone",
+	[-SS_NoNetConfig] = "Have no net/connection configuration"
 };
 
 const char* conns_to_name(drbd_conns_t s) {
@@ -100,7 +101,7 @@ const char* disks_to_name(drbd_disks_t s) {
 }
 
 const char* set_st_err_name(set_st_err_t err) {
-	return err < SS_DeviceInUse ? "TOO_SMALL" :
+	return err < SS_NoNetConfig ? "TOO_SMALL" :
 	       err > SS_TwoPrimaries ? "TOO_LARGE"
 		        : drbd_state_sw_errors[-err];
 }
diff --git a/drbd/linux/drbd.h b/drbd/linux/drbd.h
index b46e754..6d5259f 100644
--- a/drbd/linux/drbd.h
+++ b/drbd/linux/drbd.h
@@ -207,7 +207,8 @@ typedef enum {
 	SS_AlreadyStandAlone=-9,
 	SS_CW_FailedByPeer=-10,
 	SS_IsDiskLess=-11,
-	SS_DeviceInUse=-12
+	SS_DeviceInUse=-12,
+	SS_NoNetConfig=-13
 } set_st_err_t;
 
 /* from drbd_strings.c */

--Boundary-00=_eiWTHK6G9s4lx8G--
