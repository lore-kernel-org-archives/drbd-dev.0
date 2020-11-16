Return-Path: <BATV+29a21e8ca386e11a5a78+6294+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B8962420862
	for <drbd-dev@lists.linbit.com>; Mon, 16 Nov 2020 17:31:44 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 16 Nov 2020 15:57:23 +0100
Message-Id: <20201116145809.410558-33-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 32/78] block: remove set_device_ro
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

Fold set_device_ro into its only remaining caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 7 -------
 block/ioctl.c         | 2 +-
 include/linux/genhd.h | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8c350fecfe8bfe..b0f0b0cac9aa7f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1843,13 +1843,6 @@ static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
 }
 
-void set_device_ro(struct block_device *bdev, int flag)
-{
-	bdev->bd_part->policy = flag;
-}
-
-EXPORT_SYMBOL(set_device_ro);
-
 void set_disk_ro(struct gendisk *disk, int flag)
 {
 	struct disk_part_iter piter;
diff --git a/block/ioctl.c b/block/ioctl.c
index 96cb4544736468..04255dc5f3bff3 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -371,7 +371,7 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 		if (ret)
 			return ret;
 	}
-	set_device_ro(bdev, n);
+	bdev->bd_part->policy = n;
 	return 0;
 }
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4b22bfd9336e1a..8427ad8bef520d 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -304,7 +304,6 @@ extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
 
-extern void set_device_ro(struct block_device *bdev, int flag);
 extern void set_disk_ro(struct gendisk *disk, int flag);
 
 static inline int get_disk_ro(struct gendisk *disk)
-- 
2.29.2

