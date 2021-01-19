Return-Path: <prvs=646552d04=chaitanya.kulkarni@wdc.com>
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9CE034203D0
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jan 2021 06:13:10 +0100 (CET)
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	cluster-devel@redhat.com
Date: Mon, 18 Jan 2021 21:06:20 -0800
Message-Id: <20210119050631.57073-27-chaitanya.kulkarni@wdc.com>
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
Subject: [Drbd-dev] [RFC PATCH 26/37] dm log writes: use bio_init_fields
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

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/md/dm-log-writes.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index e3d35c6c9f71..35c2e0418561 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -223,11 +223,9 @@ static int write_metadata(struct log_writes_c *lc, void *entry,
 		goto error;
 	}
 	bio->bi_iter.bi_size = 0;
-	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, lc->logdev->bdev);
 	bio->bi_end_io = (sector == WRITE_LOG_SUPER_SECTOR) ?
 			  log_end_super : log_end_io;
-	bio->bi_private = lc;
+	bio_init_fields(bio, lc->logdev->bdev, sector, lc, NULL, 0, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 	page = alloc_page(GFP_KERNEL);
@@ -283,10 +281,8 @@ static int write_inline_data(struct log_writes_c *lc, void *entry,
 		}
 
 		bio->bi_iter.bi_size = 0;
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, lc->logdev->bdev);
-		bio->bi_end_io = log_end_io;
-		bio->bi_private = lc;
+		bio_init_fields(bio, lc->logdev->bdev, sector, lc, log_end_io,
+				0, 0);
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		for (i = 0; i < bio_pages; i++) {
@@ -370,10 +366,8 @@ static int log_one_block(struct log_writes_c *lc,
 		goto error;
 	}
 	bio->bi_iter.bi_size = 0;
-	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, lc->logdev->bdev);
-	bio->bi_end_io = log_end_io;
-	bio->bi_private = lc;
+	bio_init_fields(bio, lc->logdev->bdev, sector, lc, log_end_io,
+			0, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 	for (i = 0; i < block->vec_cnt; i++) {
@@ -392,10 +386,7 @@ static int log_one_block(struct log_writes_c *lc,
 				goto error;
 			}
 			bio->bi_iter.bi_size = 0;
-			bio->bi_iter.bi_sector = sector;
-			bio_set_dev(bio, lc->logdev->bdev);
-			bio->bi_end_io = log_end_io;
-			bio->bi_private = lc;
+			bio_init_fields(bio, lc->logdev->bdev, sector, lc, log_end_io, 0, 0);
 			bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 			ret = bio_add_page(bio, block->vecs[i].bv_page,
-- 
2.22.1

