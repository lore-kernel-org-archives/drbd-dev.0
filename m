Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
	[209.85.128.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CA8FA420372
	for <drbd-dev@lists.linbit.com>; Tue,  2 May 2023 11:29:37 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
	5b1f17b1804b1-3f1cfed93e2so34678455e9.3
	for <drbd-dev@lists.linbit.com>; Tue, 02 May 2023 02:29:37 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue,  2 May 2023 11:29:22 +0200
Message-Id: <20230502092922.175857-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Voegtle <tv@lio96.de>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: do not set REQ_PREFLUSH when submitting
	barrier
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

When we receive a flush command (or "barrier" in DRBD), we currently use
a REQ_OP_FLUSH with the REQ_PREFLUSH flag set.

REQ_OP_FLUSH is supposed to be an empty bio with the sole purpose of
flushing the disk. REQ_PREFLUSH is used for REQ_OP_WRITE bios to
additionally signal that a flush should be issued, so it is redundant
here.

Since commit b4a6bb3a67aa ("block: add a sanity check for non-write
flush/fua bios"), this triggers a warning in the block layer.
So remove the REQ_PREFLUSH flag when allocating the bio.

Fixes: f9ff0da56437 ("drbd: allow parallel flushes for multi-volume resources")
Reported-by: Thomas Voegtle <tv@lio96.de>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e54404c632e7..f2479c29197a 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1283,7 +1283,7 @@ static void one_flush_endio(struct bio *bio)
 static void submit_one_flush(struct drbd_device *device, struct issue_flush_context *ctx)
 {
 	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
-				    REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
+				    REQ_OP_FLUSH, GFP_NOIO);
 	struct one_flush_context *octx = kmalloc(sizeof(*octx), GFP_NOIO);
 
 	if (!octx) {
-- 
2.39.2

