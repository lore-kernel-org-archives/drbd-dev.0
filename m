Return-Path: <wangborong@cdjrlc.com>
Received: from smtpbg.qq.com (biz-43-154-221-58.mail.qq.com [43.154.221.58])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 54EAA4202B8
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jul 2022 14:24:07 +0200 (CEST)
From: Jason Wang <wangborong@cdjrlc.com>
To: axboe@kernel.dk
Date: Sat, 16 Jul 2022 12:14:34 +0800
Message-Id: <20220716041434.33148-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: philipp.reisner@linbit.com, Jason Wang <wangborong@cdjrlc.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] block/drbd: Fix comment typo
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

The double `and' is duplicated in line 89, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/block/drbd/drbd_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 7d9db33363de..736416186c2f 100644
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
2.35.1

