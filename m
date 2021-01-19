Return-Path: <prvs=646552d04=chaitanya.kulkarni@wdc.com>
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A790742060C
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jan 2021 06:15:12 +0100 (CET)
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	cluster-devel@redhat.com
Date: Mon, 18 Jan 2021 21:05:56 -0800
Message-Id: <20210119050631.57073-3-chaitanya.kulkarni@wdc.com>
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
Subject: [Drbd-dev] [RFC PATCH 02/37] fs: use bio_init_fields in block_dev
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
 fs/block_dev.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 3e5b02f6606c..44b992976ee5 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -239,12 +239,9 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	}
 
 	bio_init(&bio, vecs, nr_pages);
-	bio_set_dev(&bio, bdev);
-	bio.bi_iter.bi_sector = pos >> 9;
-	bio.bi_write_hint = iocb->ki_hint;
-	bio.bi_private = current;
-	bio.bi_end_io = blkdev_bio_end_io_simple;
-	bio.bi_ioprio = iocb->ki_ioprio;
+	bio_init_fields(&bio, bdev, pos >> 9, current, blkdev_bio_end_io_simple,
+			iocb->ki_ioprio, iocb->ki_hint);
+
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
@@ -390,12 +387,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		blk_start_plug(&plug);
 
 	for (;;) {
-		bio_set_dev(bio, bdev);
-		bio->bi_iter.bi_sector = pos >> 9;
-		bio->bi_write_hint = iocb->ki_hint;
-		bio->bi_private = dio;
-		bio->bi_end_io = blkdev_bio_end_io;
-		bio->bi_ioprio = iocb->ki_ioprio;
+		bio_init_fields(bio, bdev, pos >> 9, dio, blkdev_bio_end_io,
+				iocb->ki_ioprio, iocb->ki_hint);
 
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
-- 
2.22.1

