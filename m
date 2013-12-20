Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 20 Dec 2013 13:29:10 +0100
Message-Id: <1387542563-6833-14-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387542563-6833-1-git-send-email-philipp.reisner@linbit.com>
References: <1387542563-6833-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/26] drbd: Minor cleanup in conn_new_minor()
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
 drivers/block/drbd/drbd_main.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index e8ffb68..1ce1066 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2664,8 +2664,7 @@ enum drbd_ret_code drbd_create_minor(struct drbd_connection *connection, unsigne
 	struct drbd_peer_device *peer_device;
 	struct gendisk *disk;
 	struct request_queue *q;
-	int vnr_got = vnr;
-	int minor_got = minor;
+	int id;
 	enum drbd_ret_code err = ERR_NOMEM;
 
 	device = minor_to_device(minor);
@@ -2737,18 +2736,18 @@ enum drbd_ret_code drbd_create_minor(struct drbd_connection *connection, unsigne
 	device->read_requests = RB_ROOT;
 	device->write_requests = RB_ROOT;
 
-	minor_got = idr_alloc(&drbd_devices, device, minor, minor + 1, GFP_KERNEL);
-	if (minor_got < 0) {
-		if (minor_got == -ENOSPC) {
+	id = idr_alloc(&drbd_devices, device, minor, minor + 1, GFP_KERNEL);
+	if (id < 0) {
+		if (id == -ENOSPC) {
 			err = ERR_MINOR_EXISTS;
 			drbd_msg_put_info("requested minor exists already");
 		}
 		goto out_no_minor_idr;
 	}
 
-	vnr_got = idr_alloc(&connection->volumes, device, vnr, vnr + 1, GFP_KERNEL);
-	if (vnr_got < 0) {
-		if (vnr_got == -ENOSPC) {
+	id = idr_alloc(&connection->volumes, device, vnr, vnr + 1, GFP_KERNEL);
+	if (id < 0) {
+		if (id == -ENOSPC) {
 			err = ERR_INVALID_REQUEST;
 			drbd_msg_put_info("requested volume exists already");
 		}
@@ -2772,9 +2771,9 @@ enum drbd_ret_code drbd_create_minor(struct drbd_connection *connection, unsigne
 	return NO_ERROR;
 
 out_idr_remove_vol:
-	idr_remove(&connection->volumes, vnr_got);
+	idr_remove(&connection->volumes, vnr);
 out_idr_remove_minor:
-	idr_remove(&drbd_devices, minor_got);
+	idr_remove(&drbd_devices, minor);
 	synchronize_rcu();
 out_no_minor_idr:
 	drbd_bm_cleanup(device);
-- 
1.7.9.5

