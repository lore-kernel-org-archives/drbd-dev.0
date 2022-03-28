Return-Path: <baihaowen@meizu.com>
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8158E42034F
	for <drbd-dev@lists.linbit.com>; Mon, 28 Mar 2022 04:59:29 +0200 (CEST)
From: Haowen Bai <baihaowen@meizu.com>
To: <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
	<axboe@kernel.dk>
Date: Mon, 28 Mar 2022 10:54:09 +0800
Message-ID: <1648436049-4335-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-block@vger.kernel.org, Haowen Bai <baihaowen@meizu.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: Return true/false (not 1/0) from bool
	functions
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

Return boolean values ("true" or "false") instead of 1 or 0 from bool
functions.  This fixes the following warnings from coccicheck:

./drivers/block/drbd/drbd_req.c:912:9-10: WARNING: return of 0/1 in
function 'remote_due_to_read_balancing' with return type bool

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/block/drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index c043945..171905a 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -909,7 +909,7 @@ static bool remote_due_to_read_balancing(struct drbd_device *device, sector_t se
 
 	switch (rbm) {
 	case RB_CONGESTED_REMOTE:
-		return 0;
+		return false;
 	case RB_LEAST_PENDING:
 		return atomic_read(&device->local_cnt) >
 			atomic_read(&device->ap_pending_cnt) + atomic_read(&device->rs_pending_cnt);
-- 
2.7.4

