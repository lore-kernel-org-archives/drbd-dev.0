Return-Path: <cuigaosheng1@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CE36E420311
	for <drbd-dev@lists.linbit.com>;
	Sun, 11 Sep 2022 11:44:42 +0200 (CEST)
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
	<christoph.boehmwalder@linbit.com>, <axboe@kernel.dk>,
	<cuigaosheng1@huawei.com>
Date: Sun, 11 Sep 2022 17:26:45 +0800
Message-ID: <20220911092645.3218009-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] block/drbd: remove unused w_start_resync
	declaration
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

w_start_resync has been removed since
commit ac0acb9e39ac ("drbd: use drbd_device_post_work()
in more places"), so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/block/drbd/drbd_int.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f15f2f041596..4d661282ff41 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1529,7 +1529,6 @@ extern int w_send_read_req(struct drbd_work *, int);
 extern int w_e_reissue(struct drbd_work *, int);
 extern int w_restart_disk_io(struct drbd_work *, int);
 extern int w_send_out_of_sync(struct drbd_work *, int);
-extern int w_start_resync(struct drbd_work *, int);
 
 extern void resync_timer_fn(struct timer_list *t);
 extern void start_resync_timer_fn(struct timer_list *t);
-- 
2.25.1

