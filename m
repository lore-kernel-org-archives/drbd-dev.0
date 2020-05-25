Return-Path: <BATV+ab9bb8b38cf50d3a9241+6119+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AD94D42033E
	for <drbd-dev@lists.linbit.com>; Mon, 25 May 2020 13:30:49 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 25 May 2020 13:30:07 +0200
Message-Id: <20200525113014.345997-10-hch@lst.de>
In-Reply-To: <20200525113014.345997-1-hch@lst.de>
References: <20200525113014.345997-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-nvdimm@lists.01.org,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	dm-devel@redhat.com, Nitin Gupta <ngupta@vflare.org>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/16] block: remove generic_{start, end}_io_acct
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

Remove these now unused functions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 39 ---------------------------------------
 include/linux/bio.h |  6 ------
 2 files changed, 45 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 9c101a0572ca2..3e89c7b37855a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1392,45 +1392,6 @@ void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
 	}
 }
 
-void generic_start_io_acct(struct request_queue *q, int op,
-			   unsigned long sectors, struct hd_struct *part)
-{
-	const int sgrp = op_stat_group(op);
-	int rw = op_is_write(op);
-
-	part_stat_lock();
-
-	update_io_ticks(part, jiffies, false);
-	part_stat_inc(part, ios[sgrp]);
-	part_stat_add(part, sectors[sgrp], sectors);
-	part_stat_local_inc(part, in_flight[rw]);
-	if (part->partno)
-		part_stat_local_inc(&part_to_disk(part)->part0, in_flight[rw]);
-
-	part_stat_unlock();
-}
-EXPORT_SYMBOL(generic_start_io_acct);
-
-void generic_end_io_acct(struct request_queue *q, int req_op,
-			 struct hd_struct *part, unsigned long start_time)
-{
-	unsigned long now = jiffies;
-	unsigned long duration = now - start_time;
-	const int sgrp = op_stat_group(req_op);
-	int rw = op_is_write(req_op);
-
-	part_stat_lock();
-
-	update_io_ticks(part, now, true);
-	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
-	part_stat_local_dec(part, in_flight[rw]);
-	if (part->partno)
-		part_stat_local_dec(&part_to_disk(part)->part0, in_flight[rw]);
-
-	part_stat_unlock();
-}
-EXPORT_SYMBOL(generic_end_io_acct);
-
 static inline bool bio_remaining_done(struct bio *bio)
 {
 	/*
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 950c9dc44c4f2..941378ec5b39f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -444,12 +444,6 @@ void bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
 
-void generic_start_io_acct(struct request_queue *q, int op,
-				unsigned long sectors, struct hd_struct *part);
-void generic_end_io_acct(struct request_queue *q, int op,
-				struct hd_struct *part,
-				unsigned long start_time);
-
 extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 			       struct bio *src, struct bvec_iter *src_iter);
 extern void bio_copy_data(struct bio *dst, struct bio *src);
-- 
2.26.2

