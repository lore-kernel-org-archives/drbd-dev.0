Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 203DA10556A0
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jul 2015 10:39:39 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Mon, 13 Jul 2015 16:38:58 +0800
Message-Id: <1436776744-3135-5-git-send-email-nwang@suse.com>
In-Reply-To: <1436776744-3135-1-git-send-email-nwang@suse.com>
References: <1436776744-3135-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [Patch v2 04/10] drbd: New packet P_ZERO_OUT
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

Using packet P_ZERO_OUT to get peer node's result
of zeroing out.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 drbd/drbd_int.h      |  5 +++++
 drbd/drbd_main.c     | 28 ++++++++++++++++++++++++++++
 drbd/drbd_protocol.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index 9ecf971..014b65e 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -622,6 +622,9 @@ enum {
 	RS_START,		/* tell worker to start resync/OV */
 	RS_PROGRESS,		/* tell worker that resync made significant progress */
 	RS_DONE,		/* tell worker that resync is done */
+	/* used for zero out device */
+	ZERO_DONE,		/* succeed on zero out a device */
+	ZERO_FAIL,		/* fail to zero out a device */
 };
 
 struct drbd_bitmap; /* opaque for drbd_device */
@@ -1205,6 +1208,8 @@ extern int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_pa
 extern int drbd_send_protocol(struct drbd_connection *connection);
 extern int drbd_send_uuids(struct drbd_peer_device *);
 extern int drbd_send_uuids_skip_initial_sync(struct drbd_peer_device *);
+extern int drbd_send_zero_out_ok(struct drbd_peer_device *);
+extern int drbd_send_zero_out_fail(struct drbd_peer_device *);
 extern void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *);
 extern int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enum dds_flags flags);
 extern int drbd_send_state(struct drbd_peer_device *, union drbd_state);
diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index a3dc39e..740015e 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -908,6 +908,34 @@ int drbd_send_uuids_skip_initial_sync(struct drbd_peer_device *peer_device)
 	return _drbd_send_uuids(peer_device, 8);
 }
 
+/**
+ * _drbd_send_zero_out_state() - Sends the drbd state to the peer
+ * @peer_device:	DRBD peer device.
+ * @state:	Device zero out status.
+ */
+static int _drbd_send_zero_out_state(struct drbd_peer_device *peer_device, unsigned int status)
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
+int drbd_send_zero_out_ok(struct drbd_peer_device *peer_device)
+{
+	return _drbd_send_zero_out_state(peer_device, 0);
+}
+
+int drbd_send_zero_out_fail(struct drbd_peer_device *peer_device)
+{
+	return _drbd_send_zero_out_state(peer_device, 1);
+}
+
 void drbd_print_uuids(struct drbd_device *device, const char *text)
 {
 	if (get_ldev_if_state(device, D_NEGOTIATING)) {
diff --git a/drbd/drbd_protocol.h b/drbd/drbd_protocol.h
index 405b181..3a82442 100644
--- a/drbd/drbd_protocol.h
+++ b/drbd/drbd_protocol.h
@@ -59,6 +59,7 @@ enum drbd_packet {
 	/* REQ_DISCARD. We used "discard" in different contexts before,
 	 * which is why I chose TRIM here, to disambiguate. */
 	P_TRIM                = 0x31,
+	P_ZERO_OUT            = 0x32,
 
 	P_MAY_IGNORE	      = 0x100, /* Flag to test if (cmd > P_MAY_IGNORE) ... */
 	P_MAX_OPT_CMD	      = 0x101,
-- 
1.8.4.5

