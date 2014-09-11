Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3597D101E06B
	for <drbd-dev@lists.linbit.com>; Thu, 11 Sep 2014 14:29:15 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Thu, 11 Sep 2014 14:29:07 +0200
Message-Id: <1410438553-30440-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
References: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/9] drbd: Remove superfluous newline from
	"resync_extents" debugfs entry.
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

From: Philipp Marek <philipp.marek@linbit.com>

See "drbd/resources/*/volumes/*/resync_extents".

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 5c20b18..900d4d3 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -695,7 +695,7 @@ static void resync_dump_detail(struct seq_file *m, struct lc_element *e)
 {
        struct bm_extent *bme = lc_entry(e, struct bm_extent, lce);
 
-       seq_printf(m, "%5d %s %s %s\n", bme->rs_left,
+       seq_printf(m, "%5d %s %s %s", bme->rs_left,
 		  test_bit(BME_NO_WRITES, &bme->flags) ? "NO_WRITES" : "---------",
 		  test_bit(BME_LOCKED, &bme->flags) ? "LOCKED" : "------",
 		  test_bit(BME_PRIORITY, &bme->flags) ? "PRIORITY" : "--------"
-- 
1.9.1

