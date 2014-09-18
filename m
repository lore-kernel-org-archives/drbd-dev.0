Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1CE2E101AC7F
	for <drbd-dev@lists.linbit.com>; Thu, 18 Sep 2014 16:49:45 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 18 Sep 2014 16:49:41 +0200
Message-Id: <1411051782-23375-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1411051782-23375-1-git-send-email-philipp.reisner@linbit.com>
References: <1411051782-23375-1-git-send-email-philipp.reisner@linbit.com>
Cc: Michel Lespinasse <walken@google.com>, Lai Jiangshan <laijs@cn.fujitsu.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/2] drbd: compute the end before
	rb_insert_augmented()
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

From: Lai Jiangshan <laijs@cn.fujitsu.com>

Commit 98683650 "Merge branch 'drbd-8.4_ed6' into
for-3.8-drivers-drbd-8.4_ed6" switches to the new augment API, but the
new API requires that the tree is augmented before rb_insert_augmented()
is called, which is missing.

So we add the augment-code to drbd_insert_interval() when it travels the
tree up to down before rb_insert_augmented().  See the example in
include/linux/interval_tree_generic.h or Documentation/rbtree.txt.

drbd_insert_interval() may cancel the insertion when traveling, in this
case, the just added augment-code does nothing before cancel since the
@this node is already in the subtrees in this case.

CC: Michel Lespinasse <walken@google.com>
CC: stable@kernel.org # v3.10+
Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_interval.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index 89c497c..04a14e0 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -79,6 +79,7 @@ bool
 drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
 {
 	struct rb_node **new = &root->rb_node, *parent = NULL;
+	sector_t this_end = this->sector + (this->size >> 9);
 
 	BUG_ON(!IS_ALIGNED(this->size, 512));
 
@@ -87,6 +88,8 @@ drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
 			rb_entry(*new, struct drbd_interval, rb);
 
 		parent = *new;
+		if (here->end < this_end)
+			here->end = this_end;
 		if (this->sector < here->sector)
 			new = &(*new)->rb_left;
 		else if (this->sector > here->sector)
@@ -99,6 +102,7 @@ drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
 			return false;
 	}
 
+	this->end = this_end;
 	rb_link_node(&this->rb, parent, new);
 	rb_insert_augmented(&this->rb, root, &augment_callbacks);
 	return true;
-- 
1.9.1

