Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:25 +0200
Message-Id: <1314284934-17999-90-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 089/118] drbd: Converted drbd_send_protocol()
	from mdev to tconn
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
 drivers/block/drbd/drbd_int.h      |    2 +-
 drivers/block/drbd/drbd_main.c     |   30 +++++++++++++++---------------
 drivers/block/drbd/drbd_receiver.c |    2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ddff35b..9bd156a 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1160,7 +1160,7 @@ extern void _tl_add_barrier(struct drbd_conf *, struct drbd_tl_epoch *);
 extern void drbd_free_sock(struct drbd_conf *mdev);
 extern int drbd_send(struct drbd_tconn *tconn, struct socket *sock,
 		     void *buf, size_t size, unsigned msg_flags);
-extern int drbd_send_protocol(struct drbd_conf *mdev);
+extern int drbd_send_protocol(struct drbd_tconn *tconn);
 extern int drbd_send_uuids(struct drbd_conf *mdev);
 extern int drbd_send_uuids_skip_initial_sync(struct drbd_conf *mdev);
 extern int drbd_gen_and_send_sync_uuid(struct drbd_conf *mdev);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 14961d8..ca40f0a 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -808,15 +808,15 @@ int drbd_send_sync_param(struct drbd_conf *mdev, struct syncer_conf *sc)
 	return rv;
 }
 
-int drbd_send_protocol(struct drbd_conf *mdev)
+int drbd_send_protocol(struct drbd_tconn *tconn)
 {
 	struct p_protocol *p;
 	int size, cf, rv;
 
 	size = sizeof(struct p_protocol);
 
-	if (mdev->tconn->agreed_pro_version >= 87)
-		size += strlen(mdev->tconn->net_conf->integrity_alg) + 1;
+	if (tconn->agreed_pro_version >= 87)
+		size += strlen(tconn->net_conf->integrity_alg) + 1;
 
 	/* we must not recurse into our own queue,
 	 * as that is blocked during handshake */
@@ -824,30 +824,30 @@ int drbd_send_protocol(struct drbd_conf *mdev)
 	if (p == NULL)
 		return 0;
 
-	p->protocol      = cpu_to_be32(mdev->tconn->net_conf->wire_protocol);
-	p->after_sb_0p   = cpu_to_be32(mdev->tconn->net_conf->after_sb_0p);
-	p->after_sb_1p   = cpu_to_be32(mdev->tconn->net_conf->after_sb_1p);
-	p->after_sb_2p   = cpu_to_be32(mdev->tconn->net_conf->after_sb_2p);
-	p->two_primaries = cpu_to_be32(mdev->tconn->net_conf->two_primaries);
+	p->protocol      = cpu_to_be32(tconn->net_conf->wire_protocol);
+	p->after_sb_0p   = cpu_to_be32(tconn->net_conf->after_sb_0p);
+	p->after_sb_1p   = cpu_to_be32(tconn->net_conf->after_sb_1p);
+	p->after_sb_2p   = cpu_to_be32(tconn->net_conf->after_sb_2p);
+	p->two_primaries = cpu_to_be32(tconn->net_conf->two_primaries);
 
 	cf = 0;
-	if (mdev->tconn->net_conf->want_lose)
+	if (tconn->net_conf->want_lose)
 		cf |= CF_WANT_LOSE;
-	if (mdev->tconn->net_conf->dry_run) {
-		if (mdev->tconn->agreed_pro_version >= 92)
+	if (tconn->net_conf->dry_run) {
+		if (tconn->agreed_pro_version >= 92)
 			cf |= CF_DRY_RUN;
 		else {
-			dev_err(DEV, "--dry-run is not supported by peer");
+			conn_err(tconn, "--dry-run is not supported by peer");
 			kfree(p);
 			return -1;
 		}
 	}
 	p->conn_flags    = cpu_to_be32(cf);
 
-	if (mdev->tconn->agreed_pro_version >= 87)
-		strcpy(p->integrity_alg, mdev->tconn->net_conf->integrity_alg);
+	if (tconn->agreed_pro_version >= 87)
+		strcpy(p->integrity_alg, tconn->net_conf->integrity_alg);
 
-	rv = drbd_send_cmd(mdev, USE_DATA_SOCKET, P_PROTOCOL, &p->head, size);
+	rv = conn_send_cmd2(tconn, P_PROTOCOL, p->head.payload, size);
 	kfree(p);
 	return rv;
 }
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 95b0d6c..42a2b39 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -910,7 +910,7 @@ retry:
 
 	drbd_thread_start(&mdev->tconn->asender);
 
-	if (drbd_send_protocol(mdev) == -1)
+	if (drbd_send_protocol(mdev->tconn) == -1)
 		return -1;
 	drbd_send_sync_param(mdev, &mdev->sync_conf);
 	drbd_send_sizes(mdev, 0, 0);
-- 
1.7.4.1

