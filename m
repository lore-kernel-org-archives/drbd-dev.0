Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue, 30 Aug 2011 11:05:36 +0200
Message-Id: <1314695149-387-3-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314695149-387-1-git-send-email-philipp.reisner@linbit.com>
References: <1314695149-387-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/15] drbd: Iterate over all overlapping
	intervals in a tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Add a macro and helper function for doing that.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_interval.c |   18 ++++++++++++++++++
 drivers/block/drbd/drbd_interval.h |   16 ++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index 14dbe2d..0e53f10 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -157,3 +157,21 @@ drbd_find_overlap(struct rb_root *root, sector_t sector, unsigned int size)
 	}
 	return overlap;
 }
+
+struct drbd_interval *
+drbd_next_overlap(struct drbd_interval *i, sector_t sector, unsigned int size)
+{
+	sector_t end = sector + (size >> 9);
+	struct rb_node *node;
+
+	for (;;) {
+		node = rb_next(&i->rb);
+		if (!node)
+			return NULL;
+		i = rb_entry(node, struct drbd_interval, rb);
+		if (i->sector >= end)
+			return NULL;
+		if (sector < i->sector + (i->size >> 9))
+			return i;
+	}
+}
diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd_interval.h
index 4010ad9..f38fcb0 100644
--- a/drivers/block/drbd/drbd_interval.h
+++ b/drivers/block/drbd/drbd_interval.h
@@ -23,10 +23,18 @@ static inline bool drbd_interval_empty(struct drbd_interval *i)
 	return RB_EMPTY_NODE(&i->rb);
 }
 
-bool drbd_insert_interval(struct rb_root *, struct drbd_interval *);
-bool drbd_contains_interval(struct rb_root *, sector_t, struct drbd_interval *);
-void drbd_remove_interval(struct rb_root *, struct drbd_interval *);
-struct drbd_interval *drbd_find_overlap(struct rb_root *, sector_t,
+extern bool drbd_insert_interval(struct rb_root *, struct drbd_interval *);
+extern bool drbd_contains_interval(struct rb_root *, sector_t,
+				   struct drbd_interval *);
+extern void drbd_remove_interval(struct rb_root *, struct drbd_interval *);
+extern struct drbd_interval *drbd_find_overlap(struct rb_root *, sector_t,
 					unsigned int);
+extern struct drbd_interval *drbd_next_overlap(struct drbd_interval *, sector_t,
+					unsigned int);
+
+#define drbd_for_each_overlap(i, root, sector, size)		\
+	for (i = drbd_find_overlap(root, sector, size);		\
+	     i;							\
+	     i = drbd_next_overlap(i, sector, size))
 
 #endif  /* __DRBD_INTERVAL_H */
-- 
1.7.4.1

