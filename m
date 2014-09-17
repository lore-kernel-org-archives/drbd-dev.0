Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CDB87101E048
	for <drbd-dev@lists.linbit.com>; Wed, 17 Sep 2014 16:23:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C63762A0948
	for <drbd-dev@lists.linbit.com>; Wed, 17 Sep 2014 16:23:10 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id RmjgA_E6EpMa for <drbd-dev@lists.linbit.com>;
	Wed, 17 Sep 2014 16:23:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id AAD6E2A7B43
	for <drbd-dev@lists.linbit.com>; Wed, 17 Sep 2014 16:23:10 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id f7Y2D8hIxQ-7 for <drbd-dev@lists.linbit.com>;
	Wed, 17 Sep 2014 16:23:10 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 54B862A0948
	for <drbd-dev@lists.linbit.com>; Wed, 17 Sep 2014 16:23:10 +0200 (CEST)
Resent-Message-ID: <20140917142310.GO13125@soda.linbit>
From: Lai Jiangshan <laijs@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>
Date: Wed, 17 Sep 2014 10:25:33 +0800
Message-ID: <1410920735-5767-1-git-send-email-laijs@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Michel Lespinasse <walken@google.com>, Lai Jiangshan <laijs@cn.fujitsu.com>,
	drbd-user@lists.linbit.com, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH bug-fix] drbd: compute the end before
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

986836503e49 ("Merge branch 'drbd-8.4_ed6' into for-3.8-drivers-drbd-8.4_ed6")
changes rb_augment_insert() to new augment API.  But the new API
rb_insert_augmented() requires the tree is augmennted before called.

Quote from Documentation/rbtree.txt:
"""
  On insertion, the user must update the augmented information on the path
  leading to the inserted node, then call rb_link_node() as usual and
  rb_augment_inserted() instead of the usual rb_insert_color() call.
  If rb_augment_inserted() rebalances the rbtree, it will callback into
  a user provided function to update the augmented information on the
  affected subtrees.
"""

So we add the augment-code to drbd_insert_interval() when it travels
the tree up to down before rb_insert_augmented().  See the example in
include/linux/interval_tree_generic.h or Documentation/rbtree.txt.

drbd_insert_interval() may cancel the insertion when traveling,
in this case, the just added augment-code does nothing before cancel
since the @this node is already in the subtrees in this case.

CC: Michel Lespinasse <walken@google.com>
Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
 drivers/block/drbd/drbd_interval.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

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
1.7.4.4

