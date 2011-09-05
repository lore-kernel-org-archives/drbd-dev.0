Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:07 +0200
Message-Id: <1315223145-20640-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/54] drbd: _conn_send_state_req(): Return 0
	upon success and an error code otherwise
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h  |    4 ++--
 drivers/block/drbd/drbd_main.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index a375133..bf2eb2e 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1955,14 +1955,14 @@ static inline int drbd_send_ping_ack(struct drbd_tconn *tconn)
 static inline int drbd_send_state_req(struct drbd_conf *mdev,
 				      union drbd_state mask, union drbd_state val)
 {
-	return _conn_send_state_req(mdev->tconn, mdev->vnr, P_STATE_CHG_REQ, mask, val);
+	return !_conn_send_state_req(mdev->tconn, mdev->vnr, P_STATE_CHG_REQ, mask, val);
 }
 
 static inline int conn_send_state_req(struct drbd_tconn *tconn,
 				      union drbd_state mask, union drbd_state val)
 {
 	enum drbd_packet cmd = tconn->agreed_pro_version < 100 ? P_STATE_CHG_REQ : P_CONN_ST_CHG_REQ;
-	return _conn_send_state_req(tconn, 0, cmd, mask, val);
+	return !_conn_send_state_req(tconn, 0, cmd, mask, val);
 }
 
 static inline void drbd_thread_stop(struct drbd_thread *thi)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index e3b54ce..93713da 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -995,7 +995,7 @@ int _conn_send_state_req(struct drbd_tconn *tconn, int vnr, enum drbd_packet cmd
 	p.mask    = cpu_to_be32(mask.i);
 	p.val     = cpu_to_be32(val.i);
 
-	return !conn_send_cmd(tconn, vnr, &tconn->data, cmd, &p.head, sizeof(p));
+	return conn_send_cmd(tconn, vnr, &tconn->data, cmd, &p.head, sizeof(p));
 }
 
 int drbd_send_sr_reply(struct drbd_conf *mdev, enum drbd_state_rv retcode)
-- 
1.7.4.1

