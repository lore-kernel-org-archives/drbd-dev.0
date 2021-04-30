Return-Path: <jiapeng.chong@linux.alibaba.com>
Received: from out30-57.freemail.mail.aliyun.com
	(out30-57.freemail.mail.aliyun.com [115.124.30.57])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 584BF420379
	for <drbd-dev@lists.linbit.com>; Fri, 30 Apr 2021 11:26:09 +0200 (CEST)
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: philipp.reisner@linbit.com
Date: Fri, 30 Apr 2021 17:20:56 +0800
Message-Id: <1619774456-116567-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Cc: axboe@kernel.dk, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] block: drbd: drbd_receiver: Remove redundant
	assignment to err
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

Variable err is set to '-EIO' but this value is never read as
it is overwritten or not used later on, hence it is a redundant
assignment and can be removed.

Clean up the following clang-analyzer warning:

drivers/block/drbd/drbd_receiver.c:3955:5: warning: Value stored to
'err' is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/block/drbd/drbd_receiver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 69284eb..e3b1e87 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3952,7 +3952,6 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 				drbd_err(device, "verify-alg of wrong size, "
 					"peer wants %u, accepting only up to %u byte\n",
 					data_size, SHARED_SECRET_MAX);
-				err = -EIO;
 				goto reconnect;
 			}
 
-- 
1.8.3.1

