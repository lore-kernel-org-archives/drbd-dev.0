Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: akpm@linux-foundation.org
Date: Wed,  6 Feb 2013 11:39:57 -0800
Message-Id: <1360179649-22465-26-git-send-email-tj@kernel.org>
In-Reply-To: <1360179649-22465-1-git-send-email-tj@kernel.org>
References: <1360179649-22465-1-git-send-email-tj@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 25/77] drbd: convert to idr_alloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Convert to the much saner new idr interface.

Only compile tested.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: drbd-dev@lists.linbit.com
Cc: drbd-user@lists.linbit.com
---
 drivers/block/drbd/drbd_main.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 8c13eeb..e98da67 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2660,25 +2660,24 @@ enum drbd_ret_code conn_new_minor(struct drbd_tconn *tconn, unsigned int minor,
 	mdev->read_requests = RB_ROOT;
 	mdev->write_requests = RB_ROOT;
 
-	if (!idr_pre_get(&minors, GFP_KERNEL))
-		goto out_no_minor_idr;
-	if (idr_get_new_above(&minors, mdev, minor, &minor_got))
+	minor_got = idr_alloc(&minors, mdev, minor, minor + 1, GFP_KERNEL);
+	if (minor_got < 0) {
+		if (minor_got == -ENOSPC) {
+			err = ERR_MINOR_EXISTS;
+			drbd_msg_put_info("requested minor exists already");
+		}
 		goto out_no_minor_idr;
-	if (minor_got != minor) {
-		err = ERR_MINOR_EXISTS;
-		drbd_msg_put_info("requested minor exists already");
-		goto out_idr_remove_minor;
 	}
 
-	if (!idr_pre_get(&tconn->volumes, GFP_KERNEL))
-		goto out_idr_remove_minor;
-	if (idr_get_new_above(&tconn->volumes, mdev, vnr, &vnr_got))
+	vnr_got = idr_alloc(&tconn->volumes, mdev, vnr, vnr + 1, GFP_KERNEL);
+	if (vnr_got < 0) {
+		if (vnr_got == -ENOSPC) {
+			err = ERR_INVALID_REQUEST;
+			drbd_msg_put_info("requested volume exists already");
+		}
 		goto out_idr_remove_minor;
-	if (vnr_got != vnr) {
-		err = ERR_INVALID_REQUEST;
-		drbd_msg_put_info("requested volume exists already");
-		goto out_idr_remove_vol;
 	}
+
 	add_disk(disk);
 	kref_init(&mdev->kref); /* one ref for both idrs and the the add_disk */
 
@@ -2689,8 +2688,6 @@ enum drbd_ret_code conn_new_minor(struct drbd_tconn *tconn, unsigned int minor,
 
 	return NO_ERROR;
 
-out_idr_remove_vol:
-	idr_remove(&tconn->volumes, vnr_got);
 out_idr_remove_minor:
 	idr_remove(&minors, minor_got);
 	synchronize_rcu();
-- 
1.8.1

