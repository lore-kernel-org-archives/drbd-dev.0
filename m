Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 20 Dec 2013 13:29:23 +0100
Message-Id: <1387542563-6833-27-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387542563-6833-1-git-send-email-philipp.reisner@linbit.com>
References: <1387542563-6833-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 26/26] drbd: drbd_create_device(): Take a
	resource instead of a connection argument
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

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_int.h  |    2 +-
 drivers/block/drbd/drbd_main.c |    4 ++--
 drivers/block/drbd/drbd_nl.c   |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 7021621..e0b42f0 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1234,7 +1234,7 @@ extern struct bio *bio_alloc_drbd(gfp_t gfp_mask);
 extern rwlock_t global_state_lock;
 
 extern int conn_lowest_minor(struct drbd_connection *connection);
-enum drbd_ret_code drbd_create_device(struct drbd_connection *connection, unsigned int minor, int vnr);
+enum drbd_ret_code drbd_create_device(struct drbd_resource *resource, unsigned int minor, int vnr);
 extern void drbd_destroy_device(struct kref *kref);
 extern void drbd_delete_device(struct drbd_device *mdev);
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 7cab345..6ed09d5 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2661,9 +2661,9 @@ int init_submitter(struct drbd_device *device)
 	return 0;
 }
 
-enum drbd_ret_code drbd_create_device(struct drbd_connection *connection, unsigned int minor, int vnr)
+enum drbd_ret_code drbd_create_device(struct drbd_resource *resource, unsigned int minor, int vnr)
 {
-	struct drbd_resource *resource = connection->resource;
+	struct drbd_connection *connection = first_connection(resource);
 	struct drbd_device *device;
 	struct drbd_peer_device *peer_device;
 	struct gendisk *disk;
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index bc56fb0..abe96b0 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3348,7 +3348,7 @@ int drbd_adm_new_minor(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	retcode = drbd_create_device(adm_ctx.connection, dh->minor, adm_ctx.volume);
+	retcode = drbd_create_device(adm_ctx.resource, dh->minor, adm_ctx.volume);
 out:
 	drbd_adm_finish(info, retcode);
 	return 0;
-- 
1.7.9.5

