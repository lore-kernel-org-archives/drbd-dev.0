Return-Path: <rui.xu@easystack.cn>
Received: from mail-m2835.qiye.163.com (mail-m2835.qiye.163.com [103.74.28.35])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EA27642002A
	for <drbd-dev@lists.linbit.com>; Mon, 13 Sep 2021 04:27:13 +0200 (CEST)
From: Rui Xu <rui.xu@easystack.cn>
To: philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Date: Mon, 13 Sep 2021 10:27:08 +0800
Message-Id: <20210913022708.1195173-1-rui.xu@easystack.cn>
In-Reply-To: <20210910054011.1115655-1-rui.xu@easystack.cn>
References: <20210910054011.1115655-1-rui.xu@easystack.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: dongsheng.yang@easystack.cn
Subject: [Drbd-dev] [PATCH v2] drbd: fix a race condition in
	update_sync_bits() and receive_bitmap()
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

There is a race condition in update_sync_bits() and receive_bitmap(),
please consider this scenario:

Primary: node-3, Secondary node-1, node-2

(1) network failure happend on node-1.
(2) node-1 network recovery.
(3) node-1 connect to node-2, and start resync (node-1 is SyncTarget,
node-2 is SyncSource)
(4) before resync in (3) finished, node-1 connect to node-3 and start
resync.(node-1 is PauseSyncTarget, node-3 is PauseSyncSource)

When node-1(SyncTarget) is resync with node-2(SyncSource), node-1 may
set bitmap for node-3 in receive_resync_read()->drbd_set_all_out_of_sync(),
and clear the bitmap for node-3 when got P_PEERS_IN_SYNC from node-2.

Then there is a possibility scenario as below:

thread:ack_receiver (node-1)           thread:receiver (node-1)
update_sync_bits()                     receive_bitmap()

set the rs_is_done to 1
				       set the bitmap for node-3
				       set the repl_state to PauseSyncTarget
set RS_DONE flag

it will lead the reysnc of node-1 and node-3 to finish in an unexpected way, so
we need to determine the is_sync_target_state before getting the bitmap total
weight in update_sync_bits.
---
changelog:
	-v1: fix typo in commit message
 drbd/drbd_actlog.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drbd/drbd_actlog.c b/drbd/drbd_actlog.c
index 841e5149..3d2fd399 100644
--- a/drbd/drbd_actlog.c
+++ b/drbd/drbd_actlog.c
@@ -1044,11 +1044,11 @@ static bool lazy_bitmap_update_due(struct drbd_peer_device *peer_device)
 }
 
 static void maybe_schedule_on_disk_bitmap_update(struct drbd_peer_device *peer_device,
-						 bool rs_done)
+						 bool rs_done, bool is_sync_target)
 {
 	if (rs_done) {
 		if (peer_device->connection->agreed_pro_version <= 95 ||
-		    is_sync_target_state(peer_device, NOW))
+		    is_sync_target)
 			set_bit(RS_DONE, &peer_device->flags);
 
 		/* If sync source: rather wait for explicit notification via
@@ -1105,11 +1105,12 @@ static int update_sync_bits(struct drbd_peer_device *peer_device,
 	}
 	if (count) {
 		if (mode == SET_IN_SYNC) {
+			bool is_sync_target = is_sync_target_state(peer_device, NOW);
 			unsigned long still_to_go = drbd_bm_total_weight(peer_device);
 			bool rs_is_done = (still_to_go <= peer_device->rs_failed);
 			drbd_advance_rs_marks(peer_device, still_to_go);
 			if (cleared || rs_is_done)
-				maybe_schedule_on_disk_bitmap_update(peer_device, rs_is_done);
+				maybe_schedule_on_disk_bitmap_update(peer_device, rs_is_done, is_sync_target);
 		} else if (mode == RECORD_RS_FAILED) {
 			peer_device->rs_failed += count;
 		} else /* if (mode == SET_OUT_OF_SYNC) */ {
-- 
2.25.1

