Return-Path: <BATV+9f6d5568987564775a8e+6744+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 443334202F6
	for <drbd-dev@lists.linbit.com>; Wed,  9 Feb 2022 09:28:48 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, target-devel@vger.kernel.org,
	haris.iqbal@ionos.com, jinpu.wang@ionos.com, manoj@linux.ibm.com,
	mrochs@linux.ibm.com, ukrishn@linux.ibm.com
Date: Wed,  9 Feb 2022 09:28:24 +0100
Message-Id: <20220209082828.2629273-4-hch@lst.de>
In-Reply-To: <20220209082828.2629273-1-hch@lst.de>
References: <20220209082828.2629273-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/7] rnbd: drop WRITE_SAME support
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

REQ_OP_WRITE_SAME was only ever submitted by the legacy Linux zeroing
code, which has switched to use REQ_OP_WRITE_ZEROES long before rnbd was
even merged.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rnbd/rnbd-clt.c   | 7 ++-----
 drivers/block/rnbd/rnbd-clt.h   | 1 -
 drivers/block/rnbd/rnbd-proto.h | 6 ------
 drivers/block/rnbd/rnbd-srv.c   | 3 +--
 4 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index c08971de369fc..dc192d2738854 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -82,7 +82,6 @@ static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
 	dev->nsectors		    = le64_to_cpu(rsp->nsectors);
 	dev->logical_block_size	    = le16_to_cpu(rsp->logical_block_size);
 	dev->physical_block_size    = le16_to_cpu(rsp->physical_block_size);
-	dev->max_write_same_sectors = le32_to_cpu(rsp->max_write_same_sectors);
 	dev->max_discard_sectors    = le32_to_cpu(rsp->max_discard_sectors);
 	dev->discard_granularity    = le32_to_cpu(rsp->discard_granularity);
 	dev->discard_alignment	    = le32_to_cpu(rsp->discard_alignment);
@@ -1359,8 +1358,6 @@ static void setup_request_queue(struct rnbd_clt_dev *dev)
 	blk_queue_logical_block_size(dev->queue, dev->logical_block_size);
 	blk_queue_physical_block_size(dev->queue, dev->physical_block_size);
 	blk_queue_max_hw_sectors(dev->queue, dev->max_hw_sectors);
-	blk_queue_max_write_same_sectors(dev->queue,
-					 dev->max_write_same_sectors);
 
 	/*
 	 * we don't support discards to "discontiguous" segments
@@ -1610,10 +1607,10 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	}
 
 	rnbd_clt_info(dev,
-		       "map_device: Device mapped as %s (nsectors: %zu, logical_block_size: %d, physical_block_size: %d, max_write_same_sectors: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, rotational: %d, wc: %d, fua: %d)\n",
+		       "map_device: Device mapped as %s (nsectors: %zu, logical_block_size: %d, physical_block_size: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, rotational: %d, wc: %d, fua: %d)\n",
 		       dev->gd->disk_name, dev->nsectors,
 		       dev->logical_block_size, dev->physical_block_size,
-		       dev->max_write_same_sectors, dev->max_discard_sectors,
+		       dev->max_discard_sectors,
 		       dev->discard_granularity, dev->discard_alignment,
 		       dev->secure_discard, dev->max_segments,
 		       dev->max_hw_sectors, dev->rotational, dev->wc, dev->fua);
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 0c2cae7f39b9f..6946ba23d62e5 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -122,7 +122,6 @@ struct rnbd_clt_dev {
 	bool			wc;
 	bool			fua;
 	u32			max_hw_sectors;
-	u32			max_write_same_sectors;
 	u32			max_discard_sectors;
 	u32			discard_granularity;
 	u32			discard_alignment;
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index de5d5a8df81d7..3eb8b34bd1886 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -249,9 +249,6 @@ static inline u32 rnbd_to_bio_flags(u32 rnbd_opf)
 	case RNBD_OP_SECURE_ERASE:
 		bio_opf = REQ_OP_SECURE_ERASE;
 		break;
-	case RNBD_OP_WRITE_SAME:
-		bio_opf = REQ_OP_WRITE_SAME;
-		break;
 	default:
 		WARN(1, "Unknown RNBD type: %d (flags %d)\n",
 		     rnbd_op(rnbd_opf), rnbd_opf);
@@ -284,9 +281,6 @@ static inline u32 rq_to_rnbd_flags(struct request *rq)
 	case REQ_OP_SECURE_ERASE:
 		rnbd_opf = RNBD_OP_SECURE_ERASE;
 		break;
-	case REQ_OP_WRITE_SAME:
-		rnbd_opf = RNBD_OP_WRITE_SAME;
-		break;
 	case REQ_OP_FLUSH:
 		rnbd_opf = RNBD_OP_FLUSH;
 		break;
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 132e950685d59..0e6b5687f8321 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -548,8 +548,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 		cpu_to_le16(rnbd_dev_get_max_segs(rnbd_dev));
 	rsp->max_hw_sectors =
 		cpu_to_le32(rnbd_dev_get_max_hw_sects(rnbd_dev));
-	rsp->max_write_same_sectors =
-		cpu_to_le32(bdev_write_same(rnbd_dev->bdev));
+	rsp->max_write_same_sectors = 0;
 	rsp->max_discard_sectors =
 		cpu_to_le32(rnbd_dev_get_max_discard_sects(rnbd_dev));
 	rsp->discard_granularity =
-- 
2.30.2

