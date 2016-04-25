Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CEE01105645C
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:28 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:47 +0200
Message-Id: <1461586077-11581-21-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 20/30] drbd: discard_zeroes_if_aligned allows
	"thin" resync for discard_zeroes_data=0
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

From: Lars Ellenberg <lars@linbit.com>

Even if discard_zeroes_data != 0,
if discard_zeroes_if_aligned is set, we assume we can reliably
zero-out/discard using the drbd_issue_peer_discard() helper.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a703a0e..48fa6c3 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1408,9 +1408,12 @@ static void sanitize_disk_conf(struct drbd_device *device, struct disk_conf *dis
 	if (disk_conf->al_extents > drbd_al_extents_max(nbc))
 		disk_conf->al_extents = drbd_al_extents_max(nbc);
 
-	if (!blk_queue_discard(q) || !q->limits.discard_zeroes_data) {
-		disk_conf->rs_discard_granularity = 0; /* disable feature */
-		drbd_info(device, "rs_discard_granularity feature disabled\n");
+	if (!blk_queue_discard(q)
+	    || (!q->limits.discard_zeroes_data && !disk_conf->discard_zeroes_if_aligned)) {
+		if (disk_conf->rs_discard_granularity) {
+			disk_conf->rs_discard_granularity = 0; /* disable feature */
+			drbd_info(device, "rs_discard_granularity feature disabled\n");
+		}
 	}
 
 	if (disk_conf->rs_discard_granularity) {
-- 
1.9.1

