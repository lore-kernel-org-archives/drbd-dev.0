Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 28A14105EC2D
	for <drbd-dev@lists.linbit.com>; Sun, 23 May 2010 22:13:54 +0200 (CEST)
Resent-Message-ID: <20100523201353.GI14070@soda.linbit>
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Date: Sun, 23 May 2010 21:48:13 +0200
Message-Id: <1274644094-23226-1-git-send-email-andrea.gelmini@gelma.net>
Cc: Jens Axboe <jens.axboe@oracle.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 2/4] drivers/block/drbd: removed duplicated
	#includes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

drivers/block/drbd/drbd_receiver.c: linux/mm.h is included more than once.

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 drivers/block/drbd/drbd_receiver.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index bc9ab7f..185618f 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -32,7 +32,6 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/in.h>
-#include <linux/mm.h>
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/slab.h>
-- 
1.7.1.251.gf80a2

