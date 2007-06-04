Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Resync stalled at 100% due to race condition
Date: Mon, 4 Jun 2007 11:08:59 +0200
References: <BD7042533C2F8943A6A4257A9E31C454F47908@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47908@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ra9YGCJdwKunzLd"
Message-Id: <200706041108.59791.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_ra9YGCJdwKunzLd
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 24 May 2007 14:41:53 Montrose, Ernest wrote:
> Hi all,
> We are seeing a problem where a resync hangs on the SyncSource at the
> end.  The SyncTarget finished OK and shows Connected. The signature on
> the SyncSource is:
>
[...]

I think you are right in saying that receive_state() is wrong, but
I have an other interpretation of the logs.

> What I think is happening is that there is a race condition where
> drbd_resync_finished() races receive_state() in this manner:
> 1)  The resync finished on drbd0 and we enter drbd_resync_finished().
> But before it can set the stated to Connected, drbd15 which is a higher
> priority device starts syncing. This puts drbd0 in PausedSyncS from
> SyncSource.

Right.

> 2) Drbd_resync_finished() for drbd0 now tries to go to Connected from
> PausedSyncS.  The logs below prints this transition but the transition
> was not actually commited since we print before we actually assign the
> new values.

No, the log line "conn (PausedSyncS -> Connected)" is done by
_drbd_set_state() (with the PSC macros) which runs under the req_lock, 
and there happens the assignment "mdev->state.i = ns.i;". 
The log is okay.

I think we have a race betwen receive_state() assigning the 
connection state to nconn=PausedSyncS, then the resync finishes
before we reach the call to spin_lock() (mdev->state.conn = Connected).
Now when receive_state() finally continues, it assigns (the now
obsolete value of) nconn to mdev->state.conn again by calling
_drbd_set_state().

> I include a patch that may at least help illustrate the issue if not fix
> it as I am not sure the req_lock can be held this early without causing
> a deadlock or other perfomance issues.
>

I considered the approach of making drbd_sync_handshake() to run
under the req_lock and to have a simple retry mechanism in receive_state().

Since 8.0.x is not the stable branch I decided to go with that small
patch. (I did not do any testing of this, since I guess it is rather
hard to hit this exact timing...)

Ernest, thanks for pointing this out!
As soon as you agree, I will commit this patch...

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :

--Boundary-00=_ra9YGCJdwKunzLd
Content-Type: text/x-diff; charset="iso-8859-15"; name="fix_rsync_hangs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix_rsync_hangs.diff"

Index: drbd/drbd_receiver.c
===================================================================
--- drbd/drbd_receiver.c	(revision 2903)
+++ drbd/drbd_receiver.c	(working copy)
@@ -2390,7 +2390,7 @@
 STATIC int receive_state(drbd_dev *mdev, Drbd_Header *h)
 {
 	Drbd_State_Packet *p = (Drbd_State_Packet*)h;
-	drbd_conns_t nconn;
+	drbd_conns_t nconn,oconn;
 	drbd_state_t os,ns,peer_state;
 	int rv;
 
@@ -2398,12 +2398,16 @@
 	if (drbd_recv(mdev, h->payload, h->length) != h->length)
 		return FALSE;
 
-	nconn = mdev->state.conn;
+	peer_state.i = be32_to_cpu(p->state);
+
+	spin_lock_irq(&mdev->req_lock);
+ retry:
+	oconn = nconn = mdev->state.conn;
+	spin_unlock_irq(&mdev->req_lock);
+
 	if (nconn == WFReportParams ) nconn = Connected;
 
-	peer_state.i = be32_to_cpu(p->state);
-
-	if (mdev->p_uuid && mdev->state.conn <= Connected &&
+	if (mdev->p_uuid && oconn <= Connected &&
 	    inc_local_if_state(mdev,Negotiating) &&
 	    peer_state.disk >= Negotiating) {
 		nconn=drbd_sync_handshake(mdev,peer_state.role,peer_state.disk);
@@ -2412,19 +2416,8 @@
 		if(nconn == conn_mask) return FALSE;
 	}
 
-	if (mdev->state.conn > WFReportParams ) {
-		if( nconn > Connected && peer_state.conn <= Connected) {
-			// we want resync, peer has not yet decided to sync...
-			drbd_send_uuids(mdev);
-			drbd_send_state(mdev);
-		}
-		else if (nconn == Connected && peer_state.disk == Negotiating) {
-			// peer is waiting for us to respond...
-			drbd_send_state(mdev);
-		}
-	}
-
 	spin_lock_irq(&mdev->req_lock);
+	if( mdev->state.conn != oconn ) goto retry;
 	os = mdev->state;
 	ns.i = mdev->state.i;
 	ns.conn = nconn;
@@ -2446,6 +2439,18 @@
 		return FALSE;
 	}
 
+	if (oconn > WFReportParams ) {
+		if( nconn > Connected && peer_state.conn <= Connected) {
+			// we want resync, peer has not yet decided to sync...
+			drbd_send_uuids(mdev);
+			drbd_send_state(mdev);
+		}
+		else if (nconn == Connected && peer_state.disk == Negotiating) {
+			// peer is waiting for us to respond...
+			drbd_send_state(mdev);
+		}
+	}
+
 	mdev->net_conf->want_lose = 0;
 
 	/* FIXME assertion for (gencounts do not diverge) */

--Boundary-00=_ra9YGCJdwKunzLd--
