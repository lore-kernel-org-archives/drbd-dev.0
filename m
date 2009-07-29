Return-Path: <sfr@canb.auug.org.au>
Resent-Message-ID: <200907290956.05293.sfr@canb.auug.org.au>
Date: Wed, 29 Jul 2009 15:29:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-Id: <20090729152938.791a81c3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, Petersen <martin.petersen@oracle.com>, Martin
Subject: [Drbd-dev] linux-next: drbd tree build failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Philipp,

Today's linux-next build (x86_64 allmodconfig) failed like this:

drivers/block/drbd/drbd_nl.c: In function 'drbd_setup_queue_param':
drivers/block/drbd/drbd_nl.c:707: error: implicit declaration of function 'blk_queue_stack_limits'

Caused by commit 6dc986e736ca1e76a45d025a920f3a66855fc2aa ("block:
Deprecate blk_queue_stack_limits") from the block tree.

I have applied the following patch for today.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 29 Jul 2009 15:25:23 +1000
Subject: [PATCH] drbd: fix for removal of blk_queue_stack_limits

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/block/drbd/drbd_nl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 1e87ad0..0ec86e8 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -704,7 +704,7 @@ void drbd_setup_queue_param(struct drbd_conf *mdev, unsigned int max_seg_s) __mu
 	blk_queue_max_segment_size(q, max_seg_s);
 	blk_queue_logical_block_size(q, 512);
 	blk_queue_segment_boundary(q, PAGE_SIZE-1);
-	blk_queue_stack_limits(q, b);
+	blk_stack_limits(&q->limits, &b->limits, 0);
 
 	if (b->merge_bvec_fn)
 		dev_warn(DEV, "Backing device's merge_bvec_fn() = %p\n",
-- 
1.6.3.3

