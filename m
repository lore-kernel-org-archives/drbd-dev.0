Return-Path: <prvs=646552d04=chaitanya.kulkarni@wdc.com>
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8ECC34205F5
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jan 2021 06:15:05 +0100 (CET)
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	cluster-devel@redhat.com
Date: Mon, 18 Jan 2021 21:05:57 -0800
Message-Id: <20210119050631.57073-4-chaitanya.kulkarni@wdc.com>
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
Subject: [Drbd-dev] [RFC PATCH 03/37] btrfs: use bio_init_fields in disk-io
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
 fs/btrfs/disk-io.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 765deefda92b..9a65432fc5e9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3637,10 +3637,8 @@ static int write_dev_supers(struct btrfs_device *device,
 		 * checking.
 		 */
 		bio = bio_alloc(GFP_NOFS, 1);
-		bio_set_dev(bio, device->bdev);
-		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
-		bio->bi_private = device;
-		bio->bi_end_io = btrfs_end_super_write;
+		bio_init_fields(bio, device->bdev, bytenr >> SECTOR_SHIFT,
+				device, btrfs_end_super_write, 0, 0);
 		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
 			       offset_in_page(bytenr));
 
@@ -3748,11 +3746,10 @@ static void write_dev_flush(struct btrfs_device *device)
 		return;
 
 	bio_reset(bio);
-	bio->bi_end_io = btrfs_end_empty_barrier;
-	bio_set_dev(bio, device->bdev);
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
 	init_completion(&device->flush_wait);
-	bio->bi_private = &device->flush_wait;
+	bio_init_fields(bio, device->bdev, 0, &device->flush_wait,
+			btrfs_end_empty_barrier, 0, 0);
 
 	btrfsic_submit_bio(bio);
 	set_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state);
-- 
2.22.1

