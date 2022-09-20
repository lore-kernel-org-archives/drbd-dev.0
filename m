Return-Path: <cuigaosheng1@huawei.com>
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 930F84203D5
	for <drbd-dev@lists.linbit.com>;
	Tue, 20 Sep 2022 03:52:19 +0200 (CEST)
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
	<christoph.boehmwalder@linbit.com>, <axboe@kernel.dk>,
	<cuigaosheng1@huawei.com>
Date: Tue, 20 Sep 2022 09:52:15 +0800
Message-ID: <20220920015216.782190-2-cuigaosheng1@huawei.com>
In-Reply-To: <20220920015216.782190-1-cuigaosheng1@huawei.com>
References: <20220920015216.782190-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: linux-block@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/2] drbd: remove orphan _req_may_be_done()
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

The _req_may_be_done() has been removed by
commit 6870ca6d463e ("drbd: factor out master_bio completion
and drbd_request destruction paths"), so remove the orphan
declaration.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/block/drbd/drbd_req.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index 511f39a08de4..6237fa1dcb0e 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -266,8 +266,6 @@ struct bio_and_error {
 
 extern void start_new_tl_epoch(struct drbd_connection *connection);
 extern void drbd_req_destroy(struct kref *kref);
-extern void _req_may_be_done(struct drbd_request *req,
-		struct bio_and_error *m);
 extern int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		struct bio_and_error *m);
 extern void complete_master_bio(struct drbd_device *device,
-- 
2.25.1

