Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:05 +0200
Message-Id: <1315223145-20640-15-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/54] drbd: drbd_gen_and_send_sync_uuid():
	Return void: the result is never used
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
 drivers/block/drbd/drbd_int.h  |    2 +-
 drivers/block/drbd/drbd_main.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index c8fd6cc..a375133 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1167,7 +1167,7 @@ extern int drbd_send_all(struct drbd_tconn *, struct socket *, void *, size_t,
 extern int drbd_send_protocol(struct drbd_tconn *tconn);
 extern int drbd_send_uuids(struct drbd_conf *mdev);
 extern int drbd_send_uuids_skip_initial_sync(struct drbd_conf *mdev);
-extern int drbd_gen_and_send_sync_uuid(struct drbd_conf *mdev);
+extern void drbd_gen_and_send_sync_uuid(struct drbd_conf *mdev);
 extern int drbd_send_sizes(struct drbd_conf *mdev, int trigger_reply, enum dds_flags flags);
 extern int _conn_send_state_req(struct drbd_tconn *, int vnr, enum drbd_packet cmd,
 				union drbd_state, union drbd_state);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 774b3ed..ad3e2d0 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -917,7 +917,7 @@ void drbd_print_uuids(struct drbd_conf *mdev, const char *text)
 	}
 }
 
-int drbd_gen_and_send_sync_uuid(struct drbd_conf *mdev)
+void drbd_gen_and_send_sync_uuid(struct drbd_conf *mdev)
 {
 	struct p_rs_uuid p;
 	u64 uuid;
@@ -930,7 +930,7 @@ int drbd_gen_and_send_sync_uuid(struct drbd_conf *mdev)
 	drbd_md_sync(mdev);
 	p.uuid = cpu_to_be64(uuid);
 
-	return !drbd_send_cmd(mdev, &mdev->tconn->data, P_SYNC_UUID, &p.head, sizeof(p));
+	drbd_send_cmd(mdev, &mdev->tconn->data, P_SYNC_UUID, &p.head, sizeof(p));
 }
 
 int drbd_send_sizes(struct drbd_conf *mdev, int trigger_reply, enum dds_flags flags)
-- 
1.7.4.1

