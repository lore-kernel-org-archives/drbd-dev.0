Return-Path: <BATV+3075c4dbfe213c24d6b2+7491+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E45D34205D4
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 12:34:37 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 08/16] md/raid5: use the atomic queue limit update APIs
Date: Mon, 26 Feb 2024 11:29:56 +0100
Message-Id: <20240226103004.281412-9-hch@lst.de>
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
 drivers/md/raid5.c | 123 +++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 67 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 14f2cf75abbd72..3dd7c05d3ba2ab 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7682,12 +7682,6 @@ static int only_parity(int raid_disk, int algo, int raid_disks, int max_degraded
 	return 0;
 }
 
-static void raid5_set_io_opt(struct r5conf *conf)
-{
-	blk_queue_io_opt(conf->mddev->queue, (conf->chunk_sectors << 9) *
-			 (conf->raid_disks - conf->max_degraded));
-}
-
 static int raid5_run(struct mddev *mddev)
 {
 	struct r5conf *conf;
@@ -7695,9 +7689,12 @@ static int raid5_run(struct mddev *mddev)
 	struct md_rdev *rdev;
 	struct md_rdev *journal_dev = NULL;
 	sector_t reshape_offset = 0;
+	struct queue_limits lim;
 	int i;
 	long long min_offset_diff = 0;
 	int first = 1;
+	int data_disks, stripe;
+	int ret = -EIO;
 
 	if (mddev->recovery_cp != MaxSector)
 		pr_notice("md/raid:%s: not clean -- starting background reconstruction\n",
@@ -7950,67 +7947,59 @@ static int raid5_run(struct mddev *mddev)
 			mdname(mddev));
 	md_set_array_sectors(mddev, raid5_size(mddev, 0, 0));
 
-	if (mddev->queue) {
-		int chunk_size;
-		/* read-ahead size must cover two whole stripes, which
-		 * is 2 * (datadisks) * chunksize where 'n' is the
-		 * number of raid devices
-		 */
-		int data_disks = conf->previous_raid_disks - conf->max_degraded;
-		int stripe = data_disks *
-			((mddev->chunk_sectors << 9) / PAGE_SIZE);
-
-		chunk_size = mddev->chunk_sectors << 9;
-		blk_queue_io_min(mddev->queue, chunk_size);
-		raid5_set_io_opt(conf);
-		mddev->queue->limits.raid_partial_stripes_expensive = 1;
-		/*
-		 * We can only discard a whole stripe. It doesn't make sense to
-		 * discard data disk but write parity disk
-		 */
-		stripe = stripe * PAGE_SIZE;
-		stripe = roundup_pow_of_two(stripe);
-		mddev->queue->limits.discard_granularity = stripe;
-
-		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
-
-		rdev_for_each(rdev, mddev) {
-			disk_stack_limits(mddev->gendisk, rdev->bdev,
-					  rdev->data_offset << 9);
-			disk_stack_limits(mddev->gendisk, rdev->bdev,
-					  rdev->new_data_offset << 9);
-		}
+	/*
+	 * The read-ahead size must cover two whole stripes, which is
+	 * 2 * (datadisks) * chunksize where 'n' is the number of raid devices.
+	 */
+	data_disks = conf->previous_raid_disks - conf->max_degraded;
+	/*
+	 * We can only discard a whole stripe. It doesn't make sense to
+	 * discard data disk but write parity disk
+	 */
+	stripe = roundup_pow_of_two(data_disks * (mddev->chunk_sectors << 9));
+
+	blk_set_stacking_limits(&lim);
+	lim.io_min = mddev->chunk_sectors << 9;
+	lim.io_opt = lim.io_min * (conf->raid_disks - conf->max_degraded);
+	lim.raid_partial_stripes_expensive = 1;
+	lim.discard_granularity = stripe;
+	lim.max_write_zeroes_sectors = 0;
+	mddev_stack_rdev_limits(mddev, &lim);
+	rdev_for_each(rdev, mddev) {
+		queue_limits_stack_bdev(&lim, rdev->bdev, rdev->new_data_offset,
+	                         mddev->gendisk->disk_name);
+	}
 
-		/*
-		 * zeroing is required, otherwise data
-		 * could be lost. Consider a scenario: discard a stripe
-		 * (the stripe could be inconsistent if
-		 * discard_zeroes_data is 0); write one disk of the
-		 * stripe (the stripe could be inconsistent again
-		 * depending on which disks are used to calculate
-		 * parity); the disk is broken; The stripe data of this
-		 * disk is lost.
-		 *
-		 * We only allow DISCARD if the sysadmin has confirmed that
-		 * only safe devices are in use by setting a module parameter.
-		 * A better idea might be to turn DISCARD into WRITE_ZEROES
-		 * requests, as that is required to be safe.
-		 */
-		if (!devices_handle_discard_safely ||
-		    mddev->queue->limits.max_discard_sectors < (stripe >> 9) ||
-		    mddev->queue->limits.discard_granularity < stripe)
-			blk_queue_max_discard_sectors(mddev->queue, 0);
+	/*
+	 * Zeroing is required for discard, otherwise data could be lost.
+	 *
+	 * Consider a scenario: discard a stripe (the stripe could be
+	 * inconsistent if discard_zeroes_data is 0); write one disk of the
+	 * stripe (the stripe could be inconsistent again depending on which
+	 * disks are used to calculate parity); the disk is broken; The stripe
+	 * data of this disk is lost.
+	 *
+	 * We only allow DISCARD if the sysadmin has confirmed that only safe
+	 * devices are in use by setting a module parameter.  A better idea
+	 * might be to turn DISCARD into WRITE_ZEROES requests, as that is
+	 * required to be safe.
+	 */
+	if (!devices_handle_discard_safely ||
+	    lim.max_discard_sectors < (stripe >> 9) ||
+	    lim.discard_granularity < stripe)
+		lim.max_hw_discard_sectors = 0;
 
-		/*
-		 * Requests require having a bitmap for each stripe.
-		 * Limit the max sectors based on this.
-		 */
-		blk_queue_max_hw_sectors(mddev->queue,
-			RAID5_MAX_REQ_STRIPES << RAID5_STRIPE_SHIFT(conf));
+	/*
+	 * Requests require having a bitmap for each stripe.
+	 * Limit the max sectors based on this.
+	 */
+	lim.max_hw_sectors = RAID5_MAX_REQ_STRIPES << RAID5_STRIPE_SHIFT(conf);
 
-		/* No restrictions on the number of segments in the request */
-		blk_queue_max_segments(mddev->queue, USHRT_MAX);
-	}
+	/* No restrictions on the number of segments in the request */
+	lim.max_segments = USHRT_MAX;
+	ret = queue_limits_set(mddev->queue, &lim);
+	if (ret)
+		goto abort;
 
 	if (log_init(conf, journal_dev, raid5_has_ppl(conf)))
 		goto abort;
@@ -8022,7 +8011,7 @@ static int raid5_run(struct mddev *mddev)
 	free_conf(conf);
 	mddev->private = NULL;
 	pr_warn("md/raid:%s: failed to run raid set.\n", mdname(mddev));
-	return -EIO;
+	return ret;
 }
 
 static void raid5_free(struct mddev *mddev, void *priv)
@@ -8554,8 +8543,8 @@ static void end_reshape(struct r5conf *conf)
 		spin_unlock_irq(&conf->device_lock);
 		wake_up(&conf->wait_for_overlap);
 
-		if (conf->mddev->queue)
-			raid5_set_io_opt(conf);
+		mddev_update_io_opt(conf->mddev,
+			conf->raid_disks - conf->max_degraded);
 	}
 }
 
-- 
2.39.2

