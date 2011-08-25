Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:14 +0200
Message-Id: <1314284934-17999-79-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 078/118] drbd: Converted drbd_send_fp() from mdev
	to tconn
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |   13 +++++++++--
 drivers/block/drbd/drbd_main.c     |   37 +++++++++++++++++------------------
 drivers/block/drbd/drbd_receiver.c |   14 +++++-------
 3 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 1f590b9..615405d 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1167,9 +1167,9 @@ extern int drbd_gen_and_send_sync_uuid(struct drbd_conf *mdev);
 extern int drbd_send_sizes(struct drbd_conf *mdev, int trigger_reply, enum dds_flags flags);
 extern int _drbd_send_state(struct drbd_conf *mdev);
 extern int drbd_send_state(struct drbd_conf *mdev);
-extern int _drbd_send_cmd(struct drbd_conf *mdev, struct socket *sock,
-			  enum drbd_packet cmd, struct p_header *h,
-			  size_t size, unsigned msg_flags);
+extern int _conn_send_cmd(struct drbd_tconn *tconn, int vnr, struct socket *sock,
+			  enum drbd_packet cmd, struct p_header *h, size_t size,
+			  unsigned msg_flags);
 #define USE_DATA_SOCKET 1
 #define USE_META_SOCKET 0
 extern int drbd_send_cmd(struct drbd_conf *mdev, int use_data_socket,
@@ -1869,6 +1869,13 @@ static inline void request_ping(struct drbd_tconn *tconn)
 	wake_asender(tconn);
 }
 
+static inline int _drbd_send_cmd(struct drbd_conf *mdev, struct socket *sock,
+				  enum drbd_packet cmd, struct p_header *h, size_t size,
+				  unsigned msg_flags)
+{
+	return _conn_send_cmd(mdev->tconn, mdev->vnr, sock, cmd, h, size, msg_flags);
+}
+
 static inline int drbd_send_short_cmd(struct drbd_conf *mdev,
 				      enum drbd_packet cmd)
 {
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 357397e..544171a 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -663,51 +663,50 @@ void drbd_thread_current_set_cpu(struct drbd_conf *mdev, struct drbd_thread *thi
 }
 #endif
 
-static void prepare_header80(struct drbd_conf *mdev, struct p_header80 *h,
-			     enum drbd_packet cmd, int size)
+static void prepare_header80(struct p_header80 *h, enum drbd_packet cmd, int size)
 {
 	h->magic   = cpu_to_be32(DRBD_MAGIC);
 	h->command = cpu_to_be16(cmd);
 	h->length  = cpu_to_be16(size);
 }
 
-static void prepare_header95(struct drbd_conf *mdev, struct p_header95 *h,
-			     enum drbd_packet cmd, int size)
+static void prepare_header95(struct p_header95 *h, enum drbd_packet cmd, int size, int vnr)
 {
 	h->magic   = cpu_to_be16(DRBD_MAGIC_BIG);
 	h->command = cpu_to_be16(cmd);
-	h->vol_n_len = cpu_to_be32(mdev->vnr << 24 | size);
+	h->vol_n_len = cpu_to_be32(vnr << 24 | size);
+}
+
+static void _prepare_header(struct drbd_tconn *tconn, int vnr, struct p_header *h,
+			    enum drbd_packet cmd, int size)
+{
+	if (tconn->agreed_pro_version >= 100 || size > DRBD_MAX_SIZE_H80_PACKET)
+		prepare_header95(&h->h95, cmd, size, vnr);
+	else
+		prepare_header80(&h->h80, cmd, size);
 }
 
 static void prepare_header(struct drbd_conf *mdev, struct p_header *h,
 			   enum drbd_packet cmd, int size)
 {
-	if (mdev->tconn->agreed_pro_version >= 100 || size > DRBD_MAX_SIZE_H80_PACKET)
-		prepare_header95(mdev, &h->h95, cmd, size);
-	else
-		prepare_header80(mdev, &h->h80, cmd, size);
+	_prepare_header(mdev->tconn, mdev->vnr, h, cmd, size);
 }
 
 /* the appropriate socket mutex must be held already */
-int _drbd_send_cmd(struct drbd_conf *mdev, struct socket *sock,
+int _conn_send_cmd(struct drbd_tconn *tconn, int vnr, struct socket *sock,
 		   enum drbd_packet cmd, struct p_header *h, size_t size,
 		   unsigned msg_flags)
 {
 	int sent, ok;
 
-	if (!expect(h))
-		return false;
-	if (!expect(size))
-		return false;
-
-	prepare_header(mdev, h, cmd, size - sizeof(struct p_header));
+	_prepare_header(tconn, vnr, h, cmd, size - sizeof(struct p_header));
 
-	sent = drbd_send(mdev->tconn, sock, h, size, msg_flags);
+	sent = drbd_send(tconn, sock, h, size, msg_flags);
 
 	ok = (sent == size);
 	if (!ok && !signal_pending(current))
-		dev_warn(DEV, "short sent %s size=%d sent=%d\n",
-		    cmdname(cmd), (int)size, sent);
+		conn_warn(tconn, "short sent %s size=%d sent=%d\n",
+			  cmdname(cmd), (int)size, sent);
 	return ok;
 }
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 409b8c8..55538d7 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -698,16 +698,14 @@ out:
 	return s_estab;
 }
 
-static int drbd_send_fp(struct drbd_conf *mdev, struct socket *sock,
-			enum drbd_packet cmd)
+static int drbd_send_fp(struct drbd_tconn *tconn, struct socket *sock, enum drbd_packet cmd)
 {
-	struct p_header *h = &mdev->tconn->data.sbuf.header;
+	struct p_header *h = &tconn->data.sbuf.header;
 
-	return _drbd_send_cmd(mdev, sock, cmd, h, sizeof(*h), 0);
+	return _conn_send_cmd(tconn, 0, sock, cmd, h, sizeof(*h), 0);
 }
 
-static enum drbd_packet drbd_recv_fp(struct drbd_conf *mdev,
-				     struct socket *sock)
+static enum drbd_packet drbd_recv_fp(struct drbd_conf *mdev, struct socket *sock)
 {
 	struct p_header80 *h = &mdev->tconn->data.rbuf.header.h80;
 	int rr;
@@ -782,11 +780,11 @@ static int drbd_connect(struct drbd_conf *mdev)
 
 		if (s) {
 			if (!sock) {
-				drbd_send_fp(mdev, s, P_HAND_SHAKE_S);
+				drbd_send_fp(mdev->tconn, s, P_HAND_SHAKE_S);
 				sock = s;
 				s = NULL;
 			} else if (!msock) {
-				drbd_send_fp(mdev, s, P_HAND_SHAKE_M);
+				drbd_send_fp(mdev->tconn, s, P_HAND_SHAKE_M);
 				msock = s;
 				s = NULL;
 			} else {
-- 
1.7.4.1

