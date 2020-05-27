Return-Path: <BATV+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7BB5F42038C
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2020 07:24:42 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 27 May 2020 07:24:09 +0200
Message-Id: <20200527052419.403583-7-hch@lst.de>
In-Reply-To: <20200527052419.403583-1-hch@lst.de>
References: <20200527052419.403583-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-nvdimm@lists.01.org,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	dm-devel@redhat.com, Nitin Gupta <ngupta@vflare.org>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/16] dm: use bio_{start,end}_io_acct
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

Switch dm to use the nicer bio accounting helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/md/dm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f215b86664484..3f39fa1ac756e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -681,11 +681,7 @@ static void start_io_acct(struct dm_io *io)
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
 
-	io->start_time = jiffies;
-
-	generic_start_io_acct(md->queue, bio_op(bio), bio_sectors(bio),
-			      &dm_disk(md)->part0);
-
+	io->start_time = bio_start_io_acct(bio);
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
@@ -698,8 +694,7 @@ static void end_io_acct(struct dm_io *io)
 	struct bio *bio = io->orig_bio;
 	unsigned long duration = jiffies - io->start_time;
 
-	generic_end_io_acct(md->queue, bio_op(bio), &dm_disk(md)->part0,
-			    io->start_time);
+	bio_end_io_acct(bio, io->start_time);
 
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
-- 
2.26.2

