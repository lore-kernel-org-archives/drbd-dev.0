Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  8 Sep 2011 14:45:35 +0200
Message-Id: <1315485937-18989-15-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315485937-18989-1-git-send-email-philipp.reisner@linbit.com>
References: <1315485937-18989-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/16] drbd: prepare to activate two activity log
	extents at once
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index df78810..1e3ddd7 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -207,15 +207,22 @@ static struct lc_element *_al_get(struct drbd_conf *mdev, unsigned int enr)
 
 void drbd_al_begin_io(struct drbd_conf *mdev, struct drbd_interval *i)
 {
-	unsigned int enr = (i->sector >> (AL_EXTENT_SHIFT-9));
-	struct lc_element *al_ext;
+	/* for bios crossing activity log extent boundaries,
+	 * we may need to activate two extents in one go */
+	unsigned int enr[2];
+	struct lc_element *al_ext[2] = { NULL, NULL };
 	struct update_al_work al_work;
 
 	D_ASSERT(atomic_read(&mdev->local_cnt) > 0);
 
-	wait_event(mdev->al_wait, (al_ext = _al_get(mdev, enr)));
+	enr[0] = i->sector >> (AL_EXTENT_SHIFT-9);
+	enr[1] = (i->sector + (i->size >> 9) - 1) >> (AL_EXTENT_SHIFT-9);
+	wait_event(mdev->al_wait, (al_ext[0] = _al_get(mdev, enr[0])));
+	if (enr[0] != enr[1])
+		wait_event(mdev->al_wait, (al_ext[1] = _al_get(mdev, enr[1])));
 
-	if (al_ext->lc_number != enr) {
+	if (al_ext[0]->lc_number != enr[0] ||
+	    (al_ext[1] && al_ext[1]->lc_number != enr[1])) {
 		/* drbd_al_write_transaction(mdev,al_ext,enr);
 		 * recurses into generic_make_request(), which
 		 * disallows recursion, bios being serialized on the
@@ -232,7 +239,8 @@ void drbd_al_begin_io(struct drbd_conf *mdev, struct drbd_interval *i)
 
 		/* Double check: it may have been committed by someone else,
 		 * while we have been waiting for the lock. */
-		if (al_ext->lc_number != enr) {
+		if (al_ext[0]->lc_number != enr[0] ||
+		    (al_ext[1] && al_ext[1]->lc_number != enr[1])) {
 			init_completion(&al_work.event);
 			al_work.w.cb = w_al_write_transaction;
 			al_work.w.mdev = mdev;
-- 
1.7.4.1

