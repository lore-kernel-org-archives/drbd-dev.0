Return-Path: <BATV+b7a2078c382f6036dc0e+6365+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 24C5A420640
	for <drbd-dev@lists.linbit.com>; Tue, 26 Jan 2021 16:23:23 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>
Date: Tue, 26 Jan 2021 15:52:44 +0100
Message-Id: <20210126145247.1964410-15-hch@lst.de>
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>, linux-mm@kvack.org, dm-devel@redhat.com,
	drbd-dev@lists.linbit.com, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-nilfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Chao Yu <chao@kernel.org>, linux-nfs@vger.kernel.org,
	Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, linux-block@vger.kernel.org,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, linux-btrfs@vger.kernel.org
Subject: [Drbd-dev] [PATCH 14/17] md/raid6: refactor raid5_read_one_chunk
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

Refactor raid5_read_one_chunk so that all simple checks are done
before allocating the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5.c | 108 +++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 63 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f411b9e5c332f4..a348b2adf2a9f9 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5393,90 +5393,72 @@ static void raid5_align_endio(struct bio *bi)
 static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 {
 	struct r5conf *conf = mddev->private;
-	int dd_idx;
-	struct bio* align_bi;
+	struct bio *align_bio;
 	struct md_rdev *rdev;
-	sector_t end_sector;
+	sector_t sector, end_sector, first_bad;
+	int bad_sectors, dd_idx;
 
 	if (!in_chunk_boundary(mddev, raid_bio)) {
 		pr_debug("%s: non aligned\n", __func__);
 		return 0;
 	}
-	/*
-	 * use bio_clone_fast to make a copy of the bio
-	 */
-	align_bi = bio_clone_fast(raid_bio, GFP_NOIO, &mddev->bio_set);
-	if (!align_bi)
-		return 0;
-	/*
-	 *   set bi_end_io to a new function, and set bi_private to the
-	 *     original bio.
-	 */
-	align_bi->bi_end_io  = raid5_align_endio;
-	align_bi->bi_private = raid_bio;
-	/*
-	 *	compute position
-	 */
-	align_bi->bi_iter.bi_sector =
-		raid5_compute_sector(conf, raid_bio->bi_iter.bi_sector,
-				     0, &dd_idx, NULL);
 
-	end_sector = bio_end_sector(align_bi);
+	sector = raid5_compute_sector(conf, raid_bio->bi_iter.bi_sector, 0,
+				      &dd_idx, NULL);
+	end_sector = bio_end_sector(raid_bio);
+
 	rcu_read_lock();
+	if (r5c_big_stripe_cached(conf, sector))
+		goto out_rcu_unlock;
+
 	rdev = rcu_dereference(conf->disks[dd_idx].replacement);
 	if (!rdev || test_bit(Faulty, &rdev->flags) ||
 	    rdev->recovery_offset < end_sector) {
 		rdev = rcu_dereference(conf->disks[dd_idx].rdev);
-		if (rdev &&
-		    (test_bit(Faulty, &rdev->flags) ||
+		if (!rdev)
+			goto out_rcu_unlock;
+		if (test_bit(Faulty, &rdev->flags) ||
 		    !(test_bit(In_sync, &rdev->flags) ||
-		      rdev->recovery_offset >= end_sector)))
-			rdev = NULL;
+		      rdev->recovery_offset >= end_sector))
+			goto out_rcu_unlock;
 	}
 
-	if (r5c_big_stripe_cached(conf, align_bi->bi_iter.bi_sector)) {
-		rcu_read_unlock();
-		bio_put(align_bi);
+	atomic_inc(&rdev->nr_pending);
+	rcu_read_unlock();
+
+	align_bio = bio_clone_fast(raid_bio, GFP_NOIO, &mddev->bio_set);
+	bio_set_dev(align_bio, rdev->bdev);
+	align_bio->bi_end_io = raid5_align_endio;
+	align_bio->bi_private = raid_bio;
+	align_bio->bi_iter.bi_sector = sector;
+
+	raid_bio->bi_next = (void *)rdev;
+
+	if (is_badblock(rdev, sector, bio_sectors(align_bio), &first_bad,
+			&bad_sectors)) {
+		bio_put(align_bio);
+		rdev_dec_pending(rdev, mddev);
 		return 0;
 	}
 
-	if (rdev) {
-		sector_t first_bad;
-		int bad_sectors;
-
-		atomic_inc(&rdev->nr_pending);
-		rcu_read_unlock();
-		raid_bio->bi_next = (void*)rdev;
-		bio_set_dev(align_bi, rdev->bdev);
-
-		if (is_badblock(rdev, align_bi->bi_iter.bi_sector,
-				bio_sectors(align_bi),
-				&first_bad, &bad_sectors)) {
-			bio_put(align_bi);
-			rdev_dec_pending(rdev, mddev);
-			return 0;
-		}
+	/* No reshape active, so we can trust rdev->data_offset */
+	align_bio->bi_iter.bi_sector += rdev->data_offset;
 
-		/* No reshape active, so we can trust rdev->data_offset */
-		align_bi->bi_iter.bi_sector += rdev->data_offset;
+	spin_lock_irq(&conf->device_lock);
+	wait_event_lock_irq(conf->wait_for_quiescent, conf->quiesce == 0,
+			    conf->device_lock);
+	atomic_inc(&conf->active_aligned_reads);
+	spin_unlock_irq(&conf->device_lock);
 
-		spin_lock_irq(&conf->device_lock);
-		wait_event_lock_irq(conf->wait_for_quiescent,
-				    conf->quiesce == 0,
-				    conf->device_lock);
-		atomic_inc(&conf->active_aligned_reads);
-		spin_unlock_irq(&conf->device_lock);
+	if (mddev->gendisk)
+		trace_block_bio_remap(align_bio, disk_devt(mddev->gendisk),
+				      raid_bio->bi_iter.bi_sector);
+	submit_bio_noacct(align_bio);
+	return 1;
 
-		if (mddev->gendisk)
-			trace_block_bio_remap(align_bi, disk_devt(mddev->gendisk),
-					      raid_bio->bi_iter.bi_sector);
-		submit_bio_noacct(align_bi);
-		return 1;
-	} else {
-		rcu_read_unlock();
-		bio_put(align_bi);
-		return 0;
-	}
+out_rcu_unlock:
+	rcu_read_unlock();
+	return 0;
 }
 
 static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
-- 
2.29.2

