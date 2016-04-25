Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AE45C1056447
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:22 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:31 +0200
Message-Id: <1461586077-11581-5-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/30] drbd: Implement handling of thinly
	provisioned storage on resync target nodes
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

If during resync we read only zeroes for a range of sectors assume
that these secotors can be discarded on the sync target node.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |  5 +++
 drivers/block/drbd/drbd_main.c     | 18 ++++++++
 drivers/block/drbd/drbd_protocol.h |  4 ++
 drivers/block/drbd/drbd_receiver.c | 88 ++++++++++++++++++++++++++++++++++++--
 drivers/block/drbd/drbd_worker.c   | 29 ++++++++++++-
 5 files changed, 140 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 7a1cf7e..1a93f4f 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -471,6 +471,9 @@ enum {
 	/* this originates from application on peer
 	 * (not some resync or verify or other DRBD internal request) */
 	__EE_APPLICATION,
+
+	/* If it contains only 0 bytes, send back P_RS_DEALLOCATED */
+	__EE_RS_THIN_REQ,
 };
 #define EE_CALL_AL_COMPLETE_IO (1<<__EE_CALL_AL_COMPLETE_IO)
 #define EE_MAY_SET_IN_SYNC     (1<<__EE_MAY_SET_IN_SYNC)
@@ -485,6 +488,7 @@ enum {
 #define EE_SUBMITTED		(1<<__EE_SUBMITTED)
 #define EE_WRITE		(1<<__EE_WRITE)
 #define EE_APPLICATION		(1<<__EE_APPLICATION)
+#define EE_RS_THIN_REQ		(1<<__EE_RS_THIN_REQ)
 
 /* flag bits per device */
 enum {
@@ -1123,6 +1127,7 @@ extern int drbd_send_ov_request(struct drbd_peer_device *, sector_t sector, int
 extern int drbd_send_bitmap(struct drbd_device *device);
 extern void drbd_send_sr_reply(struct drbd_peer_device *, enum drbd_state_rv retcode);
 extern void conn_send_sr_reply(struct drbd_connection *connection, enum drbd_state_rv retcode);
+extern int drbd_send_rs_deallocated(struct drbd_peer_device *, struct drbd_peer_request *);
 extern void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *ldev);
 extern void drbd_device_cleanup(struct drbd_device *device);
 void drbd_print_uuids(struct drbd_device *device, const char *text);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 802d729..3cecc4f 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1377,6 +1377,22 @@ int drbd_send_ack_ex(struct drbd_peer_device *peer_device, enum drbd_packet cmd,
 			      cpu_to_be64(block_id));
 }
 
+int drbd_send_rs_deallocated(struct drbd_peer_device *peer_device,
+			     struct drbd_peer_request *peer_req)
+{
+	struct drbd_socket *sock;
+	struct p_block_desc *p;
+
+	sock = &peer_device->connection->data;
+	p = drbd_prepare_command(peer_device, sock);
+	if (!p)
+		return -EIO;
+	p->sector = cpu_to_be64(peer_req->i.sector);
+	p->blksize = cpu_to_be32(peer_req->i.size);
+	p->pad = 0;
+	return drbd_send_command(peer_device, sock, P_RS_DEALLOCATED, sizeof(*p), NULL, 0);
+}
+
 int drbd_send_drequest(struct drbd_peer_device *peer_device, int cmd,
 		       sector_t sector, int size, u64 block_id)
 {
@@ -3681,6 +3697,8 @@ const char *cmdname(enum drbd_packet cmd)
 		[P_CONN_ST_CHG_REPLY]	= "conn_st_chg_reply",
 		[P_RETRY_WRITE]		= "retry_write",
 		[P_PROTOCOL_UPDATE]	= "protocol_update",
+		[P_RS_THIN_REQ]         = "rs_thin_req",
+		[P_RS_DEALLOCATED]      = "rs_deallocated",
 
 		/* enum drbd_packet, but not commands - obsoleted flags:
 		 *	P_MAY_IGNORE
diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index ef92453..e5e74e3 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -60,6 +60,10 @@ enum drbd_packet {
 	 * which is why I chose TRIM here, to disambiguate. */
 	P_TRIM                = 0x31,
 
+	/* Only use these two if both support FF_THIN_RESYNC */
+	P_RS_THIN_REQ         = 0x32, /* Request a block for resync or reply P_RS_DEALLOCATED */
+	P_RS_DEALLOCATED      = 0x33, /* Contains only zeros on sync source node */
+
 	P_MAY_IGNORE	      = 0x100, /* Flag to test if (cmd > P_MAY_IGNORE) ... */
 	P_MAX_OPT_CMD	      = 0x101,
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 8b30ab5..3a6c2ec 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1417,9 +1417,15 @@ int drbd_submit_peer_request(struct drbd_device *device,
 		 * so we can find it to present it in debugfs */
 		peer_req->submit_jif = jiffies;
 		peer_req->flags |= EE_SUBMITTED;
-		spin_lock_irq(&device->resource->req_lock);
-		list_add_tail(&peer_req->w.list, &device->active_ee);
-		spin_unlock_irq(&device->resource->req_lock);
+
+		/* If this was a resync request from receive_rs_deallocated(),
+		 * it is already on the sync_ee list */
+		if (list_empty(&peer_req->w.list)) {
+			spin_lock_irq(&device->resource->req_lock);
+			list_add_tail(&peer_req->w.list, &device->active_ee);
+			spin_unlock_irq(&device->resource->req_lock);
+		}
+
 		if (blkdev_issue_zeroout(device->ldev->backing_bdev,
 			sector, data_size >> 9, GFP_NOIO, false))
 			peer_req->flags |= EE_WAS_ERROR;
@@ -2574,6 +2580,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		case P_DATA_REQUEST:
 			drbd_send_ack_rp(peer_device, P_NEG_DREPLY, p);
 			break;
+		case P_RS_THIN_REQ:
 		case P_RS_DATA_REQUEST:
 		case P_CSUM_RS_REQUEST:
 		case P_OV_REQUEST:
@@ -2613,6 +2620,12 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		peer_req->flags |= EE_APPLICATION;
 		goto submit;
 
+	case P_RS_THIN_REQ:
+		/* If at some point in the future we have a smart way to
+		   find out if this data block is completely deallocated,
+		   then we would do something smarter here than reading
+		   the block... */
+		peer_req->flags |= EE_RS_THIN_REQ;
 	case P_RS_DATA_REQUEST:
 		peer_req->w.cb = w_e_end_rsdata_req;
 		fault_type = DRBD_FAULT_RS_RD;
@@ -4587,6 +4600,72 @@ static int receive_out_of_sync(struct drbd_connection *connection, struct packet
 	return 0;
 }
 
+static int receive_rs_deallocated(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	struct p_block_desc *p = pi->data;
+	struct drbd_device *device;
+	sector_t sector;
+	int size, err = 0;
+
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
+	device = peer_device->device;
+
+	sector = be64_to_cpu(p->sector);
+	size = be32_to_cpu(p->blksize);
+
+	dec_rs_pending(device);
+
+	if (get_ldev(device)) {
+		struct drbd_peer_request *peer_req;
+		const int rw = REQ_WRITE | REQ_DISCARD;
+
+		peer_req = drbd_alloc_peer_req(peer_device, ID_SYNCER, sector,
+					       size, false, GFP_NOIO);
+		if (!peer_req) {
+			put_ldev(device);
+			return -ENOMEM;
+		}
+
+		peer_req->w.cb = e_end_resync_block;
+		peer_req->submit_jif = jiffies;
+		peer_req->flags |= EE_IS_TRIM;
+
+		spin_lock_irq(&device->resource->req_lock);
+		list_add_tail(&peer_req->w.list, &device->sync_ee);
+		spin_unlock_irq(&device->resource->req_lock);
+
+		atomic_add(pi->size >> 9, &device->rs_sect_ev);
+		err = drbd_submit_peer_request(device, peer_req, rw, DRBD_FAULT_RS_WR);
+
+		if (err) {
+			spin_lock_irq(&device->resource->req_lock);
+			list_del(&peer_req->w.list);
+			spin_unlock_irq(&device->resource->req_lock);
+
+			drbd_free_peer_req(device, peer_req);
+			put_ldev(device);
+			err = 0;
+			goto fail;
+		}
+
+		inc_unacked(device);
+
+		/* No put_ldev() here. Gets called in drbd_endio_write_sec_final(),
+		   as well as drbd_rs_complete_io() */
+	} else {
+	fail:
+		drbd_rs_complete_io(device, sector);
+		drbd_send_ack_ex(peer_device, P_NEG_ACK, sector, size, ID_SYNCER);
+	}
+
+	atomic_add(size >> 9, &device->rs_sect_in);
+
+	return err;
+}
+
 struct data_cmd {
 	int expect_payload;
 	size_t pkt_size;
@@ -4614,11 +4693,14 @@ static struct data_cmd drbd_cmd_handler[] = {
 	[P_OV_REQUEST]      = { 0, sizeof(struct p_block_req), receive_DataRequest },
 	[P_OV_REPLY]        = { 1, sizeof(struct p_block_req), receive_DataRequest },
 	[P_CSUM_RS_REQUEST] = { 1, sizeof(struct p_block_req), receive_DataRequest },
+	[P_RS_THIN_REQ]     = { 0, sizeof(struct p_block_req), receive_DataRequest },
 	[P_DELAY_PROBE]     = { 0, sizeof(struct p_delay_probe93), receive_skip },
 	[P_OUT_OF_SYNC]     = { 0, sizeof(struct p_block_desc), receive_out_of_sync },
 	[P_CONN_ST_CHG_REQ] = { 0, sizeof(struct p_req_state), receive_req_conn_state },
 	[P_PROTOCOL_UPDATE] = { 1, sizeof(struct p_protocol), receive_protocol },
 	[P_TRIM]	    = { 0, sizeof(struct p_trim), receive_Data },
+	[P_RS_DEALLOCATED]  = { 0, sizeof(struct p_block_desc), receive_rs_deallocated },
+
 };
 
 static void drbdd(struct drbd_connection *connection)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 4d87499..01d74ee2 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1035,6 +1035,30 @@ int w_e_end_data_req(struct drbd_work *w, int cancel)
 	return err;
 }
 
+static bool all_zero(struct drbd_peer_request *peer_req)
+{
+	struct page *page = peer_req->pages;
+	unsigned int len = peer_req->i.size;
+
+	page_chain_for_each(page) {
+		unsigned int l = min_t(unsigned int, len, PAGE_SIZE);
+		unsigned int i, words = l / sizeof(long);
+		unsigned long *d;
+
+		d = kmap_atomic(page);
+		for (i = 0; i < words; i++) {
+			if (d[i]) {
+				kunmap_atomic(d);
+				return false;
+			}
+		}
+		kunmap_atomic(d);
+		len -= l;
+	}
+
+	return true;
+}
+
 /**
  * w_e_end_rsdata_req() - Worker callback to send a P_RS_DATA_REPLY packet in response to a P_RS_DATA_REQUEST
  * @w:		work object.
@@ -1063,7 +1087,10 @@ int w_e_end_rsdata_req(struct drbd_work *w, int cancel)
 	} else if (likely((peer_req->flags & EE_WAS_ERROR) == 0)) {
 		if (likely(device->state.pdsk >= D_INCONSISTENT)) {
 			inc_rs_pending(device);
-			err = drbd_send_block(peer_device, P_RS_DATA_REPLY, peer_req);
+			if (peer_req->flags & EE_RS_THIN_REQ && all_zero(peer_req))
+				err = drbd_send_rs_deallocated(peer_device, peer_req);
+			else
+				err = drbd_send_block(peer_device, P_RS_DATA_REPLY, peer_req);
 		} else {
 			if (__ratelimit(&drbd_ratelimit_state))
 				drbd_err(device, "Not sending RSDataReply, "
-- 
1.9.1

