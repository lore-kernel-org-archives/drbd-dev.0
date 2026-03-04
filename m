Return-Path: <agruenba@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 284EE1630F3
	for <drbd-dev@lists.linbit.com>; Wed,  4 Mar 2026 20:10:52 +0100 (CET)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] bio: use bio_io_error more often
Date: Wed,  4 Mar 2026 20:04:09 +0100
Message-ID: <20260304190424.291743-5-agruenba@redhat.com>
In-Reply-To: <20260304190424.291743-1-agruenba@redhat.com>
References: <20260304190424.291743-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
Cc: dm-devel@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
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

Instead of setting bio->bi_status to BLK_STS_IOERR and calling
bio_endio(bio), use the shorthand bio_io_error(bio).

Created with Coccinelle using the following semantic patch:

@@
struct bio *bio;
@@
- bio->bi_status = BLK_STS_IOERR;
- bio_endio(bio);
+ bio_io_error(bio);

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c                  | 3 +--
 drivers/block/drbd/drbd_int.h | 3 +--
 drivers/md/bcache/bcache.h    | 3 +--
 drivers/md/bcache/request.c   | 6 ++----
 drivers/md/dm-mpath.c         | 3 +--
 drivers/md/dm-writecache.c    | 3 +--
 fs/f2fs/segment.c             | 3 +--
 7 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index bb6642b45937..9547f656904d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -218,8 +218,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret)) {
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
+			bio_io_error(bio);
 			break;
 		}
 		if (iocb->ki_flags & IOCB_NOWAIT) {
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f6d6276974ee..32639e8ea72a 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1491,8 +1491,7 @@ static inline void drbd_submit_bio_noacct(struct drbd_device *device,
 	__release(local);
 	if (!bio->bi_bdev) {
 		drbd_err(device, "drbd_submit_bio_noacct: bio->bi_bdev == NULL\n");
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		bio_io_error(bio);
 		return;
 	}
 
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index ec9ff9715081..e0c9d9eef0a0 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -947,8 +947,7 @@ static inline void closure_bio_submit(struct cache_set *c,
 {
 	closure_get(cl);
 	if (unlikely(test_bit(CACHE_SET_IO_DISABLE, &c->flags))) {
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		bio_io_error(bio);
 		return;
 	}
 	submit_bio_noacct(bio);
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 3fa3b13a410f..0f6fa0a2920b 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1178,8 +1178,7 @@ void cached_dev_submit_bio(struct bio *bio)
 
 	if (unlikely((d->c && test_bit(CACHE_SET_IO_DISABLE, &d->c->flags)) ||
 		     dc->io_disable)) {
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		bio_io_error(bio);
 		return;
 	}
 
@@ -1283,8 +1282,7 @@ void flash_dev_submit_bio(struct bio *bio)
 	struct bcache_device *d = bio->bi_bdev->bd_disk->private_data;
 
 	if (unlikely(d->c && test_bit(CACHE_SET_IO_DISABLE, &d->c->flags))) {
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		bio_io_error(bio);
 		return;
 	}
 
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 7cb7bb6233b6..bf4927f58d7f 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -712,8 +712,7 @@ static void process_queued_bios(struct work_struct *work)
 		r = __multipath_map_bio(m, bio, mpio);
 		switch (r) {
 		case DM_MAPIO_KILL:
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
+			bio_io_error(bio);
 			break;
 		case DM_MAPIO_REQUEUE:
 			bio->bi_status = BLK_STS_DM_REQUEUE;
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 98bd945f6da7..78a730a9b1ef 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1876,8 +1876,7 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
 		if (WC_MODE_FUA(wc))
 			bio->bi_opf |= REQ_FUA;
 		if (writecache_has_error(wc)) {
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
+			bio_io_error(bio);
 		} else if (unlikely(!bio_sectors(bio))) {
 			bio->bi_status = BLK_STS_OK;
 			bio_endio(bio);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6a97fe76712b..2dac0cbb5540 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4101,8 +4101,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	if (fio->bio && *(fio->bio)) {
 		struct bio *bio = *(fio->bio);
 
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		bio_io_error(bio);
 		*(fio->bio) = NULL;
 	}
 	return err;
-- 
2.52.0

