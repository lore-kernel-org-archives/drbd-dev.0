Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 673EA10556BC
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 09:49:22 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed, 10 Jun 2015 15:48:28 +0800
Message-Id: <1433922509-10280-10-git-send-email-nwang@suse.com>
In-Reply-To: <1433922509-10280-1-git-send-email-nwang@suse.com>
References: <1433922509-10280-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH 09/10] Notify peer to change status after both
	side finished zero out.
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

Update peer node state after both finished.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

---
 drbd/drbd_int.h      |  1 +
 drbd/drbd_main.c     |  5 +++++
 drbd/drbd_receiver.c | 13 +++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index e956eb4..0a92f7d 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -1210,6 +1210,7 @@ extern int drbd_send_protocol(struct drbd_connection *connection);
 extern int drbd_send_uuids(struct drbd_peer_device *);
 extern int drbd_send_uuids_skip_initial_sync(struct drbd_peer_device *);
 extern int drbd_send_zero_out_start(struct drbd_peer_device *);
+extern int drbd_send_zero_out_finish(struct drbd_peer_device *);
 extern int drbd_send_zero_out_ok(struct drbd_peer_device *);
 extern int drbd_send_zero_out_fail(struct drbd_peer_device *);
 extern void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *);
diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 5892ff3..f9f1a2e 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -913,6 +913,11 @@ int drbd_send_zero_out_start(struct drbd_peer_device *peer_device)
 	return _drbd_send_uuids(peer_device, 16);
 }
 
+int drbd_send_zero_out_finish(struct drbd_peer_device *peer_device)
+{
+	return _drbd_send_uuids(peer_device, 32);
+}
+
 /**
  * _drbd_send_zero_out_state() - Sends the drbd state to the peer
  * @peer_device:	DRBD peer device.
diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index cbb66e6..240a557 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -4344,6 +4344,10 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 			peer_device->connection->agreed_pro_version >= 90 &&
 			device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED &&
 			(p_uuid[UI_FLAGS] & 16);
+		int zero_out_finish =
+			device->state.conn == C_CONNECTED &&
+			peer_device->connection->agreed_pro_version >= 90 &&
+			(p_uuid[UI_FLAGS] & 32);
 		if (skip_initial_sync) {
 			drbd_info(device, "Accepted new current UUID, preparing to skip initial sync\n");
 			drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
@@ -4373,6 +4377,14 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 			}
 		}
 
+		if (zero_out_finish) {
+			drbd_info(device, "Both side finished zero out devices.\n");
+			spin_lock_irq(&device->resource->req_lock);
+			_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE, pdsk, D_UP_TO_DATE),
+					CS_VERBOSE, NULL);
+			spin_unlock_irq(&device->resource->req_lock);
+		}
+
 		put_ldev(device);
 	} else if (device->state.disk < D_INCONSISTENT &&
 		   device->state.role == R_PRIMARY) {
@@ -4451,6 +4463,7 @@ static int receive_zero_out_state(struct drbd_connection *connection, struct pac
 			_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE,
 				pdsk, D_UP_TO_DATE), CS_VERBOSE, NULL);
 			spin_unlock_irq(&device->resource->req_lock);
+			drbd_send_zero_out_finish(peer_device);
 		} else {
 			/* waiting for local device finished */
 			set_bit(ZERO_DONE, &device->flags);
-- 
1.8.4.5

