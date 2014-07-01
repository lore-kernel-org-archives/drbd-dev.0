Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AFD4F101AC7A
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jul 2014 18:16:50 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  1 Jul 2014 18:16:31 +0200
Message-Id: <1404231410-29852-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
References: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/20] drbd: drop wrong debugging aid
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

The textual representation of resync extents in /proc/drbd presented
with proc_details >= 3 was wrong, it used bitnumbers as bitmasks.

It was not particularly useful either, and I doubt anyone has even tried
to look at it in the last few years. Drop it.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_proc.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index f11e573..46bb8dd 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -188,16 +188,6 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 	}
 }
 
-static void resync_dump_detail(struct seq_file *seq, struct lc_element *e)
-{
-	struct bm_extent *bme = lc_entry(e, struct bm_extent, lce);
-
-	seq_printf(seq, "%5d %s %s\n", bme->rs_left,
-		   bme->flags & BME_NO_WRITES ? "NO_WRITES" : "---------",
-		   bme->flags & BME_LOCKED ? "LOCKED" : "------"
-		   );
-}
-
 static int drbd_seq_show(struct seq_file *seq, void *v)
 {
 	int i, prev_i = -1;
@@ -298,13 +288,6 @@ static int drbd_seq_show(struct seq_file *seq, void *v)
 			lc_seq_printf_stats(seq, device->act_log);
 			put_ldev(device);
 		}
-
-		if (proc_details >= 2) {
-			if (device->resync) {
-				lc_seq_dump_details(seq, device->resync, "rs_left",
-					resync_dump_detail);
-			}
-		}
 	}
 	rcu_read_unlock();
 
-- 
1.9.1

