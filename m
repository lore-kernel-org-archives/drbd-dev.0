Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 528EA1072302
	for <drbd-dev@lists.linbit.com>; Sat, 23 Jan 2010 19:13:20 +0100 (CET)
Resent-Message-ID: <20100123181320.GC11405@soda.linbit>
Date: Sat, 23 Jan 2010 15:45:22 +0300
From: Dan Carpenter <error27@gmail.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <20100123124522.GA3061@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com
Subject: [Drbd-dev] [patch] drbd: null dereference bug
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

epoch is always NULL here.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
This patch has only been compile tested.  Sorry.  :/

--- orig/drivers/block/drbd/drbd_receiver.c	2010-01-23 10:53:13.000000000 +0300
+++ devel/drivers/block/drbd/drbd_receiver.c	2010-01-23 10:54:19.000000000 +0300
@@ -1224,7 +1224,7 @@ static int receive_Barrier(struct drbd_c
 	epoch = kmalloc(sizeof(struct drbd_epoch), GFP_NOIO);
 	if (!epoch) {
 		dev_warn(DEV, "Allocation of an epoch failed, slowing down\n");
-		issue_flush = !test_and_set_bit(DE_BARRIER_IN_NEXT_EPOCH_ISSUED, &epoch->flags);
+		issue_flush = !test_and_set_bit(DE_BARRIER_IN_NEXT_EPOCH_ISSUED, &mdev->current_epoch->flags);
 		drbd_wait_ee_list_empty(mdev, &mdev->active_ee);
 		if (issue_flush) {
 			rv = drbd_flush_after_epoch(mdev, mdev->current_epoch);
