Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1B7631057584
	for <drbd-dev@lists.linbit.com>; Tue, 16 Jan 2018 00:00:56 +0100 (CET)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: drbd-dev@lists.linbit.com
Date: Mon, 15 Jan 2018 15:00:31 -0800
Message-Id: <1516057231-21756-1-git-send-email-drbd-dev@lists.ewheeler.net>
In-Reply-To: <15124635.GA4107@soda.linbit>
References: <15124635.GA4107@soda.linbit>
Cc: Eric Wheeler <drbd@linux.ewheeler.net>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Eric Wheeler <git@linux.ewheeler.net>
Subject: [Drbd-dev] [PATCH] drbd: fix discard_zeroes_if_aligned regression
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Eric Wheeler <git@linux.ewheeler.net>

According to drbd.conf documentation, "To not break established and
expected behaviour, and suddenly cause fstrim on thin-provisioned LVs to
run out-of-space instead of freeing up space, the default value is yes."

This behavior regressed in the REQ_OP_WRITE_ZEROES refactor near
	45c21793 drbd: implement REQ_OP_WRITE_ZEROES
    0dbed96  drbd: make intelligent use of blkdev_issue_zeroout
which caused dm-thin backed DRBD volumes to zero blocks and run out of
space instead of passing discard to the backing device as defined by the
discard_zeroes_if_aligned option.

A helper function could reduce code duplication.

Signed-off-by: Eric Wheeler <drbd@linux.ewheeler.net>
Cc: <stable@vger.kernel.org> # 4.14
---
 drivers/block/drbd/drbd_receiver.c | 22 ++++++++++++++++++++--
 drivers/block/drbd/drbd_req.c      | 23 +++++++++++++++++++++--
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 62a902f..58f0e43 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1507,9 +1507,27 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 static void drbd_issue_peer_discard(struct drbd_device *device, struct drbd_peer_request *peer_req)
 {
 	struct block_device *bdev = device->ldev->backing_bdev;
+	struct disk_conf *dc;
+	bool discard_zeroes_if_aligned, zeroout;
 
-	if (blkdev_issue_zeroout(bdev, peer_req->i.sector, peer_req->i.size >> 9,
-			GFP_NOIO, 0))
+	rcu_read_lock();
+	dc = rcu_dereference(device->ldev->disk_conf);
+	discard_zeroes_if_aligned = dc->discard_zeroes_if_aligned;
+	rcu_read_unlock();
+
+	/* Use zeroout unless discard_zeroes_if_aligned is set.
+	 * If blkdev_issue_discard fails, then retry with blkdev_issue_zeroout.
+	 * See also drbd_process_discard_req() in drbd_req.c.
+	 */
+	zeroout = true;
+	if (discard_zeroes_if_aligned &&
+	    blkdev_issue_discard(bdev, peer_req->i.sector,
+		peer_req->i.size >> 9, GFP_NOIO, 0) == 0)
+		zeroout = false;
+
+	if (zeroout &&
+	    blkdev_issue_zeroout(bdev, peer_req->i.sector,
+		peer_req->i.size >> 9, GFP_NOIO, 0) != 0)
 		peer_req->flags |= EE_WAS_ERROR;
 
 	drbd_endio_write_sec_final(peer_req);
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index de8566e..070b5e7 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1158,9 +1158,28 @@ static int drbd_process_write_request(struct drbd_request *req)
 static void drbd_process_discard_req(struct drbd_request *req)
 {
 	struct block_device *bdev = req->device->ldev->backing_bdev;
+	struct drbd_device *device = req->device;
+	struct disk_conf *dc;
+	bool discard_zeroes_if_aligned, zeroout;
 
-	if (blkdev_issue_zeroout(bdev, req->i.sector, req->i.size >> 9,
-			GFP_NOIO, 0))
+	rcu_read_lock();
+	dc = rcu_dereference(device->ldev->disk_conf);
+	discard_zeroes_if_aligned = dc->discard_zeroes_if_aligned;
+	rcu_read_unlock();
+
+	/* Use zeroout unless discard_zeroes_if_aligned is set.
+	 * If blkdev_issue_discard fails, then retry with blkdev_issue_zeroout.
+	 * See also drbd_issue_peer_discard() in drbd_receiver.c.
+	 */
+	zeroout = true;
+	if (discard_zeroes_if_aligned &&
+	    blkdev_issue_discard(bdev, req->i.sector, req->i.size >> 9,
+			GFP_NOIO, 0) == 0)
+		zeroout = false;
+
+	if (zeroout &&
+	    blkdev_issue_zeroout(bdev, req->i.sector, req->i.size >> 9,
+			GFP_NOIO, 0) != 0)
 		req->private_bio->bi_status = BLK_STS_IOERR;
 	bio_endio(req->private_bio);
 }
-- 
1.8.3.1

