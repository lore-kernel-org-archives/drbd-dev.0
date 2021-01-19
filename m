Return-Path: <prvs=646552d04=chaitanya.kulkarni@wdc.com>
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1A1AE420607
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jan 2021 06:15:11 +0100 (CET)
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	cluster-devel@redhat.com
Date: Mon, 18 Jan 2021 21:05:55 -0800
Message-Id: <20210119050631.57073-2-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net, snitzer@redhat.com,
	gustavo@embeddedor.com, clm@fb.com, dm-devel@redhat.com,
	adilger.kernel@dilger.ca, hch@lst.de, agk@redhat.com,
	naohiro.aota@wdc.com, sagi@grimberg.me, darrick.wong@oracle.com,
	osandov@fb.com, kent.overstreet@gmail.com,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	josef@toxicpanda.com, efremov@linux.com, colyli@suse.de,
	tj@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
	bvanassche@acm.org, agruenba@redhat.com, axboe@kernel.dk,
	damien.lemoal@wdc.com, tytso@mit.edu, martin.petersen@oracle.com,
	song@kernel.org, philipp.reisner@linbit.com,
	jefflexu@linux.alibaba.com, rpeterso@redhat.com,
	lars.ellenberg@linbit.com, jth@kernel.org, asml.silence@gmail.com
Subject: [Drbd-dev] [RFC PATCH 01/37] block: introduce bio_init_fields()
	helper
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

There are several places in the file-system, block layer, device drivers
where struct bio members such as bdev, sector, private, end io callback,
io priority, write hints are initialized where we can use a helper
function.

This pach introduces a helper function which we use in the block lyaer
code. Subsequent patches use this function to reduce repeated code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c     | 13 +++++--------
 include/linux/bio.h | 13 +++++++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 752f9c722062..5ee488c1bcc6 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -95,8 +95,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
 
 		bio = blk_next_bio(bio, 0, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
+		bio_init_fields(bio, bdev, sector, NULL, NULL, 0, 0);
 		bio_set_op_attrs(bio, op, 0);
 
 		bio->bi_iter.bi_size = req_sects << 9;
@@ -189,8 +188,7 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 
 	while (nr_sects) {
 		bio = blk_next_bio(bio, 1, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
+		bio_init_fields(bio, bdev, sector, NULL, NULL, 0, 0);
 		bio->bi_vcnt = 1;
 		bio->bi_io_vec->bv_page = page;
 		bio->bi_io_vec->bv_offset = 0;
@@ -265,8 +263,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 
 	while (nr_sects) {
 		bio = blk_next_bio(bio, 0, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
+		bio_init_fields(bio, bdev, sector, NULL, NULL, 0, 0);
 		bio->bi_opf = REQ_OP_WRITE_ZEROES;
 		if (flags & BLKDEV_ZERO_NOUNMAP)
 			bio->bi_opf |= REQ_NOUNMAP;
@@ -317,8 +314,8 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 	while (nr_sects != 0) {
 		bio = blk_next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
 				   gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
+		bio_init_fields(bio, bdev, sector, NULL, NULL, 0, 0);
+
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		while (nr_sects != 0) {
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1edda614f7ce..fbeaa5e42a5d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -820,4 +820,17 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
+static inline void bio_init_fields(struct bio *bio, struct block_device *bdev,
+				   sector_t sect, void *priv,
+				   bio_end_io_t *end_io,
+				   unsigned short prio, unsigned short whint)
+{
+	bio_set_dev(bio, bdev);
+	bio->bi_iter.bi_sector = sect;
+	bio->bi_private = priv;
+	bio->bi_end_io = end_io;
+	bio->bi_ioprio = prio;
+	bio->bi_write_hint = whint;
+}
+
 #endif /* __LINUX_BIO_H */
-- 
2.22.1

