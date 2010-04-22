Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 22 Apr 2010 14:47:41 +0200
Message-Id: <1271940461-15012-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1271940461-15012-1-git-send-email-philipp.reisner@linbit.com>
References: <20100422122719.GH27497@kernel.dk>
	<1271940461-15012-1-git-send-email-philipp.reisner@linbit.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	kernel-janitors@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/1] drbd: Terminate a connection early if
	sending the protocol fails
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index ed9f1de..3f096e7 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -899,7 +899,8 @@ retry:
 
 	drbd_thread_start(&mdev->asender);
 
-	drbd_send_protocol(mdev);
+	if (!drbd_send_protocol(mdev))
+		return -1;
 	drbd_send_sync_param(mdev, &mdev->sync_conf);
 	drbd_send_sizes(mdev, 0);
 	drbd_send_uuids(mdev);
-- 
1.6.3.3

