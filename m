Return-Path: <prvs=646552d04=chaitanya.kulkarni@wdc.com>
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AE37942061F
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jan 2021 06:16:53 +0100 (CET)
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	cluster-devel@redhat.com
Date: Mon, 18 Jan 2021 21:06:12 -0800
Message-Id: <20210119050631.57073-19-chaitanya.kulkarni@wdc.com>
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
Subject: [Drbd-dev] [RFC PATCH 18/37] bcache: use bio_init_fields in journal
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
 drivers/md/bcache/journal.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index aefbdb7e003b..0aabcb5cf2ad 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -54,12 +54,10 @@ reread:		left = ca->sb.bucket_size - offset;
 		len = min_t(unsigned int, left, PAGE_SECTORS << JSET_BITS);
 
 		bio_reset(bio);
-		bio->bi_iter.bi_sector	= bucket + offset;
-		bio_set_dev(bio, ca->bdev);
+		bio_init_fields(bio, ca->bdev, bucket + offset,
+				&cl, journal_read_endio, 0, 0);
 		bio->bi_iter.bi_size	= len << 9;
 
-		bio->bi_end_io	= journal_read_endio;
-		bio->bi_private = &cl;
 		bio_set_op_attrs(bio, REQ_OP_READ, 0);
 		bch_bio_map(bio, data);
 
@@ -588,6 +586,7 @@ static void do_journal_discard(struct cache *ca)
 {
 	struct journal_device *ja = &ca->journal;
 	struct bio *bio = &ja->discard_bio;
+	sector_t sect;
 
 	if (!ca->discard) {
 		ja->discard_idx = ja->last_idx;
@@ -613,12 +612,10 @@ static void do_journal_discard(struct cache *ca)
 
 		bio_init(bio, bio->bi_inline_vecs, 1);
 		bio_set_op_attrs(bio, REQ_OP_DISCARD, 0);
-		bio->bi_iter.bi_sector	= bucket_to_sector(ca->set,
-						ca->sb.d[ja->discard_idx]);
-		bio_set_dev(bio, ca->bdev);
 		bio->bi_iter.bi_size	= bucket_bytes(ca);
-		bio->bi_end_io		= journal_discard_endio;
-
+		sect = bucket_to_sector(ca->set, ca->sb.d[ja->discard_idx]);
+		bio_init_fields(bio, ca->bdev, sect, NULL,
+				journal_discard_endio, 0, 0);
 		closure_get(&ca->set->cl);
 		INIT_WORK(&ja->discard_work, journal_discard_work);
 		queue_work(bch_journal_wq, &ja->discard_work);
@@ -774,12 +771,10 @@ static void journal_write_unlocked(struct closure *cl)
 		atomic_long_add(sectors, &ca->meta_sectors_written);
 
 		bio_reset(bio);
-		bio->bi_iter.bi_sector	= PTR_OFFSET(k, i);
-		bio_set_dev(bio, ca->bdev);
 		bio->bi_iter.bi_size = sectors << 9;
 
-		bio->bi_end_io	= journal_write_endio;
-		bio->bi_private = w;
+		bio_init_fields(bio, ca->bdev, PTR_OFFSET(k, i), w,
+				journal_write_endio, 0, 0);
 		bio_set_op_attrs(bio, REQ_OP_WRITE,
 				 REQ_SYNC|REQ_META|REQ_PREFLUSH|REQ_FUA);
 		bch_bio_map(bio, w->data);
-- 
2.22.1

