Return-Path: <BATV+3075c4dbfe213c24d6b2+7491+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E4376420641
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 12:44:32 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 05/16] md/raid0: use the atomic queue limit update APIs
Date: Mon, 26 Feb 2024 11:29:53 +0100
Message-Id: <20240226103004.281412-6-hch@lst.de>
In-Reply-To: <20240226103004.281412-1-hch@lst.de>
References: <20240226103004.281412-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, drbd-dev@lists.linbit.com
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

Build the queue limits outside the queue and apply them using
queue_limits_set.  Also remove the bogus ->gendisk and ->queue NULL
checks in the are while touching it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid0.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index c50a7abda744ad..dd070e9b2d5643 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -381,7 +381,8 @@ static void raid0_free(struct mddev *mddev, void *priv)
 
 static int raid0_run(struct mddev *mddev)
 {
-	struct r0conf *conf;
+	struct r0conf *conf = mddev->private;
+	struct queue_limits lim;
 	int ret;
 
 	if (mddev->chunk_sectors == 0) {
@@ -391,29 +392,23 @@ static int raid0_run(struct mddev *mddev)
 	if (md_check_no_bitmap(mddev))
 		return -EINVAL;
 
-	/* if private is not null, we are here after takeover */
-	if (mddev->private == NULL) {
+	/* if conf is not null, we are here after takeover */
+	if (!conf) {
 		ret = create_strip_zones(mddev, &conf);
 		if (ret < 0)
 			return ret;
 		mddev->private = conf;
 	}
-	conf = mddev->private;
-	if (mddev->queue) {
-		struct md_rdev *rdev;
-
-		blk_queue_max_hw_sectors(mddev->queue, mddev->chunk_sectors);
-		blk_queue_max_write_zeroes_sectors(mddev->queue, mddev->chunk_sectors);
 
-		blk_queue_io_min(mddev->queue, mddev->chunk_sectors << 9);
-		blk_queue_io_opt(mddev->queue,
-				 (mddev->chunk_sectors << 9) * mddev->raid_disks);
-
-		rdev_for_each(rdev, mddev) {
-			disk_stack_limits(mddev->gendisk, rdev->bdev,
-					  rdev->data_offset << 9);
-		}
-	}
+	blk_set_stacking_limits(&lim);
+	lim.max_hw_sectors = mddev->chunk_sectors;
+	lim.max_write_zeroes_sectors = mddev->chunk_sectors;
+	lim.io_min = mddev->chunk_sectors << 9;
+	lim.io_opt = lim.io_min * mddev->raid_disks;
+	mddev_stack_rdev_limits(mddev, &lim);
+	ret = queue_limits_set(mddev->queue, &lim);
+	if (ret)
+		goto out_free_conf;
 
 	/* calculate array device size */
 	md_set_array_sectors(mddev, raid0_size(mddev, 0, 0));
@@ -426,8 +421,10 @@ static int raid0_run(struct mddev *mddev)
 
 	ret = md_integrity_register(mddev);
 	if (ret)
-		free_conf(mddev, conf);
-
+		goto out_free_conf;
+	return 0;
+out_free_conf:
+	free_conf(mddev, conf);
 	return ret;
 }
 
-- 
2.39.2

