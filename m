Return-Path: <BATV+b18bff4eac1ff4fd9b6a+6737+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 589CC42017F
	for <drbd-dev@lists.linbit.com>; Wed,  2 Feb 2022 17:01:18 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  2 Feb 2022 17:00:57 +0100
Message-Id: <20220202160109.108149-2-hch@lst.de>
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/13] drbd: set ->bi_bdev in drbd_req_new
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

Make sure the newly allocated bio has the correct bi_bdev set from the
start.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_req.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 3235532ae0778..8d44e96c4c4ef 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -31,6 +31,7 @@ static struct drbd_request *drbd_req_new(struct drbd_device *device, struct bio
 	memset(req, 0, sizeof(*req));
 
 	req->private_bio = bio_clone_fast(bio_src, GFP_NOIO, &drbd_io_bio_set);
+	bio_set_dev(req->private_bio, device->ldev->backing_bdev);
 	req->private_bio->bi_private = req;
 	req->private_bio->bi_end_io = drbd_request_endio;
 
@@ -1151,8 +1152,6 @@ drbd_submit_req_private_bio(struct drbd_request *req)
 	else
 		type = DRBD_FAULT_DT_RD;
 
-	bio_set_dev(bio, device->ldev->backing_bdev);
-
 	/* State may have changed since we grabbed our reference on the
 	 * ->ldev member. Double check, and short-circuit to endio.
 	 * In case the last activity log transaction failed to get on
-- 
2.30.2

