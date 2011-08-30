Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue, 30 Aug 2011 11:05:38 +0200
Message-Id: <1314695149-387-5-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314695149-387-1-git-send-email-philipp.reisner@linbit.com>
References: <1314695149-387-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/15] drbd: Use the IS_ALIGNED() macro in some
	more places
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c   |    6 +++---
 drivers/block/drbd/drbd_receiver.c |    2 +-
 drivers/block/drbd/drbd_req.c      |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 0748871..ad61863 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -767,7 +767,7 @@ void __drbd_set_in_sync(struct drbd_conf *mdev, sector_t sector, int size,
 	int wake_up = 0;
 	unsigned long flags;
 
-	if (size <= 0 || (size & 0x1ff) != 0 || size > DRBD_MAX_BIO_SIZE) {
+	if (size <= 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_BIO_SIZE) {
 		dev_err(DEV, "drbd_set_in_sync: sector=%llus size=%d nonsense!\n",
 				(unsigned long long)sector, size);
 		return;
@@ -832,7 +832,7 @@ int __drbd_set_out_of_sync(struct drbd_conf *mdev, sector_t sector, int size,
 	unsigned int enr, count = 0;
 	struct lc_element *e;
 
-	if (size <= 0 || (size & 0x1ff) != 0 || size > DRBD_MAX_BIO_SIZE) {
+	if (size <= 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_BIO_SIZE) {
 		dev_err(DEV, "sector: %llus, size: %d\n",
 			(unsigned long long)sector, size);
 		return 0;
@@ -1217,7 +1217,7 @@ void drbd_rs_failed_io(struct drbd_conf *mdev, sector_t sector, int size)
 	sector_t esector, nr_sectors;
 	int wake_up = 0;
 
-	if (size <= 0 || (size & 0x1ff) != 0 || size > DRBD_MAX_BIO_SIZE) {
+	if (size <= 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_BIO_SIZE) {
 		dev_err(DEV, "drbd_rs_failed_io: sector=%llus size=%d nonsense!\n",
 				(unsigned long long)sector, size);
 		return;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index deae7cb..af3ee2f 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2041,7 +2041,7 @@ static int receive_DataRequest(struct drbd_conf *mdev, enum drbd_packet cmd,
 	sector = be64_to_cpu(p->sector);
 	size   = be32_to_cpu(p->blksize);
 
-	if (size <= 0 || (size & 0x1ff) != 0 || size > DRBD_MAX_BIO_SIZE) {
+	if (size <= 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_BIO_SIZE) {
 		dev_err(DEV, "%s:%d: sector: %llus, size: %u\n", __FILE__, __LINE__,
 				(unsigned long long)sector, size);
 		return false;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 157c737..48d313d 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1023,7 +1023,7 @@ int drbd_make_request(struct request_queue *q, struct bio *bio)
 	 * what we "blindly" assume:
 	 */
 	D_ASSERT(bio->bi_size > 0);
-	D_ASSERT((bio->bi_size & 0x1ff) == 0);
+	D_ASSERT(IS_ALIGNED(bio->bi_size, 512));
 	D_ASSERT(bio->bi_idx == 0);
 
 	/* to make some things easier, force alignment of requests within the
-- 
1.7.4.1

