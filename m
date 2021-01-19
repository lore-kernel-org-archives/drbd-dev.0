Return-Path: <prvs=646552d04=chaitanya.kulkarni@wdc.com>
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AC3F44202DB
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jan 2021 06:17:22 +0100 (CET)
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	cluster-devel@redhat.com
Date: Mon, 18 Jan 2021 21:06:13 -0800
Message-Id: <20210119050631.57073-20-chaitanya.kulkarni@wdc.com>
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
Subject: [Drbd-dev] [RFC PATCH 19/37] bcache: use bio_init_fields in super
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
 drivers/md/bcache/super.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a4752ac410dc..b4ced138a0c0 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -312,9 +312,7 @@ void bch_write_bdev_super(struct cached_dev *dc, struct closure *parent)
 	closure_init(cl, parent);
 
 	bio_init(bio, dc->sb_bv, 1);
-	bio_set_dev(bio, dc->bdev);
-	bio->bi_end_io	= write_bdev_super_endio;
-	bio->bi_private = dc;
+	bio_init_fields(bio, dc->bdev, 0, dc, write_bdev_super_endio, 0, 0);
 
 	closure_get(cl);
 	/* I/O request sent to backing device */
@@ -356,9 +354,7 @@ void bcache_write_super(struct cache_set *c)
 		ca->sb.version = version;
 
 	bio_init(bio, ca->sb_bv, 1);
-	bio_set_dev(bio, ca->bdev);
-	bio->bi_end_io	= write_super_endio;
-	bio->bi_private = ca;
+	bio_init_fields(bio, ca->bdev, 0, ca, write_super_endio, 0, 0);
 
 	closure_get(cl);
 	__write_super(&ca->sb, ca->sb_disk, bio);
@@ -402,9 +398,7 @@ static void uuid_io(struct cache_set *c, int op, unsigned long op_flags,
 
 		bio->bi_opf = REQ_SYNC | REQ_META | op_flags;
 		bio->bi_iter.bi_size = KEY_SIZE(k) << 9;
-
-		bio->bi_end_io	= uuid_endio;
-		bio->bi_private = cl;
+		bio_init_fields(bio, NULL, 0, cl, uuid_endio, 0, 0);
 		bio_set_op_attrs(bio, op, REQ_SYNC|REQ_META|op_flags);
 		bch_bio_map(bio, c->uuids);
 
@@ -566,12 +560,9 @@ static void prio_io(struct cache *ca, uint64_t bucket, int op,
 
 	closure_init_stack(cl);
 
-	bio->bi_iter.bi_sector	= bucket * ca->sb.bucket_size;
-	bio_set_dev(bio, ca->bdev);
 	bio->bi_iter.bi_size	= meta_bucket_bytes(&ca->sb);
-
-	bio->bi_end_io	= prio_endio;
-	bio->bi_private = ca;
+	bio_init_fields(bio, ca->bdev, bucket * ca->sb.bucket_size, ca,
+			prio_endio, 0, 0);
 	bio_set_op_attrs(bio, op, REQ_SYNC|REQ_META|op_flags);
 	bch_bio_map(bio, ca->disk_buckets);
 
-- 
2.22.1

