Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 27D2E1011B9B
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 10:09:50 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed, 10 Jun 2015 15:48:29 +0800
Message-Id: <1433922509-10280-11-git-send-email-nwang@suse.com>
In-Reply-To: <1433922509-10280-1-git-send-email-nwang@suse.com>
References: <1433922509-10280-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH 10/10] Update flag when receive uuid.
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

Clear bitmap write and add lock when change state.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

---
 drbd/drbd_receiver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 240a557..944db4c 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -4355,17 +4355,23 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
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
 
 		if (zero_out_devices) {
 			drbd_info(device, "Accepted to zero out devices, will take a long time\n");
+			drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
+					"clear_n_write from receive_uuids",
+					BM_LOCKED_TEST_ALLOWED);
 			_drbd_uuid_set(device, UI_CURRENT, p_uuid[UI_CURRENT]);
 			_drbd_uuid_set(device, UI_BITMAP, 0);
 			drbd_print_uuids(device, "cleared bitmap UUID for zeroing device");
+
 			zero_out_err = zero_out_local_device(device);
 			if (zero_out_err) {
 				drbd_err(device, "Failed to zero out local device\n");
@@ -4375,6 +4381,8 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 				drbd_info(device, "Finish zero out device\n");
 				drbd_send_zero_out_ok(peer_device);
 			}
+			drbd_md_sync(device);
+			updated_uuids = 1;
 		}
 
 		if (zero_out_finish) {
-- 
1.8.4.5

