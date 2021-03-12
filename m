Return-Path: <lee.jones@linaro.org>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6FCAC420231
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2021 11:55:37 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id b9so1523654wrt.8
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2021 02:55:37 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Date: Fri, 12 Mar 2021 10:55:21 +0000
Message-Id: <20210312105530.2219008-3-lee.jones@linaro.org>
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/11] block: drbd: drbd_interval: Demote some
	kernel-doc abuses and fix another header
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Fixes the following W=1 kernel build warning(s):

 drivers/block/drbd/drbd_interval.c:11: warning: Function parameter or member 'node' not described in 'interval_end'
 drivers/block/drbd/drbd_interval.c:26: warning: Function parameter or member 'root' not described in 'drbd_insert_interval'
 drivers/block/drbd/drbd_interval.c:26: warning: Function parameter or member 'this' not described in 'drbd_insert_interval'
 drivers/block/drbd/drbd_interval.c:70: warning: Function parameter or member 'root' not described in 'drbd_contains_interval'
 drivers/block/drbd/drbd_interval.c:96: warning: Function parameter or member 'root' not described in 'drbd_remove_interval'
 drivers/block/drbd/drbd_interval.c:96: warning: Function parameter or member 'this' not described in 'drbd_remove_interval'
 drivers/block/drbd/drbd_interval.c:113: warning: Function parameter or member 'root' not described in 'drbd_find_overlap'

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/drbd/drbd_interval.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index 651bd0236a996..f07b4378388b0 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -3,7 +3,7 @@
 #include <linux/rbtree_augmented.h>
 #include "drbd_interval.h"
 
-/**
+/*
  * interval_end  -  return end of @node
  */
 static inline
@@ -18,7 +18,7 @@ sector_t interval_end(struct rb_node *node)
 RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks,
 			 struct drbd_interval, rb, sector_t, end, NODE_END);
 
-/**
+/*
  * drbd_insert_interval  -  insert a new interval into a tree
  */
 bool
@@ -56,6 +56,7 @@ drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
 
 /**
  * drbd_contains_interval  -  check if a tree contains a given interval
+ * @root:	red black tree root
  * @sector:	start sector of @interval
  * @interval:	may not be a valid pointer
  *
@@ -88,7 +89,7 @@ drbd_contains_interval(struct rb_root *root, sector_t sector,
 	return false;
 }
 
-/**
+/*
  * drbd_remove_interval  -  remove an interval from a tree
  */
 void
@@ -99,6 +100,7 @@ drbd_remove_interval(struct rb_root *root, struct drbd_interval *this)
 
 /**
  * drbd_find_overlap  - search for an interval overlapping with [sector, sector + size)
+ * @root:	red black tree root
  * @sector:	start sector
  * @size:	size, aligned to 512 bytes
  *
-- 
2.27.0

