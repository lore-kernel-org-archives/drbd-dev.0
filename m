Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed,  7 Sep 2011 16:17:37 +0200
Message-Id: <1315405061-1473-11-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315405061-1473-1-git-send-email-philipp.reisner@linbit.com>
References: <1315405061-1473-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/14] drbd: _drbd_send_bitmap(): Use the
	pre-allocated send buffer
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
 drivers/block/drbd/drbd_main.c |   26 +++++++-------------------
 1 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 6c2a51f..36b2b56 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -790,9 +790,6 @@ int drbd_send_sync_param(struct drbd_conf *mdev)
 		: apv <= 94 ? sizeof(struct p_rs_param_89)
 		: /* apv >= 95 */ sizeof(struct p_rs_param_95);
 
-	/* used from admin command context and receiver/worker context.
-	 * to avoid kmalloc, grab the socket right here,
-	 * then use the pre-allocated sbuf there */
 	mutex_lock(&mdev->tconn->data.mutex);
 	sock = mdev->tconn->data.socket;
 
@@ -1147,10 +1144,9 @@ int fill_bitmap_rle_bits(struct drbd_conf *mdev,
  * code upon failure.
  */
 static int
-send_bitmap_rle_or_plain(struct drbd_conf *mdev,
-			 struct p_header *h, struct bm_xfer_ctx *c)
+send_bitmap_rle_or_plain(struct drbd_conf *mdev, struct bm_xfer_ctx *c)
 {
-	struct p_compressed_bm *p = (void*)h;
+	struct p_compressed_bm *p = mdev->tconn->data.sbuf;
 	unsigned long num_words;
 	int len, err;
 
@@ -1162,7 +1158,7 @@ send_bitmap_rle_or_plain(struct drbd_conf *mdev,
 	if (len) {
 		dcbp_set_code(p, RLE_VLI_Bits);
 		err = _drbd_send_cmd(mdev, mdev->tconn->data.socket,
-				     P_COMPRESSED_BITMAP, h,
+				     P_COMPRESSED_BITMAP, &p->head,
 				     sizeof(*p) + len, 0);
 
 		c->packets[0]++;
@@ -1173,10 +1169,12 @@ send_bitmap_rle_or_plain(struct drbd_conf *mdev,
 	} else {
 		/* was not compressible.
 		 * send a buffer full of plain text bits instead. */
+		struct p_header *h = mdev->tconn->data.sbuf;
 		num_words = min_t(size_t, BM_PACKET_WORDS, c->bm_words - c->word_offset);
 		len = num_words * sizeof(long);
 		if (len)
-			drbd_bm_get_lel(mdev, c->word_offset, num_words, (unsigned long*)h->payload);
+			drbd_bm_get_lel(mdev, c->word_offset, num_words,
+					(unsigned long *)h->payload);
 		err = _drbd_send_cmd(mdev, mdev->tconn->data.socket, P_BITMAP,
 				     h, sizeof(struct p_header80) + len, 0);
 		c->word_offset += num_words;
@@ -1202,20 +1200,11 @@ send_bitmap_rle_or_plain(struct drbd_conf *mdev,
 static int _drbd_send_bitmap(struct drbd_conf *mdev)
 {
 	struct bm_xfer_ctx c;
-	struct p_header *p;
 	int err;
 
 	if (!expect(mdev->bitmap))
 		return false;
 
-	/* maybe we should use some per thread scratch page,
-	 * and allocate that during initial device creation? */
-	p = (struct p_header *) __get_free_page(GFP_NOIO);
-	if (!p) {
-		dev_err(DEV, "failed to allocate one page buffer in %s\n", __func__);
-		return false;
-	}
-
 	if (get_ldev(mdev)) {
 		if (drbd_md_test_flag(mdev->ldev, MDF_FULL_SYNC)) {
 			dev_info(DEV, "Writing the whole bitmap, MDF_FullSync was set.\n");
@@ -1239,10 +1228,9 @@ static int _drbd_send_bitmap(struct drbd_conf *mdev)
 	};
 
 	do {
-		err = send_bitmap_rle_or_plain(mdev, p, &c);
+		err = send_bitmap_rle_or_plain(mdev, &c);
 	} while (err > 0);
 
-	free_page((unsigned long) p);
 	return err == 0;
 }
 
-- 
1.7.4.1

