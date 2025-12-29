Return-Path: <zhengbing.huang@easystack.cn>
Received: from mail-m128221.netease.com (mail-m128221.netease.com
	[103.209.128.221])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 54F0B1608F2
	for <drbd-dev@lists.linbit.com>; Mon, 29 Dec 2025 09:46:10 +0100 (CET)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linbit.com
Subject: [PATCH] drbd: Make sure update P_PEERS_IN_SYNC before resync_finished
Date: Mon, 29 Dec 2025 16:30:56 +0800
Message-ID: <20251229083056.2090623-1-zhengbing.huang@easystack.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In the drbd_resync_check_finished function, one of the conditions
for determine the end of resync is that the resync_requests list is empty,
but the update P_PEERS_IN_SYNC occurs after peer_req is removed
from the resync_requests list. So call the drbd_resync_finised function
might occur before update P_PEERS_IN_SYNC, and then read the value of
last_peers_in_sync_end is incorrect.

So update P_PEERS_IN_SYNC before peer_req is removed from the resync_request list.
And use last_in_sync_end to determine the position of the last sync.

Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
---
 drbd/drbd_receiver.c | 8 ++++----
 drbd/drbd_sender.c   | 8 +++-----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 08fd20b14..5e155b6b1 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -2437,16 +2437,16 @@ static void drbd_check_peers_in_sync_progress(struct drbd_peer_device *peer_devi
 		if (!test_bit(INTERVAL_COMPLETED, &peer_req->i.flags))
 			break;
 
+		drbd_peers_in_sync_progress(peer_device, peer_req->i.sector,
+			peer_req->i.sector + (peer_req->i.size >> SECTOR_SHIFT));
+
 		drbd_list_del_resync_request(peer_req);
 		list_add_tail(&peer_req->recv_order, &completed);
 	}
 	spin_unlock_irq(&connection->peer_reqs_lock);
 
-	list_for_each_entry_safe(peer_req, tmp, &completed, recv_order) {
-		drbd_peers_in_sync_progress(peer_device, peer_req->i.sector,
-			peer_req->i.sector + (peer_req->i.size >> SECTOR_SHIFT));
+	list_for_each_entry_safe(peer_req, tmp, &completed, recv_order)
 		drbd_free_peer_req(peer_req);
-	}
 }
 
 static void drbd_resync_request_complete(struct drbd_peer_request *peer_req)
diff --git a/drbd/drbd_sender.c b/drbd/drbd_sender.c
index cf42312db..282b5d205 100644
--- a/drbd/drbd_sender.c
+++ b/drbd/drbd_sender.c
@@ -1863,7 +1863,6 @@ void drbd_resync_finished(struct drbd_peer_device *peer_device,
 	int verify_done = 0;
 	bool aborted = false;
 	int bm_block_shift = device->last_bm_block_shift;
-	sector_t final_peers_in_sync_end;
 
 	if (repl_state[NOW] == L_SYNC_SOURCE || repl_state[NOW] == L_PAUSED_SYNC_S) {
 		/* Make sure all queued w_update_peers() executed. */
@@ -2045,10 +2044,9 @@ out_unlock:
 		after_reconciliation_resync(connection);
 
 	/* Potentially send final P_PEERS_IN_SYNC. */
-	final_peers_in_sync_end = min(get_capacity(device->vdisk),
-			(peer_device->last_peers_in_sync_end | PEERS_IN_SYNC_STEP_SECT_MASK) + 1);
-	drbd_queue_update_peers(peer_device,
-			peer_device->last_peers_in_sync_end, final_peers_in_sync_end);
+	if (peer_device->last_in_sync_end > peer_device->last_peers_in_sync_end)
+		drbd_queue_update_peers(peer_device,
+			peer_device->last_peers_in_sync_end, peer_device->last_in_sync_end);
 
 out:
 	/* reset start sector, if we reached end of device */
-- 
2.43.0

