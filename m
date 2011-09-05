Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:19 +0200
Message-Id: <1315223145-20640-29-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 28/54] drbd: _drbd_no_send_page(): Return 0 upon
	success and an error code otherwise
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
 drivers/block/drbd/drbd_main.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index c887ff7..1a8c3db 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1405,13 +1405,19 @@ static void drbd_update_congested(struct drbd_tconn *tconn)
  * with page_count == 0 or PageSlab.
  */
 static int _drbd_no_send_page(struct drbd_conf *mdev, struct page *page,
-		   int offset, size_t size, unsigned msg_flags)
+			      int offset, size_t size, unsigned msg_flags)
 {
-	int sent = drbd_send(mdev->tconn, mdev->tconn->data.socket, kmap(page) + offset, size, msg_flags);
+	struct socket *socket;
+	void *addr;
+	int err;
+
+	socket = mdev->tconn->data.socket;
+	addr = kmap(page) + offset;
+	err = drbd_send_all(mdev->tconn, socket, addr, size, msg_flags);
 	kunmap(page);
-	if (sent == size)
-		mdev->send_cnt += size>>9;
-	return sent == size;
+	if (!err)
+		mdev->send_cnt += size >> 9;
+	return err;
 }
 
 static int _drbd_send_page(struct drbd_conf *mdev, struct page *page,
@@ -1428,7 +1434,7 @@ static int _drbd_send_page(struct drbd_conf *mdev, struct page *page,
 	 * __page_cache_release a page that would actually still be referenced
 	 * by someone, leading to some obscure delayed Oops somewhere else. */
 	if (disable_sendpage || (page_count(page) < 1) || PageSlab(page))
-		return _drbd_no_send_page(mdev, page, offset, size, msg_flags);
+		return !_drbd_no_send_page(mdev, page, offset, size, msg_flags);
 
 	msg_flags |= MSG_NOSIGNAL;
 	drbd_update_congested(mdev->tconn);
@@ -1467,9 +1473,9 @@ static int _drbd_send_bio(struct drbd_conf *mdev, struct bio *bio)
 	int i;
 	/* hint all but last page with MSG_MORE */
 	__bio_for_each_segment(bvec, bio, i, 0) {
-		if (!_drbd_no_send_page(mdev, bvec->bv_page,
-				     bvec->bv_offset, bvec->bv_len,
-				     i == bio->bi_vcnt -1 ? 0 : MSG_MORE))
+		if (_drbd_no_send_page(mdev, bvec->bv_page,
+				       bvec->bv_offset, bvec->bv_len,
+				       i == bio->bi_vcnt -1 ? 0 : MSG_MORE))
 			return 0;
 	}
 	return 1;
-- 
1.7.4.1

