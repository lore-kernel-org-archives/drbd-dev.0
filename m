Return-Path: <BATV+2fedbe304aabaf399917+7597+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DE16E420898
	for <drbd-dev@lists.linbit.com>; Tue, 11 Jun 2024 08:33:49 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/26] virtio_blk: remove virtblk_update_cache_mode
Date: Tue, 11 Jun 2024 07:19:08 +0200
Message-ID: <20240611051929.513387-9-hch@lst.de>
In-Reply-To: <20240611051929.513387-1-hch@lst.de>
References: <20240611051929.513387-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: nvdimm@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, linux-mtd@lists.infradead.org,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yu Kuai <yukuai3@huawei.com>, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, Mike Snitzer <snitzer@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-mmc@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	virtualization@lists.linux.dev, Lars Ellenberg <lars.ellenberg@linbit.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
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

virtblk_update_cache_mode boils down to a single call to
blk_queue_write_cache.  Remove it in preparation for moving the cache
control flags into the queue_limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2351f411fa4680..378b241911ca87 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1089,14 +1089,6 @@ static int virtblk_get_cache_mode(struct virtio_device *vdev)
 	return writeback;
 }
 
-static void virtblk_update_cache_mode(struct virtio_device *vdev)
-{
-	u8 writeback = virtblk_get_cache_mode(vdev);
-	struct virtio_blk *vblk = vdev->priv;
-
-	blk_queue_write_cache(vblk->disk->queue, writeback, false);
-}
-
 static const char *const virtblk_cache_types[] = {
 	"write through", "write back"
 };
@@ -1116,7 +1108,7 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 		return i;
 
 	virtio_cwrite8(vdev, offsetof(struct virtio_blk_config, wce), i);
-	virtblk_update_cache_mode(vdev);
+	blk_queue_write_cache(disk->queue, virtblk_get_cache_mode(vdev), false);
 	return count;
 }
 
@@ -1528,7 +1520,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	vblk->index = index;
 
 	/* configure queue flush support */
-	virtblk_update_cache_mode(vdev);
+	blk_queue_write_cache(vblk->disk->queue, virtblk_get_cache_mode(vdev),
+			false);
 
 	/* If disk is read-only in the host, the guest should obey */
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_RO))
-- 
2.43.0

