Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 923EC105570E
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jul 2015 10:39:55 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Mon, 13 Jul 2015 16:39:03 +0800
Message-Id: <1436776744-3135-10-git-send-email-nwang@suse.com>
In-Reply-To: <1436776744-3135-1-git-send-email-nwang@suse.com>
References: <1436776744-3135-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [Patch v2 09/10] drbd: Handle zero out command from peer
	node
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

Recevie P_UUID flag 16 for starting zero out device,
P_UUID flag 32 after both side finished zeroing,
Change state to uptodate.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 drbd/drbd_receiver.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 6eae84f..4d6d99a 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -4317,6 +4317,15 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 			peer_device->connection->agreed_pro_version >= 90 &&
 			device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED &&
 			(p_uuid[UI_FLAGS] & 8);
+		int zero_out_devices =
+			device->state.conn == C_CONNECTED &&
+			peer_device->connection->agreed_pro_version >= 90 &&
+			device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED &&
+			(p_uuid[UI_FLAGS] & 16);
+		int zero_out_finish =
+			device->state.conn == C_CONNECTED &&
+			peer_device->connection->agreed_pro_version >= 90 &&
+			(p_uuid[UI_FLAGS] & 32);
 		if (skip_initial_sync) {
 			drbd_info(device, "Accepted new current UUID, preparing to skip initial sync\n");
 			drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
@@ -4324,11 +4333,35 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 					BM_LOCKED_TEST_ALLOWED);
 			_drbd_uuid_set(device, UI_CURRENT, p_uuid[UI_CURRENT]);
 			_drbd_uuid_set(device, UI_BITMAP, 0);
+			spin_lock_irq(&device->resource->req_lock);
 			_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE, pdsk, D_UP_TO_DATE),
 					CS_VERBOSE, NULL);
+			spin_unlock_irq(&device->resource->req_lock);
 			drbd_md_sync(device);
 			updated_uuids = 1;
 		}
+
+		if (zero_out_devices) {
+			drbd_info(device, "Accepted to zero out devices, will take a long time\n");
+			drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
+					"clear_n_write from receive_uuids",
+					BM_LOCKED_TEST_ALLOWED);
+			_drbd_uuid_set(device, UI_CURRENT, p_uuid[UI_CURRENT]);
+			_drbd_uuid_set(device, UI_BITMAP, 0);
+			drbd_print_uuids(device, "cleared bitmap UUID for zeroing device");
+
+			drbd_device_post_work(device, S_ZERO_START);
+			updated_uuids = 1;
+		}
+
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
-- 
1.8.4.5

