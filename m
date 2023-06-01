Return-Path: <BATV+afcc791b37732e68e234+7221+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2378542036A
	for <drbd-dev@lists.linbit.com>; Thu,  1 Jun 2023 17:18:59 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com
Date: Thu,  1 Jun 2023 17:16:46 +0200
Message-Id: <20230601151646.1386867-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: stop defining __KERNEL_SYSCALLS__
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

__KERNEL_SYSCALLS__ hasn't been needed since Linux 2.6.19 so stop
defining it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_main.c     | 1 -
 drivers/block/drbd/drbd_receiver.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 83987e7a5ef275..54223f64610a05 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -37,7 +37,6 @@
 #include <linux/notifier.h>
 #include <linux/kthread.h>
 #include <linux/workqueue.h>
-#define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/signal.h>
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 8c2bc47de4735e..0c9f54197768d6 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -27,7 +27,6 @@
 #include <uapi/linux/sched/types.h>
 #include <linux/sched/signal.h>
 #include <linux/pkt_sched.h>
-#define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
 #include <linux/vmalloc.h>
 #include <linux/random.h>
-- 
2.39.2

