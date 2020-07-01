Return-Path: <BATV+501e1de201b53739768b+6156+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0D64D4203F1
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jul 2020 11:24:02 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  1 Jul 2020 11:06:20 +0200
Message-Id: <20200701090622.3354860-3-hch@lst.de>
In-Reply-To: <20200701090622.3354860-1-hch@lst.de>
References: <20200701090622.3354860-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, dm-devel@redhat.com,
	Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/4] writeback: remove {set,clear}_wb_congested
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

Just merge them into their only callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/backing-dev-defs.h | 14 ++------------
 mm/backing-dev.c                 | 12 ++++++------
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 90a7e844a098f3..cc5aa1f32b91f0 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -232,18 +232,8 @@ enum {
 	BLK_RW_SYNC	= 1,
 };
 
-void clear_wb_congested(struct bdi_writeback_congested *congested, int sync);
-void set_wb_congested(struct bdi_writeback_congested *congested, int sync);
-
-static inline void clear_bdi_congested(struct backing_dev_info *bdi, int sync)
-{
-	clear_wb_congested(bdi->wb.congested, sync);
-}
-
-static inline void set_bdi_congested(struct backing_dev_info *bdi, int sync)
-{
-	set_wb_congested(bdi->wb.congested, sync);
-}
+void clear_bdi_congested(struct backing_dev_info *bdi, int sync);
+void set_bdi_congested(struct backing_dev_info *bdi, int sync);
 
 struct wb_lock_cookie {
 	bool locked;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index d382272bcc3100..3ebe5144a102f2 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1047,29 +1047,29 @@ static wait_queue_head_t congestion_wqh[2] = {
 	};
 static atomic_t nr_wb_congested[2];
 
-void clear_wb_congested(struct bdi_writeback_congested *congested, int sync)
+void clear_bdi_congested(struct backing_dev_info *bdi, int sync)
 {
 	wait_queue_head_t *wqh = &congestion_wqh[sync];
 	enum wb_congested_state bit;
 
 	bit = sync ? WB_sync_congested : WB_async_congested;
-	if (test_and_clear_bit(bit, &congested->state))
+	if (test_and_clear_bit(bit, &bdi->wb.congested->state))
 		atomic_dec(&nr_wb_congested[sync]);
 	smp_mb__after_atomic();
 	if (waitqueue_active(wqh))
 		wake_up(wqh);
 }
-EXPORT_SYMBOL(clear_wb_congested);
+EXPORT_SYMBOL(clear_bdi_congested);
 
-void set_wb_congested(struct bdi_writeback_congested *congested, int sync)
+void set_bdi_congested(struct backing_dev_info *bdi, int sync)
 {
 	enum wb_congested_state bit;
 
 	bit = sync ? WB_sync_congested : WB_async_congested;
-	if (!test_and_set_bit(bit, &congested->state))
+	if (!test_and_set_bit(bit, &bdi->wb.congested->state))
 		atomic_inc(&nr_wb_congested[sync]);
 }
-EXPORT_SYMBOL(set_wb_congested);
+EXPORT_SYMBOL(set_bdi_congested);
 
 /**
  * congestion_wait - wait for a backing_dev to become uncongested
-- 
2.26.2

