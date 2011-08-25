Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:45 +0200
Message-Id: <1314284934-17999-50-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 049/118] drbd: Remove redundant check from
	drbd_contains_interval()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_interval.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index b77a9bd..0d17eaa 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -99,7 +99,7 @@ drbd_contains_interval(struct rb_root *root, sector_t sector,
 		else if (interval > here)
 			node = node->rb_right;
 		else
-			return interval->sector == sector;
+			return true;
 	}
 	return false;
 }
-- 
1.7.4.1

