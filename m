Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed,  7 Sep 2011 16:17:35 +0200
Message-Id: <1315405061-1473-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315405061-1473-1-git-send-email-philipp.reisner@linbit.com>
References: <1315405061-1473-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/14] drbd: receive_bitmap(): Use the
	pre-allocated receive buffer
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
 drivers/block/drbd/drbd_receiver.c |   21 +++++----------------
 1 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3738d56..e5099db 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3572,8 +3572,9 @@ static int receive_sync_uuid(struct drbd_conf *mdev, enum drbd_packet cmd,
  */
 static int
 receive_bitmap_plain(struct drbd_conf *mdev, unsigned int data_size,
-		     unsigned long *buffer, struct bm_xfer_ctx *c)
+		     struct p_header *h, struct bm_xfer_ctx *c)
 {
+	unsigned long *buffer = (unsigned long *)h->payload;
 	unsigned num_words = min_t(size_t, BM_PACKET_WORDS, c->bm_words - c->word_offset);
 	unsigned want = num_words * sizeof(long);
 	int err;
@@ -3748,7 +3749,6 @@ static int receive_bitmap(struct drbd_conf *mdev, enum drbd_packet cmd,
 			  unsigned int data_size)
 {
 	struct bm_xfer_ctx c;
-	void *buffer;
 	int err;
 	struct p_header *h = mdev->tconn->data.rbuf;
 	struct packet_info pi;
@@ -3757,15 +3757,6 @@ static int receive_bitmap(struct drbd_conf *mdev, enum drbd_packet cmd,
 	/* you are supposed to send additional out-of-sync information
 	 * if you actually set bits during this phase */
 
-	/* maybe we should use some per thread scratch page,
-	 * and allocate that during initial device creation? */
-	buffer	 = (unsigned long *) __get_free_page(GFP_NOIO);
-	if (!buffer) {
-		dev_err(DEV, "failed to allocate one page buffer in %s\n", __func__);
-		err = -ENOMEM;
-		goto out;
-	}
-
 	c = (struct bm_xfer_ctx) {
 		.bm_bits = drbd_bm_bits(mdev),
 		.bm_words = drbd_bm_words(mdev),
@@ -3773,7 +3764,7 @@ static int receive_bitmap(struct drbd_conf *mdev, enum drbd_packet cmd,
 
 	for(;;) {
 		if (cmd == P_BITMAP) {
-			err = receive_bitmap_plain(mdev, data_size, buffer, &c);
+			err = receive_bitmap_plain(mdev, data_size, h, &c);
 		} else if (cmd == P_COMPRESSED_BITMAP) {
 			/* MAYBE: sanity check that we speak proto >= 90,
 			 * and the feature is enabled! */
@@ -3784,9 +3775,8 @@ static int receive_bitmap(struct drbd_conf *mdev, enum drbd_packet cmd,
 				err = -EIO;
 				goto out;
 			}
-			/* use the page buff */
-			p = buffer;
-			memcpy(p, h, sizeof(*h));
+
+			p = mdev->tconn->data.rbuf;
 			err = drbd_recv_all(mdev->tconn, p->head.payload, data_size);
 			if (err)
 			       goto out;
@@ -3840,7 +3830,6 @@ static int receive_bitmap(struct drbd_conf *mdev, enum drbd_packet cmd,
 	drbd_bm_unlock(mdev);
 	if (!err && mdev->state.conn == C_WF_BITMAP_S)
 		drbd_start_resync(mdev, C_SYNC_SOURCE);
-	free_page((unsigned long) buffer);
 	return err;
 }
 
-- 
1.7.4.1

