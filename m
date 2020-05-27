Return-Path: <BATV+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 374904203C1
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2020 07:24:31 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 27 May 2020 07:24:05 +0200
Message-Id: <20200527052419.403583-3-hch@lst.de>
In-Reply-To: <20200527052419.403583-1-hch@lst.de>
References: <20200527052419.403583-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-nvdimm@lists.01.org,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	dm-devel@redhat.com, Nitin Gupta <ngupta@vflare.org>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/16] drbd: use bio_{start,end}_io_acct
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

Switch drbd to use the nicer bio accounting helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/block/drbd/drbd_req.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 840c3aef3c5c9..c80a2f1c3c2a7 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -21,24 +21,6 @@
 
 static bool drbd_may_do_local_read(struct drbd_device *device, sector_t sector, int size);
 
-/* Update disk stats at start of I/O request */
-static void _drbd_start_io_acct(struct drbd_device *device, struct drbd_request *req)
-{
-	struct request_queue *q = device->rq_queue;
-
-	generic_start_io_acct(q, bio_op(req->master_bio),
-				req->i.size >> 9, &device->vdisk->part0);
-}
-
-/* Update disk stats when completing request upwards */
-static void _drbd_end_io_acct(struct drbd_device *device, struct drbd_request *req)
-{
-	struct request_queue *q = device->rq_queue;
-
-	generic_end_io_acct(q, bio_op(req->master_bio),
-			    &device->vdisk->part0, req->start_jif);
-}
-
 static struct drbd_request *drbd_req_new(struct drbd_device *device, struct bio *bio_src)
 {
 	struct drbd_request *req;
@@ -263,7 +245,7 @@ void drbd_req_complete(struct drbd_request *req, struct bio_and_error *m)
 		start_new_tl_epoch(first_peer_device(device)->connection);
 
 	/* Update disk stats */
-	_drbd_end_io_acct(device, req);
+	bio_end_io_acct(req->master_bio, req->start_jif);
 
 	/* If READ failed,
 	 * have it be pushed back to the retry work queue,
@@ -1222,16 +1204,15 @@ drbd_request_prepare(struct drbd_device *device, struct bio *bio, unsigned long
 		bio_endio(bio);
 		return ERR_PTR(-ENOMEM);
 	}
-	req->start_jif = start_jif;
+
+	/* Update disk stats */
+	req->start_jif = bio_start_io_acct(req->master_bio);
 
 	if (!get_ldev(device)) {
 		bio_put(req->private_bio);
 		req->private_bio = NULL;
 	}
 
-	/* Update disk stats */
-	_drbd_start_io_acct(device, req);
-
 	/* process discards always from our submitter thread */
 	if (bio_op(bio) == REQ_OP_WRITE_ZEROES ||
 	    bio_op(bio) == REQ_OP_DISCARD)
-- 
2.26.2

