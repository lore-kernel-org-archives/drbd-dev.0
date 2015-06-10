Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D79D010556B0
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 09:49:21 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed, 10 Jun 2015 15:48:27 +0800
Message-Id: <1433922509-10280-9-git-send-email-nwang@suse.com>
In-Reply-To: <1433922509-10280-1-git-send-email-nwang@suse.com>
References: <1433922509-10280-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH 08/10] Receive UI_FLAGS 16 of P_UUIDS to start
	zero out devices.
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

Receive P_UUIDS protocol to start zero out device.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

---
 drbd/drbd_receiver.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 41c958a..cbb66e6 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -4304,6 +4304,7 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 	struct p_uuids *p = pi->data;
 	u64 *p_uuid;
 	int i, updated_uuids = 0;
+	int zero_out_err = 0;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
 	if (!peer_device)
@@ -4338,6 +4339,11 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 			peer_device->connection->agreed_pro_version >= 90 &&
 			device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED &&
 			(p_uuid[UI_FLAGS] & 8);
+		int zero_out_devices =
+			device->state.conn == C_CONNECTED &&
+			peer_device->connection->agreed_pro_version >= 90 &&
+			device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED &&
+			(p_uuid[UI_FLAGS] & 16);
 		if (skip_initial_sync) {
 			drbd_info(device, "Accepted new current UUID, preparing to skip initial sync\n");
 			drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
@@ -4350,6 +4356,23 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 			drbd_md_sync(device);
 			updated_uuids = 1;
 		}
+
+		if (zero_out_devices) {
+			drbd_info(device, "Accepted to zero out devices, will take a long time\n");
+			_drbd_uuid_set(device, UI_CURRENT, p_uuid[UI_CURRENT]);
+			_drbd_uuid_set(device, UI_BITMAP, 0);
+			drbd_print_uuids(device, "cleared bitmap UUID for zeroing device");
+			zero_out_err = zero_out_local_device(device);
+			if (zero_out_err) {
+				drbd_err(device, "Failed to zero out local device\n");
+				drbd_send_zero_out_fail(peer_device);
+				drbd_chk_io_error(device, 1, DRBD_WRITE_ERROR);
+			} else {
+				drbd_info(device, "Finish zero out device\n");
+				drbd_send_zero_out_ok(peer_device);
+			}
+		}
+
 		put_ldev(device);
 	} else if (device->state.disk < D_INCONSISTENT &&
 		   device->state.role == R_PRIMARY) {
-- 
1.8.4.5

