Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EE8B8101E048
	for <drbd-dev@lists.linbit.com>; Wed, 17 Sep 2014 16:22:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C91832A0948
	for <drbd-dev@lists.linbit.com>; Wed, 17 Sep 2014 16:22:19 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Hm2BOykQUi4V for <drbd-dev@lists.linbit.com>;
	Wed, 17 Sep 2014 16:22:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7979A2A78C7
	for <drbd-dev@lists.linbit.com>; Wed, 17 Sep 2014 16:22:19 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ng5k-2eguEh1 for <drbd-dev@lists.linbit.com>;
	Wed, 17 Sep 2014 16:22:19 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 3F04B2A0948
	for <drbd-dev@lists.linbit.com>; Wed, 17 Sep 2014 16:22:19 +0200 (CEST)
Resent-Message-ID: <20140917142218.GN13125@soda.linbit>
From: Lai Jiangshan <laijs@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>
Date: Wed, 17 Sep 2014 10:25:35 +0800
Message-ID: <1410920735-5767-3-git-send-email-laijs@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Michel Lespinasse <walken@google.com>, Lai Jiangshan <laijs@cn.fujitsu.com>,
	drbd-user@lists.linbit.com, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH] drbd: use RB_DECLARE_CALLBACKS() to define
	augment callbacks
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

The original code are the same as RB_DECLARE_CALLBACKS().

CC: Michel Lespinasse <walken@google.com>
Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
 drivers/block/drbd/drbd_interval.c |   36 ++----------------------------------
 1 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index 04a14e0..51b25ad 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -37,40 +37,8 @@ compute_subtree_last(struct drbd_interval *node)
 	return max;
 }
 
-static void augment_propagate(struct rb_node *rb, struct rb_node *stop)
-{
-	while (rb != stop) {
-		struct drbd_interval *node = rb_entry(rb, struct drbd_interval, rb);
-		sector_t subtree_last = compute_subtree_last(node);
-		if (node->end == subtree_last)
-			break;
-		node->end = subtree_last;
-		rb = rb_parent(&node->rb);
-	}
-}
-
-static void augment_copy(struct rb_node *rb_old, struct rb_node *rb_new)
-{
-	struct drbd_interval *old = rb_entry(rb_old, struct drbd_interval, rb);
-	struct drbd_interval *new = rb_entry(rb_new, struct drbd_interval, rb);
-
-	new->end = old->end;
-}
-
-static void augment_rotate(struct rb_node *rb_old, struct rb_node *rb_new)
-{
-	struct drbd_interval *old = rb_entry(rb_old, struct drbd_interval, rb);
-	struct drbd_interval *new = rb_entry(rb_new, struct drbd_interval, rb);
-
-	new->end = old->end;
-	old->end = compute_subtree_last(old);
-}
-
-static const struct rb_augment_callbacks augment_callbacks = {
-	augment_propagate,
-	augment_copy,
-	augment_rotate,
-};
+RB_DECLARE_CALLBACKS(static, augment_callbacks, struct drbd_interval, rb,
+		     sector_t, end, compute_subtree_last);
 
 /**
  * drbd_insert_interval  -  insert a new interval into a tree
-- 
1.7.4.4

