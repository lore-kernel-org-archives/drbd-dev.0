Return-Path: <BATV+33c89f8a75624a8d62ce+6289+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6F1A84207C2
	for <drbd-dev@lists.linbit.com>; Wed, 11 Nov 2020 09:27:21 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 11 Nov 2020 09:26:36 +0100
Message-Id: <20201111082658.3401686-3-hch@lst.de>
In-Reply-To: <20201111082658.3401686-1-hch@lst.de>
References: <20201111082658.3401686-1-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 02/24] loop: remove loop_set_size
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

Just use set_capacity_revalidate_and_notify directly, as this function
can update the block device size as well when the last parameter is set
to true.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cb1191d6e945f2..86eb7e0691eef5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -241,23 +241,6 @@ loop_validate_block_size(unsigned short bsize)
 	return 0;
 }
 
-/**
- * loop_set_size() - sets device size and notifies userspace
- * @lo: struct loop_device to set the size for
- * @size: new size of the loop device
- *
- * Callers must validate that the size passed into this function fits into
- * a sector_t, eg using loop_validate_size()
- */
-static void loop_set_size(struct loop_device *lo, loff_t size)
-{
-	struct block_device *bdev = lo->lo_device;
-
-	bd_set_nr_sectors(bdev, size);
-
-	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
-}
-
 static inline int
 lo_do_transfer(struct loop_device *lo, int cmd,
 	       struct page *rpage, unsigned roffs,
@@ -1076,7 +1059,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	struct address_space *mapping;
 	struct block_device *claimed_bdev = NULL;
 	int		error;
-	loff_t		size;
 	bool		partscan;
 	unsigned short  bsize;
 
@@ -1164,9 +1146,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 
-	size = get_loop_size(lo, file);
-	loop_set_size(lo, size);
-
+	set_capacity_revalidate_and_notify(lo->lo_disk, get_loop_size(lo, file),
+			true);
 	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
 		      block_size(inode->i_bdev) : PAGE_SIZE);
 
@@ -1402,9 +1383,9 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_CLEARABLE_FLAGS;
 
 	if (size_changed) {
-		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
-					   lo->lo_backing_file);
-		loop_set_size(lo, new_size);
+		set_capacity_revalidate_and_notify(lo->lo_disk,
+				get_size(lo->lo_offset, lo->lo_sizelimit,
+					 lo->lo_backing_file), true);
 	}
 
 	loop_config_discard(lo);
@@ -1580,14 +1561,10 @@ loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
 
 static int loop_set_capacity(struct loop_device *lo)
 {
-	loff_t size;
-
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
-
-	size = get_loop_size(lo, lo->lo_backing_file);
-	loop_set_size(lo, size);
-
+	set_capacity_revalidate_and_notify(lo->lo_disk,
+			get_loop_size(lo, lo->lo_backing_file), true);
 	return 0;
 }
 
-- 
2.28.0

