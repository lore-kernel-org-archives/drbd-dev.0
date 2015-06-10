Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2690710518BD
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 09:49:19 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed, 10 Jun 2015 15:48:24 +0800
Message-Id: <1433922509-10280-6-git-send-email-nwang@suse.com>
In-Reply-To: <1433922509-10280-1-git-send-email-nwang@suse.com>
References: <1433922509-10280-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH 05/10] Start zero out device when drbdadm
	new-current-uuid --zap-device
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

Two new device flags to represent peer zero out status.
Start zero out local device. 

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

---
 drbd/drbd_int.h |  4 ++++
 drbd/drbd_nl.c  | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index d43adf2..b49095e 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -623,6 +623,10 @@ enum {
 	RS_START,		/* tell worker to start resync/OV */
 	RS_PROGRESS,		/* tell worker that resync made significant progress */
 	RS_DONE,		/* tell worker that resync is done */
+
+	/* used for zero out device */
+	ZERO_DONE,		/* succeed on zero out a device */
+	ZERO_FAIL,		/* fail to zero out a device */
 };
 
 struct drbd_bitmap; /* opaque for drbd_device */
diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index 1ef4551..ad499a6 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -4001,6 +4001,7 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 	enum drbd_ret_code retcode;
 	int skip_initial_sync = 0;
 	int zero_out_devices = 0;
+	int zero_out_err = 0;
 	int err;
 	struct new_c_uuid_parms args;
 
@@ -4051,7 +4052,7 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 	drbd_uuid_set(device, UI_BITMAP, 0); /* Rotate UI_BITMAP to History 1, etc... */
 	drbd_uuid_new_current(device); /* New current, previous to UI_BITMAP */
 
-	if (args.clear_bm) {
+	if (args.clear_bm || args.zap_devices) {
 		err = drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
 			"clear_n_write from new_c_uuid", BM_LOCKED_MASK);
 		if (err) {
@@ -4067,6 +4068,36 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 					CS_VERBOSE, NULL);
 			spin_unlock_irq(&device->resource->req_lock);
 		}
+		if (zero_out_devices) {
+			drbd_send_zero_out_start(first_peer_device(device));
+			_drbd_uuid_set(device, UI_BITMAP, 0);
+			drbd_print_uuids(device, "cleared bitmap UUID for zeroing device");
+
+			/* CLear bit flag of zero out */
+			clear_bit(ZERO_DONE, &device->flags);
+			clear_bit(ZERO_FAIL, &device->flags);
+			zero_out_err = zero_out_local_device(device);
+
+			if (zero_out_err) {
+				drbd_err(device, "Failed to zero out local device\n");
+				set_bit(ZERO_FAIL, &device->flags);
+				drbd_chk_io_error(device, 1, DRBD_WRITE_ERROR);
+			} else {
+				drbd_info(device, "Finish zero out device\n");
+
+				if (test_and_clear_bit(ZERO_DONE, &device->flags)) {
+					spin_lock_irq(&device->resource->req_lock);
+					_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE,
+						pdsk, D_UP_TO_DATE), CS_VERBOSE, NULL);
+					spin_unlock_irq(&device->resource->req_lock);
+				} else if (test_and_clear_bit(ZERO_FAIL, &device->flags)) {
+					drbd_info(device, "Peer device has already failed on zero out\n");
+				} else {
+					/* waiting for peer device finished */
+					set_bit(ZERO_DONE, &device->flags);
+				}
+			}
+		}
 	}
 
 	drbd_md_sync(device);
-- 
1.8.4.5

