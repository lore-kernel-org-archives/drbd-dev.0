Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AA07E10518AB
	for <drbd-dev@lists.linbit.com>; Thu,  6 Aug 2015 12:04:49 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Thu,  6 Aug 2015 18:04:22 +0800
Message-Id: <1438855462-3757-2-git-send-email-nwang@suse.com>
In-Reply-To: <1438855462-3757-1-git-send-email-nwang@suse.com>
References: <1950665.2mvfrclfR5@fat-tyre>
	<1438855462-3757-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: Support zeroout device instead of initial
	full sync
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

Patch set for zeroing out device on both side
instead of initial full sync. Useful for high
latency network environment.

Implement --zeroout-devices and --discard-devices
for new-current-uuid

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 drbd/drbd_int.h        |  15 +++++++
 drbd/drbd_main.c       |  60 +++++++++++++++++++++++++++-
 drbd/drbd_nl.c         |  41 +++++++++++++++++--
 drbd/drbd_protocol.h   |   2 +
 drbd/drbd_receiver.c   |  86 +++++++++++++++++++++++++++++++++++++++-
 drbd/drbd_worker.c     | 105 +++++++++++++++++++++++++++++++++++++++++++++++++
 drbd/linux/drbd_genl.h |   2 +
 7 files changed, 305 insertions(+), 6 deletions(-)

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index d1e2bc0..555b24c 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -621,6 +621,13 @@ enum {
 	RS_START,		/* tell worker to start resync/OV */
 	RS_PROGRESS,		/* tell worker that resync made significant progress */
 	RS_DONE,		/* tell worker that resync is done */
+	P_ZERO_START,		/* tell worker to zero out device */
+	S_ZERO_START,		/* tell worker to zero out device as requested*/
+
+	/* used for zero out/discard device */
+	DISCARD_DISK,	/* flag to discard device */
+	ZERO_DONE,		/* succeed on zero out a device */
+	ZERO_FAIL,		/* fail to zero out a device */
 };
 
 struct drbd_bitmap; /* opaque for drbd_device */
@@ -1204,6 +1211,11 @@ extern int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_pa
 extern int drbd_send_protocol(struct drbd_connection *connection);
 extern int drbd_send_uuids(struct drbd_peer_device *);
 extern int drbd_send_uuids_skip_initial_sync(struct drbd_peer_device *);
+extern int drbd_send_zeroout_start(struct drbd_peer_device *);
+extern int drbd_send_discard_start(struct drbd_peer_device *);
+extern int drbd_send_zeroout_finish(struct drbd_peer_device *);
+extern int drbd_send_zeroout_ok(struct drbd_peer_device *);
+extern int drbd_send_zeroout_fail(struct drbd_peer_device *);
 extern void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *);
 extern int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enum dds_flags flags);
 extern int drbd_send_state(struct drbd_peer_device *, union drbd_state);
@@ -1661,6 +1673,9 @@ extern void drbd_send_acks_wf(struct work_struct *ws);
 extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
 extern bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
 		bool throttle_if_app_is_waiting);
+extern int zeroout_local_device(struct drbd_device *device, bool discard);
+extern void require_zeroout_local_device(struct drbd_device *device);
+extern void receive_zeroout_local_device(struct drbd_device *device);
 extern int drbd_submit_peer_request(struct drbd_device *,
 				    struct drbd_peer_request *, const unsigned,
 				    const int);
diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 31bf43f..badc719 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -908,6 +908,62 @@ int drbd_send_uuids_skip_initial_sync(struct drbd_peer_device *peer_device)
 	return _drbd_send_uuids(peer_device, 8);
 }
 
