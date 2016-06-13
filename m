Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BF4D8105646D
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 00:26:44 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue, 14 Jun 2016 00:26:24 +0200
Message-Id: <1465856799-2151-16-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 15/30] drbd: finish resync on sync source only by
	notification from sync target
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

From: Lars Ellenberg <lars@linbit.com>

If the replication link breaks exactly during "resync finished" detection,
finishing too early on the sync source could again lead to UUIDs rotated
too fast, and potentially a spurious full resync on next handshake.

Always wait for explicit resync finished state change notification from
the sync target.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c | 16 ++++++++++++----
 drivers/block/drbd/drbd_int.h    | 19 ++++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 265b2b6..cafa9c4 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -770,10 +770,18 @@ static bool lazy_bitmap_update_due(struct drbd_device *device)
 
 static void maybe_schedule_on_disk_bitmap_update(struct drbd_device *device, bool rs_done)
 {
-	if (rs_done)
-		set_bit(RS_DONE, &device->flags);
-		/* and also set RS_PROGRESS below */
-	else if (!lazy_bitmap_update_due(device))
+	if (rs_done) {
+		struct drbd_connection *connection = first_peer_device(device)->connection;
+		if (connection->agreed_pro_version <= 95 ||
+		    is_sync_target_state(device->state.conn))
+			set_bit(RS_DONE, &device->flags);
+			/* and also set RS_PROGRESS below */
+
+		/* Else: rather wait for explicit notification via receive_state,
+		 * to avoid uuids-rotated-too-fast causing full resync
+		 * in next handshake, in case the replication link breaks
+		 * at the most unfortunate time... */
+	} else if (!lazy_bitmap_update_due(device))
 		return;
 
 	drbd_device_post_work(device, RS_PROGRESS);
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 9c68ec5..c5dbc85 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -2102,13 +2102,22 @@ static inline void _sub_unacked(struct drbd_device *device, int n, const char *f
 	ERR_IF_CNT_IS_NEGATIVE(unacked_cnt, func, line);
 }
 
+static inline bool is_sync_target_state(enum drbd_conns connection_state)
+{
+	return	connection_state == C_SYNC_TARGET ||
+		connection_state == C_PAUSED_SYNC_T;
+}
+
+static inline bool is_sync_source_state(enum drbd_conns connection_state)
+{
+	return	connection_state == C_SYNC_SOURCE ||
+		connection_state == C_PAUSED_SYNC_S;
+}
+
 static inline bool is_sync_state(enum drbd_conns connection_state)
 {
-	return
-	   (connection_state == C_SYNC_SOURCE
-	||  connection_state == C_SYNC_TARGET
-	||  connection_state == C_PAUSED_SYNC_S
-	||  connection_state == C_PAUSED_SYNC_T);
+	return	is_sync_source_state(connection_state) ||
+		is_sync_target_state(connection_state);
 }
 
 /**
-- 
2.7.4

