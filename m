Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed,  5 Oct 2011 11:37:53 +0200
Message-Id: <1317807484-24628-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317807484-24628-1-git-send-email-philipp.reisner@linbit.com>
References: <1317807484-24628-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/16] drbd: fix copy/paste error in comment
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 50b851e..933404e 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -307,7 +307,7 @@ static unsigned int rs_extent_to_bm_page(unsigned int rs_enr)
 	return rs_enr >>
 		/* bit to page */
 		((PAGE_SHIFT + 3) -
-		/* al extent number to bit */
+		/* resync extent number to bit */
 		 (BM_EXT_SHIFT - BM_BLOCK_SHIFT));
 }
 
-- 
1.7.4.1

