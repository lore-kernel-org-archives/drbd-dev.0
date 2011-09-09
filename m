Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  9 Sep 2011 13:17:33 +0200
Message-Id: <1315567056-32314-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315567056-32314-1-git-send-email-philipp.reisner@linbit.com>
References: <1315567056-32314-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/11] drbd: Implemented conn_lowest_disk()
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
 drivers/block/drbd/drbd_state.c |   12 ++++++++++++
 drivers/block/drbd/drbd_state.h |    1 +
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index e441d1f..5db514e 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -103,6 +103,18 @@ enum drbd_disk_state conn_highest_disk(struct drbd_tconn *tconn)
 	return ds;
 }
 
+enum drbd_disk_state conn_lowest_disk(struct drbd_tconn *tconn)
+{
+	enum drbd_disk_state ds = D_MASK;
+	struct drbd_conf *mdev;
+	int vnr;
+
+	idr_for_each_entry(&tconn->volumes, mdev, vnr)
+		ds = min_t(enum drbd_disk_state, ds, mdev->state.disk);
+
+	return ds;
+}
+
 enum drbd_disk_state conn_highest_pdsk(struct drbd_tconn *tconn)
 {
 	enum drbd_disk_state ds = D_DISKLESS;
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index e554537..72e2053 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -153,6 +153,7 @@ static inline int drbd_request_state(struct drbd_conf *mdev,
 enum drbd_role conn_highest_role(struct drbd_tconn *tconn);
 enum drbd_role conn_highest_peer(struct drbd_tconn *tconn);
 enum drbd_disk_state conn_highest_disk(struct drbd_tconn *tconn);
+enum drbd_disk_state conn_lowest_disk(struct drbd_tconn *tconn);
 enum drbd_disk_state conn_highest_pdsk(struct drbd_tconn *tconn);
 enum drbd_disk_state conn_lowest_conn(struct drbd_tconn *tconn);
 
-- 
1.7.4.1

