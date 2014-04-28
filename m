Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:16 +0200
Message-Id: <1398703415-17780-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/24] drbd: fix stalled resync detection in
	/proc/drbd
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

If we don't make resync or verify progress for "too long",
we want to flag it as "stalled".

Since 2010, "use rolling marks for resync speed calculation"
this "too long" was wrong by a factor of HZ.
With HZ 250, it would have been flagged as stalled
after 100 minutes.

Hardcode 3 minutes instead.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 2f26e8f..89736bd 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -116,7 +116,7 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 	/* ------------------------ ~18s average ------------------------ */
 	i = (device->rs_last_mark + 2) % DRBD_SYNC_MARKS;
 	dt = (jiffies - device->rs_mark_time[i]) / HZ;
-	if (dt > (DRBD_SYNC_MARK_STEP * DRBD_SYNC_MARKS))
+	if (dt > 180)
 		stalled = 1;
 
 	if (!dt)
-- 
1.9.1

