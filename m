Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A1A361056461
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:30 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:52 +0200
Message-Id: <1461586077-11581-26-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 25/30] drbd: bump current uuid when resuming IO
	with diskless peer
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

Scenario, starting with normal operation
 Connected Primary/Secondary UpToDate/UpToDate
 NetworkFailure Primary/Unknown UpToDate/DUnknown (frozen)
 ... more failures happen, secondary loses it's disk,
 but eventually is able to re-establish the replication link ...
 Connected Primary/Secondary UpToDate/Diskless (resumed; needs to bump uuid!)

We used to just resume/resent suspended requests,
without bumping the UUID.

Which will lead to problems later, when we want to re-attach the disk on
the peer, without first disconnecting, or if we experience additional
failures, because we now have diverging data without being able to
recognize it.

Make sure we also bump the current data generation UUID,
if we notice "peer disk unknown" -> "peer disk known bad".

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_state.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 7562c5c..a1b5e6c9 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1637,6 +1637,26 @@ static void broadcast_state_change(struct drbd_state_change *state_change)
 #undef REMEMBER_STATE_CHANGE
 }
 
+/* takes old and new peer disk state */
+static bool lost_contact_to_peer_data(enum drbd_disk_state os, enum drbd_disk_state ns)
+{
+	if ((os >= D_INCONSISTENT && os != D_UNKNOWN && os != D_OUTDATED)
+	&&  (ns < D_INCONSISTENT || ns == D_UNKNOWN || ns == D_OUTDATED))
+		return true;
+
+	/* Scenario, starting with normal operation
+	 * Connected Primary/Secondary UpToDate/UpToDate
+	 * NetworkFailure Primary/Unknown UpToDate/DUnknown (frozen)
+	 * ...
+	 * Connected Primary/Secondary UpToDate/Diskless (resumed; needs to bump uuid!)
+	 */
+	if (os == D_UNKNOWN
+	&&  (ns == D_DISKLESS || ns == D_FAILED || ns == D_OUTDATED))
+		return true;
+
+	return false;
+}
+
 /**
  * after_state_ch() - Perform after state change actions that may sleep
  * @device:	DRBD device.
@@ -1708,6 +1728,13 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 			idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
 				clear_bit(NEW_CUR_UUID, &peer_device->device->flags);
 			rcu_read_unlock();
+
+			/* We should actively create a new uuid, _before_
+			 * we resume/resent, if the peer is diskless
+			 * (recovery from a multiple error scenario).
+			 * Currently, this happens with a slight delay
+			 * below when checking lost_contact_to_peer_data() ...
+			 */
 			_tl_restart(connection, RESEND);
 			_conn_request_state(connection,
 					    (union drbd_state) { { .susp_fen = 1 } },
@@ -1751,12 +1778,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 				BM_LOCKED_TEST_ALLOWED);
 
 	/* Lost contact to peer's copy of the data */
-	if ((os.pdsk >= D_INCONSISTENT &&
-	     os.pdsk != D_UNKNOWN &&
-	     os.pdsk != D_OUTDATED)
-	&&  (ns.pdsk < D_INCONSISTENT ||
-	     ns.pdsk == D_UNKNOWN ||
-	     ns.pdsk == D_OUTDATED)) {
+	if (lost_contact_to_peer_data(os.pdsk, ns.pdsk)) {
 		if (get_ldev(device)) {
 			if ((ns.role == R_PRIMARY || ns.peer == R_PRIMARY) &&
 			    device->ldev->md.uuid[UI_BITMAP] == 0 && ns.disk >= D_UP_TO_DATE) {
-- 
1.9.1

