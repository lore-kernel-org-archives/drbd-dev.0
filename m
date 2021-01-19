Return-Path: <prvs=646552d04=chaitanya.kulkarni@wdc.com>
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 03B374205E5
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jan 2021 06:16:15 +0100 (CET)
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	cluster-devel@redhat.com
Date: Mon, 18 Jan 2021 21:06:14 -0800
Message-Id: <20210119050631.57073-21-chaitanya.kulkarni@wdc.com>
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
Subject: [Drbd-dev] [RFC PATCH 20/37] bcache: use bio_init_fields in
	writeback
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
 drivers/md/bcache/writeback.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index a129e4d2707c..e2b769bbdb14 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -358,10 +358,8 @@ static void write_dirty(struct closure *cl)
 	if (KEY_DIRTY(&w->key)) {
 		dirty_init(w);
 		bio_set_op_attrs(&io->bio, REQ_OP_WRITE, 0);
-		io->bio.bi_iter.bi_sector = KEY_START(&w->key);
-		bio_set_dev(&io->bio, io->dc->bdev);
-		io->bio.bi_end_io	= dirty_endio;
-
+		bio_init_fields(&io->bio, io->dc->bdev, KEY_START(&w->key), NULL,
+				dirty_endio, 0, 0);
 		/* I/O request sent to backing device */
 		closure_bio_submit(io->dc->disk.c, &io->bio, cl);
 	}
@@ -471,10 +469,10 @@ static void read_dirty(struct cached_dev *dc)
 
 			dirty_init(w);
 			bio_set_op_attrs(&io->bio, REQ_OP_READ, 0);
-			io->bio.bi_iter.bi_sector = PTR_OFFSET(&w->key, 0);
-			bio_set_dev(&io->bio,
-				    PTR_CACHE(dc->disk.c, &w->key, 0)->bdev);
-			io->bio.bi_end_io	= read_dirty_endio;
+			bio_init_fields(&io->bio,
+				PTR_CACHE(dc->disk.c, &w->key, 0)->bdev,
+				PTR_OFFSET(&w->key, 0), NULL,
+				read_dirty_endio, 0, 0);
 
 			if (bch_bio_alloc_pages(&io->bio, GFP_KERNEL))
 				goto err_free;
-- 
2.22.1

