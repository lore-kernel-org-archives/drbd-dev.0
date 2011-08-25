Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:51 +0200
Message-Id: <1314284934-17999-116-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 115/118] drbd: Implemented conn_send_sr_reply()
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
 drivers/block/drbd/drbd_int.h  |    1 +
 drivers/block/drbd/drbd_main.c |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 35e7303..4fc1b0db 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1216,6 +1216,7 @@ extern int drbd_send_ov_request(struct drbd_conf *mdev,sector_t sector,int size)
 extern int drbd_send_bitmap(struct drbd_conf *mdev);
 extern int _drbd_send_bitmap(struct drbd_conf *mdev);
 extern int drbd_send_sr_reply(struct drbd_conf *mdev, enum drbd_state_rv retcode);
+extern int conn_send_sr_reply(struct drbd_tconn *tconn, enum drbd_state_rv retcode);
 extern void drbd_free_bc(struct drbd_backing_dev *ldev);
 extern void drbd_mdev_cleanup(struct drbd_conf *mdev);
 void drbd_print_uuids(struct drbd_conf *mdev, const char *text);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index c41d93c..c4ac636 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1002,6 +1002,16 @@ int drbd_send_sr_reply(struct drbd_conf *mdev, enum drbd_state_rv retcode)
 	return drbd_send_cmd(mdev, USE_META_SOCKET, P_STATE_CHG_REPLY, &p.head, sizeof(p));
 }
 
+int conn_send_sr_reply(struct drbd_tconn *tconn, enum drbd_state_rv retcode)
+{
+	struct p_req_state_reply p;
+	enum drbd_packet cmd = tconn->agreed_pro_version < 100 ? P_STATE_CHG_REPLY : P_CONN_ST_CHG_REPLY;
+
+	p.retcode    = cpu_to_be32(retcode);
+
+	return conn_send_cmd(tconn, 0, USE_META_SOCKET, cmd, &p.head, sizeof(p));
+}
+
 int fill_bitmap_rle_bits(struct drbd_conf *mdev,
 	struct p_compressed_bm *p,
 	struct bm_xfer_ctx *c)
-- 
1.7.4.1

