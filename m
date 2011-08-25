Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:51 +0200
Message-Id: <1314284934-17999-56-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 055/118] drbd: Improve the drbd_find_overlap()
	documentation
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Describe how to reach any further overlapping intervals from the first
overlap found.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_interval.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index 0d17eaa..14dbe2d 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -122,9 +122,11 @@ drbd_remove_interval(struct rb_root *root, struct drbd_interval *this)
  * @sector:	start sector
  * @size:	size, aligned to 512 bytes
  *
- * Returns the interval overlapping with [sector, sector + size), or NULL.
- * When there is more than one overlapping interval in the tree, the interval
- * with the lowest start sector is returned.
+ * Returns an interval overlapping with [sector, sector + size), or NULL if
+ * there is none.  When there is more than one overlapping interval in the
+ * tree, the interval with the lowest start sector is returned, and all other
+ * overlapping intervals will be on the right side of the tree, reachable with
+ * rb_next().
  */
 struct drbd_interval *
 drbd_find_overlap(struct rb_root *root, sector_t sector, unsigned int size)
-- 
1.7.4.1

