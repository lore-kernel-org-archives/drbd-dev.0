Return-Path: <wangxiang@cdjrlc.com>
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 870E14201D9
	for <drbd-dev@lists.linbit.com>; Thu, 16 Jun 2022 16:42:11 +0200 (CEST)
From: Xiang wangx <wangxiang@cdjrlc.com>
To: axboe@kernel.dk
Date: Thu, 16 Jun 2022 22:32:27 +0800
Message-Id: <20220616143227.4004-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Xiang wangx <wangxiang@cdjrlc.com>, philipp.reisner@linbit.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: Fix typo in comment
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

Delete the redundant word 'and'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/block/drbd/drbd_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 9e060e49b3f8..8afdde400e37 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -86,7 +86,7 @@ struct drbd_bitmap {
 
 	/* exclusively to be used by __al_write_transaction(),
 	 * drbd_bm_mark_for_writeout() and
-	 * and drbd_bm_write_hinted() -> bm_rw() called from there.
+	 * drbd_bm_write_hinted() -> bm_rw() called from there.
 	 */
 	unsigned int n_bitmap_hints;
 	unsigned int al_bitmap_hints[AL_UPDATES_PER_TRANSACTION];
-- 
2.36.1

