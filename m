Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EADEA10556A0
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 09:49:20 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed, 10 Jun 2015 15:48:26 +0800
Message-Id: <1433922509-10280-8-git-send-email-nwang@suse.com>
In-Reply-To: <1433922509-10280-1-git-send-email-nwang@suse.com>
References: <1433922509-10280-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH 07/10] Using P_ZERO_OUT to send back device zero
	out status.
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

Send back status of zero out device to peer node.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

---
 drbd/drbd_int.h  |  2 ++
 drbd/drbd_main.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index b49095e..e956eb4 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -1210,6 +1210,8 @@ extern int drbd_send_protocol(struct drbd_connection *connection);
 extern int drbd_send_uuids(struct drbd_peer_device *);
 extern int drbd_send_uuids_skip_initial_sync(struct drbd_peer_device *);
 extern int drbd_send_zero_out_start(struct drbd_peer_device *);
+extern int drbd_send_zero_out_ok(struct drbd_peer_device *);
+extern int drbd_send_zero_out_fail(struct drbd_peer_device *);
 extern void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *);
 extern int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enum dds_flags flags);
 extern int drbd_send_state(struct drbd_peer_device *, union drbd_state);
diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 841ed30..5892ff3 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -913,6 +913,34 @@ int drbd_send_zero_out_start(struct drbd_peer_device *peer_device)
 	return _drbd_send_uuids(peer_device, 16);
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
-- 
1.8.4.5

