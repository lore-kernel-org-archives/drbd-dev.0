Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 14B38101AC7F
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 10:43:17 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  3 Jul 2014 10:43:15 +0200
Message-Id: <1404376995-4877-24-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404376995-4877-1-git-send-email-philipp.reisner@linbit.com>
References: <1404376995-4877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 23/23] drbd: silence underflow warning in
	read_in_block()
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

From: Dan Carpenter <dan.carpenter@oracle.com>

My static checker warns that "data_size" could be negative and underflow
the limit check.  The code looks suspicious but I don't know if it is a
real bug.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 include/linux/drbd.h               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index f972988..9342b8d 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1592,7 +1592,7 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 	struct drbd_peer_request *peer_req;
 	struct page *page;
 	int dgs, ds, err;
-	int data_size = pi->size;
+	unsigned int data_size = pi->size;
 	void *dig_in = peer_device->connection->int_dig_in;
 	void *dig_vv = peer_device->connection->int_dig_vv;
 	unsigned long *data;
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 20ec890..debb70d 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -52,7 +52,7 @@
 #endif
 
 extern const char *drbd_buildtag(void);
-#define REL_VERSION "8.4.3"
+#define REL_VERSION "8.4.5"
 #define API_VERSION 1
 #define PRO_VERSION_MIN 86
 #define PRO_VERSION_MAX 101
-- 
1.9.1

