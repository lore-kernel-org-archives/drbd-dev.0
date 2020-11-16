Return-Path: <BATV+29a21e8ca386e11a5a78+6294+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2608B420876
	for <drbd-dev@lists.linbit.com>; Mon, 16 Nov 2020 17:51:40 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 16 Nov 2020 15:57:18 +0100
Message-Id: <20201116145809.410558-28-hch@lst.de>
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
	xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Subject: [Drbd-dev] [PATCH 27/78] rbd: implement ->set_read_only to hook
	into BLKROSET processing
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

Implement the ->set_read_only method instead of parsing the actual
ioctl command.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 40 ++++------------------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b7a194ffda55b4..2ed79b09439a82 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -692,12 +692,9 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
 	put_device(&rbd_dev->dev);
 }
 
-static int rbd_ioctl_set_ro(struct rbd_device *rbd_dev, unsigned long arg)
+static int rbd_set_read_only(struct block_device *bdev, bool ro)
 {
-	int ro;
-
-	if (get_user(ro, (int __user *)arg))
-		return -EFAULT;
+	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
 
 	/*
 	 * Both images mapped read-only and snapshots can't be marked
@@ -710,43 +707,14 @@ static int rbd_ioctl_set_ro(struct rbd_device *rbd_dev, unsigned long arg)
 		rbd_assert(!rbd_is_snap(rbd_dev));
 	}
 
-	/* Let blkdev_roset() handle it */
-	return -ENOTTY;
-}
-
-static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
-			unsigned int cmd, unsigned long arg)
-{
-	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
-	int ret;
-
-	switch (cmd) {
-	case BLKROSET:
-		ret = rbd_ioctl_set_ro(rbd_dev, arg);
-		break;
-	default:
-		ret = -ENOTTY;
-	}
-
-	return ret;
-}
-
-#ifdef CONFIG_COMPAT
-static int rbd_compat_ioctl(struct block_device *bdev, fmode_t mode,
-				unsigned int cmd, unsigned long arg)
-{
-	return rbd_ioctl(bdev, mode, cmd, arg);
+	return 0;
 }
-#endif /* CONFIG_COMPAT */
 
 static const struct block_device_operations rbd_bd_ops = {
 	.owner			= THIS_MODULE,
 	.open			= rbd_open,
 	.release		= rbd_release,
-	.ioctl			= rbd_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl		= rbd_compat_ioctl,
-#endif
+	.set_read_only		= rbd_set_read_only,
 };
 
 /*
-- 
2.29.2