+
+/**
+ * drbd_send_zeroout_start() - Notify peer node to zeroout device
+ * @peer_device:	DRBD peer device.
+ */
+int drbd_send_zeroout_start(struct drbd_peer_device *peer_device)
+{
+	return _drbd_send_uuids(peer_device, 16);
+}
+
+/**
+ * drbd_send_discard_start() - Notify peer node to discard device
+ * @peer_device:	DRBD peer device.
+ */
+int drbd_send_discard_start(struct drbd_peer_device *peer_device)
+{
+	return _drbd_send_uuids(peer_device, 32);
+}
+
+/**
+ * drbd_send_zeroout_finish() - Notify both node finished zeroing out
+ * @peer_device:	DRBD peer device.
+ */
+int drbd_send_zeroout_finish(struct drbd_peer_device *peer_device)
+{
+	return _drbd_send_uuids(peer_device, 64);
+}
+
+/**
+ * _drbd_send_zeroout_state() - Sends the drbd state to the peer
+ * @peer_device:	DRBD peer device.
+ * @state:	Device zero out status.
+ */
+static int _drbd_send_zeroout_state(struct drbd_peer_device *peer_device, unsigned int status)
+{
+	struct drbd_socket *sock;
+	struct p_state *p;
+
+	sock = &peer_device->connection->data;
+	p = drbd_prepare_command(peer_device, sock);
+	if (!p)
+		return -EIO;
+	p->state = cpu_to_be32(status);
+	return drbd_send_command(peer_device, sock, P_ZERO_OUT, sizeof(*p), NULL, 0);
+}
+
+int drbd_send_zeroout_ok(struct drbd_peer_device *peer_device)
+{
+	return _drbd_send_zeroout_state(peer_device, 0);
+}
+
+int drbd_send_zeroout_fail(struct drbd_peer_device *peer_device)
+{
+	return _drbd_send_zeroout_state(peer_device, 1);
+}
+
 void drbd_print_uuids(struct drbd_device *device, const char *text)
 {
 	if (get_ldev_if_state(device, D_NEGOTIATING)) {
@@ -3466,8 +3522,8 @@ void drbd_uuid_move_history(struct drbd_device *device) __must_hold(local)
 {
 	int i;
 
-	for (i = UI_HISTORY_START; i < UI_HISTORY_END; i++)
-		device->ldev->md.uuid[i+1] = device->ldev->md.uuid[i];
+	for (i = UI_HISTORY_END; i > UI_HISTORY_START; i--)
+		device->ldev->md.uuid[i] = device->ldev->md.uuid[i-1];
 }
 
 void __drbd_uuid_set(struct drbd_device *device, int idx, u64 val) __must_hold(local)
diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index bb7e1b0..dc2bfec 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -4015,8 +4015,11 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 {
 	struct drbd_config_context adm_ctx;
 	struct drbd_device *device;
+	struct drbd_peer_device *peer_device = NULL;
 	enum drbd_ret_code retcode;
 	int skip_initial_sync = 0;
+	int zeroout_devices = 0;
+	int discard_devices = 0;
 	int err;
 	struct new_c_uuid_parms args;
 
@@ -4045,12 +4048,28 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	peer_device = first_peer_device(device);
+
 	/* this is "skip initial sync", assume to be clean */
 	if (device->state.conn == C_CONNECTED &&
-	    first_peer_device(device)->connection->agreed_pro_version >= 90 &&
+	    peer_device->connection->agreed_pro_version >= 90 &&
 	    device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED && args.clear_bm) {
 		drbd_info(device, "Preparing to skip initial sync\n");
 		skip_initial_sync = 1;
+	/* this is "zero out/discard" devices to make it all zero.
+	* ignore "zero out" if both "clear_bm" and "zeroout_devices/discard_devices" set. */
+	} else if (device->state.conn == C_CONNECTED &&
+		peer_device->connection->agreed_features & FF_DISCARD &&
+		device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED &&
+		args.zeroout_devices) {
+		drbd_info(device, "Preparing to zero out devices, will take a long time\n");
+		zeroout_devices = 1;
+	} else if (device->state.conn == C_CONNECTED &&
+		peer_device->connection->agreed_features & FF_DISCARD &&
+		device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED &&
+		args.discard_devices) {
+		drbd_info(device, "Preparing to discard devices, will take a long time\n");
+		discard_devices = 1;
 	} else if (device->state.conn != C_STANDALONE) {
 		retcode = ERR_CONNECTED;
 		goto out_dec;
@@ -4059,7 +4078,7 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 	drbd_uuid_set(device, UI_BITMAP, 0); /* Rotate UI_BITMAP to History 1, etc... */
 	drbd_uuid_new_current(device); /* New current, previous to UI_BITMAP */
 
-	if (args.clear_bm) {
+	if (args.clear_bm || args.zeroout_devices || args.discard_devices) {
 		err = drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
 			"clear_n_write from new_c_uuid", BM_LOCKED_MASK);
 		if (err) {
@@ -4067,7 +4086,7 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 			retcode = ERR_IO_MD_DISK;
 		}
 		if (skip_initial_sync) {
-			drbd_send_uuids_skip_initial_sync(first_peer_device(device));
+			drbd_send_uuids_skip_initial_sync(peer_device);
 			_drbd_uuid_set(device, UI_BITMAP, 0);
 			drbd_print_uuids(device, "cleared bitmap UUID");
 			spin_lock_irq(&device->resource->req_lock);
@@ -4075,6 +4094,22 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 					CS_VERBOSE, NULL);
 			spin_unlock_irq(&device->resource->req_lock);
 		}
+		if (zeroout_devices || discard_devices) {
+			if (discard_devices) {
+				drbd_send_discard_start(peer_device);
+				set_bit(DISCARD_DISK, &device->flags);
+			} else {
+				drbd_send_zeroout_start(peer_device);
+				clear_bit(DISCARD_DISK, &device->flags);
+			}
+			_drbd_uuid_set(device, UI_BITMAP, 0);
+			drbd_print_uuids(device, "cleared bitmap UUID for zeroing device");
+
+			/* CLear bit flag of zero out */
+			clear_bit(ZERO_DONE, &device->flags);
+			clear_bit(ZERO_FAIL, &device->flags);
+			drbd_device_post_work(device, P_ZERO_START);
+		}
 	}
 
 	drbd_md_sync(device);
diff --git a/drbd/drbd_protocol.h b/drbd/drbd_protocol.h
index 405b181..d9db0ce 100644
--- a/drbd/drbd_protocol.h
+++ b/drbd/drbd_protocol.h
@@ -59,6 +59,7 @@ enum drbd_packet {
 	/* REQ_DISCARD. We used "discard" in different contexts before,
 	 * which is why I chose TRIM here, to disambiguate. */
 	P_TRIM                = 0x31,
+	P_ZERO_OUT            = 0x32,
 
 	P_MAY_IGNORE	      = 0x100, /* Flag to test if (cmd > P_MAY_IGNORE) ... */
 	P_MAX_OPT_CMD	      = 0x101,
@@ -161,6 +162,7 @@ struct p_block_req {
  */
 
 #define FF_TRIM      1
+#define FF_DISCARD   4
 
 struct p_connection_features {
 	u32 protocol_min;
diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 06e5667..ec324ef 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -47,7 +47,7 @@
 #include "drbd_vli.h"
 #include <linux/scatterlist.h>
 
-#define PRO_FEATURES (FF_TRIM)
+#define PRO_FEATURES (FF_TRIM | FF_DISCARD)
 
 struct flush_work {
 	struct drbd_work w;
@@ -4317,6 +4317,20 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 			peer_device->connection->agreed_pro_version >= 90 &&
 			device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED &&
 			(p_uuid[UI_FLAGS] & 8);
+		int zeroout_devices =
+			device->state.conn == C_CONNECTED &&
+			peer_device->connection->agreed_pro_version >= 90 &&
+			device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED &&
+			(p_uuid[UI_FLAGS] & 16);
+		int discard_devices =
+			device->state.conn == C_CONNECTED &&
+			peer_device->connection->agreed_pro_version >= 90 &&
+			device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED &&
+			(p_uuid[UI_FLAGS] & 32);
+		int zeroout_finish =
+			device->state.conn == C_CONNECTED &&
+			peer_device->connection->agreed_pro_version >= 90 &&
+			(p_uuid[UI_FLAGS] & 64);
 		if (skip_initial_sync) {
 			drbd_info(device, "Accepted new current UUID, preparing to skip initial sync\n");
 			drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
@@ -4324,11 +4338,42 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
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
+		if (zeroout_devices || discard_devices) {
+			if (discard_devices) {
+				drbd_info(device, "Accepted to discard devices, will take a long time\n");
+				set_bit(DISCARD_DISK, &device->flags);
+			} else {
+				drbd_info(device, "Accepted to zeroout devices, will take a long time\n");
+				clear_bit(DISCARD_DISK, &device->flags);
+			}
+
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
+		if (zeroout_finish) {
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
@@ -4383,6 +4428,41 @@ static union drbd_state convert_state(union drbd_state ps)
 	return ms;
 }
 
+static int receive_zeroout_state(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	struct drbd_device *device;
+	struct p_state *p = pi->data;
+	unsigned int isfail;
+
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
+	device = peer_device->device;
+
+	isfail = be32_to_cpu(p->state);
+
+	if (isfail) {
+		drbd_info(device, "Failed to zero out peer device\n");
+		set_bit(ZERO_FAIL, &device->flags);
+	} else {
+		drbd_info(device, "Finished zero out peer device\n");
+		if (test_and_clear_bit(ZERO_DONE, &device->flags)) {
+			drbd_info(device, "Both side finished zeroing.\n");
+			spin_lock_irq(&device->resource->req_lock);
+			_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE,
+				pdsk, D_UP_TO_DATE), CS_VERBOSE, NULL);
+			spin_unlock_irq(&device->resource->req_lock);
+			drbd_send_zeroout_finish(peer_device);
+		} else {
+			/* waiting for local device finished */
+			set_bit(ZERO_DONE, &device->flags);
+		}
+	}
+
+	return 0;
+}
+
 static int receive_req_state(struct drbd_connection *connection, struct packet_info *pi)
 {
 	struct drbd_peer_device *peer_device;
@@ -5008,6 +5088,7 @@ static struct data_cmd drbd_cmd_handler[] = {
 	[P_CONN_ST_CHG_REQ] = { 0, sizeof(struct p_req_state), receive_req_conn_state },
 	[P_PROTOCOL_UPDATE] = { 1, sizeof(struct p_protocol), receive_protocol },
 	[P_TRIM]	    = { 0, sizeof(struct p_trim), receive_Data },
+	[P_ZERO_OUT]		= { 0, sizeof(struct p_state), receive_zeroout_state },
 };
 
 static void drbdd(struct drbd_connection *connection)
@@ -5287,6 +5368,9 @@ static int drbd_do_features(struct drbd_connection *connection)
 	drbd_info(connection, "Agreed to%ssupport TRIM on protocol level\n",
 		  connection->agreed_features & FF_TRIM ? " " : " not ");
 
+	drbd_info(connection, "Agreed to%ssupport DISCARD DEVICE on protocol level\n",
+		  connection->agreed_features & FF_DISCARD ? " " : " not ");
+
 	return 1;
 
  incompat:
diff --git a/drbd/drbd_worker.c b/drbd/drbd_worker.c
index 2a15aeb..a8e231f 100644
--- a/drbd/drbd_worker.c
+++ b/drbd/drbd_worker.c
@@ -1653,6 +1653,105 @@ void drbd_rs_controller_reset(struct drbd_device *device)
 	rcu_read_unlock();
 }
 
+/**
+ * zeroout_local_device()
+ * @device: DRBD device.
+ * @discard: whether to discard the block range.
+ *
+ * Description:
+ * Zero out drbd backing device when creating new uuid.
+ *
+**/
+int zeroout_local_device(struct drbd_device *device, bool discard)
+{
+	struct block_device *bdev;
+
+	bdev = device->ldev->backing_bdev;
+	if (device->ldev->known_size != drbd_get_capacity(bdev))
+		device->ldev->known_size = drbd_get_capacity(bdev);
+
+	if (discard){
+		/* zero out the backing device by discarding blocks */
+		return blkdev_issue_zeroout(bdev, 0,
+			device->ldev->known_size, GFP_NOIO, true);
+	} else {
+		/* zero out the backing device with WRITE call*/
+		return blkdev_issue_zeroout(bdev, 0,
+			device->ldev->known_size, GFP_NOIO, false);
+	}
+}
+
+/**
+ * require_zeroout_local_device()
+ * @device: DRBD device.
+ *
+ * Description:
+ * Start to zero out local device. Update
+ * status if peer node (secondary) finished
+ * zeroing.
+ *
+**/
+void require_zeroout_local_device(struct drbd_device *device)
+{
+	int zeroout_err = 0;
+
+	if (test_and_clear_bit(DISCARD_DISK, &device->flags)) {
+		zeroout_err = zeroout_local_device(device, true);
+	} else {
+		zeroout_err = zeroout_local_device(device, false);
+	}
+
+	if (zeroout_err) {
+		drbd_err(device, "Failed to zero out local device\n");
+		set_bit(ZERO_FAIL, &device->flags);
+		drbd_chk_io_error(device, 1, DRBD_WRITE_ERROR);
+	} else {
+		drbd_info(device, "Finished zero out local device.\n");
+
+		if (test_and_clear_bit(ZERO_DONE, &device->flags)) {
+			spin_lock_irq(&device->resource->req_lock);
+			_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE,
+				pdsk, D_UP_TO_DATE), CS_VERBOSE, NULL);
+			spin_unlock_irq(&device->resource->req_lock);
+			drbd_send_zeroout_finish(first_peer_device(device));
+		} else if (test_and_clear_bit(ZERO_FAIL, &device->flags)) {
+			drbd_info(device, "Peer device has already failed on zero out\n");
+		} else {
+			/* waiting for peer device finished */
+			set_bit(ZERO_DONE, &device->flags);
+		}
+	}
+}
+
+/**
+ * receive_zeroout_local_device()
+ * @device: DRBD device.
+ *
+ * Description:
+ * Start to zero out local device.
+ * Notify peer node the zeroing result.
+ *
+**/
+void receive_zeroout_local_device(struct drbd_device *device)
+{
+	int zeroout_err = 0;
+	struct drbd_peer_device *const peer_device = first_peer_device(device);
+
+	if (test_and_clear_bit(DISCARD_DISK, &device->flags)) {
+		zeroout_err = zeroout_local_device(device, true);
+	} else {
+		zeroout_err = zeroout_local_device(device, false);
+	}
+	if (zeroout_err) {
+		drbd_err(device, "Failed to zero out local device\n");
+		drbd_send_zeroout_fail(peer_device);
+		drbd_chk_io_error(device, 1, DRBD_WRITE_ERROR);
+	} else {
+		drbd_info(device, "Finished zero out local device.\n");
+		drbd_send_zeroout_ok(peer_device);
+	}
+}
+
 void start_resync_timer_fn(unsigned long data)
 {
 	struct drbd_device *device = (struct drbd_device *) data;
@@ -1986,6 +2085,10 @@ static void do_device_work(struct drbd_device *device, const unsigned long todo)
 		drbd_ldev_destroy(device);
 	if (test_bit(RS_START, &todo))
 		do_start_resync(device);
+	if (test_bit(P_ZERO_START, &todo))
+		require_zeroout_local_device(device);
+	if (test_bit(S_ZERO_START, &todo))
+		receive_zeroout_local_device(device);
 }
 
 #define DRBD_DEVICE_WORK_MASK	\
@@ -1995,6 +2098,8 @@ static void do_device_work(struct drbd_device *device, const unsigned long todo)
 	|(1UL << RS_START)	\
 	|(1UL << RS_PROGRESS)	\
 	|(1UL << RS_DONE)	\
+	|(1UL << P_ZERO_START)	\
+	|(1UL << S_ZERO_START)	\
 	)
 
 static unsigned long get_work_bits(unsigned long *flags)
diff --git a/drbd/linux/drbd_genl.h b/drbd/linux/drbd_genl.h
index 5db53f5..5a31a5c 100644
--- a/drbd/linux/drbd_genl.h
+++ b/drbd/linux/drbd_genl.h
@@ -240,6 +240,8 @@ GENL_struct(DRBD_NLA_START_OV_PARMS, 9, start_ov_parms,
 
 GENL_struct(DRBD_NLA_NEW_C_UUID_PARMS, 10, new_c_uuid_parms,
 	__flg_field(1, DRBD_GENLA_F_MANDATORY, clear_bm)
+	__flg_field(2, 0, zeroout_devices)
+	__flg_field(3, 0, discard_devices)
 )
 
 GENL_struct(DRBD_NLA_TIMEOUT_PARMS, 11, timeout_parms,
-- 
2.1.4

