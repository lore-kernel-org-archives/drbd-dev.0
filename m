Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 545861056460
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:30 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:51 +0200
Message-Id: <1461586077-11581-25-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 24/30] drbd: disallow promotion during resync
	handshake, avoid deadlock and hard reset
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

We already serialize connection state changes,
and other, non-connection state changes (role changes)
while we are establishing a connection.

But if we have an established connection,
then trigger a resync handshake (by primary --force or similar),
until now we just had to be "lucky".

Consider this sequence (e.g. deployment scenario):
create-md; up;
  -> Connected Secondary/Secondary Inconsistent/Inconsistent
then do a racy primary --force on both peers.

 block drbd0: drbd_sync_handshake:
 block drbd0: self 0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:25590 flags:0
 block drbd0: peer 0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:25590 flags:0
 block drbd0: peer( Unknown -> Secondary ) conn( WFReportParams -> Connected ) pdsk( DUnknown -> Inconsistent )
 block drbd0: peer( Secondary -> Primary ) pdsk( Inconsistent -> UpToDate )
  *** HERE things go wrong. ***
 block drbd0: role( Secondary -> Primary )
 block drbd0: drbd_sync_handshake:
 block drbd0: self 0000000000000005:0000000000000000:0000000000000000:0000000000000000 bits:25590 flags:0
 block drbd0: peer C90D2FC716D232AB:0000000000000004:0000000000000000:0000000000000000 bits:25590 flags:0
 block drbd0: Becoming sync target due to disk states.
 block drbd0: Writing the whole bitmap, full sync required after drbd_sync_handshake.
 block drbd0: Remote failed to finish a request within 6007ms > ko-count (2) * timeout (30 * 0.1s)
 drbd s0: peer( Primary -> Unknown ) conn( Connected -> Timeout ) pdsk( UpToDate -> DUnknown )

The problem here is that the local promotion happens before the sync handshake
triggered by the remote promotion was completed.  Some assumptions elsewhere
become wrong, and when the expected resync handshake is then received and
processed, we get stuck in a deadlock, which can only be recovered by reboot :-(

Fix: if we know the peer has good data,
and our own disk is present, but NOT good,
and there is no resync going on yet,
we expect a sync handshake to happen "soon".
So reject a racy promotion with SS_IN_TRANSIENT_STATE.

Result:
 ... as above ...
 block drbd0: peer( Secondary -> Primary ) pdsk( Inconsistent -> UpToDate )
  *** local promotion being postponed until ... ***
 block drbd0: drbd_sync_handshake:
 block drbd0: self 0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:25590 flags:0
 block drbd0: peer 77868BDA836E12A5:0000000000000004:0000000000000000:0000000000000000 bits:25590 flags:0
  ...
 block drbd0: conn( WFBitMapT -> WFSyncUUID )
 block drbd0: updated sync uuid 85D06D0E8887AD44:0000000000000000:0000000000000000:0000000000000000
 block drbd0: conn( WFSyncUUID -> SyncTarget )
  *** ... after the resync handshake ***
 block drbd0: role( Secondary -> Primary )

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_state.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 24422e8..7562c5c 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -906,6 +906,15 @@ is_valid_soft_transition(union drbd_state os, union drbd_state ns, struct drbd_c
 	      (ns.conn >= C_CONNECTED && os.conn == C_WF_REPORT_PARAMS)))
 		rv = SS_IN_TRANSIENT_STATE;
 
+	/* Do not promote during resync handshake triggered by "force primary".
+	 * This is a hack. It should really be rejected by the peer during the
+	 * cluster wide state change request. */
+	if (os.role != R_PRIMARY && ns.role == R_PRIMARY
+		&& ns.pdsk == D_UP_TO_DATE
+		&& ns.disk != D_UP_TO_DATE && ns.disk != D_DISKLESS
+		&& (ns.conn <= C_WF_SYNC_UUID || ns.conn != os.conn))
+			rv = SS_IN_TRANSIENT_STATE;
+
 	if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) && os.conn < C_CONNECTED)
 		rv = SS_NEED_CONNECTION;
 
-- 
1.9.1

