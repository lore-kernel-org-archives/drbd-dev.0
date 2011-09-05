Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:20 +0200
Message-Id: <1315223145-20640-30-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 29/54] drbd: _drbd_send_page(): Return 0 upon
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
 drivers/block/drbd/drbd_main.c |   44 ++++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 1a8c3db..39d1cd1 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1423,9 +1423,10 @@ static int _drbd_no_send_page(struct drbd_conf *mdev, struct page *page,
 static int _drbd_send_page(struct drbd_conf *mdev, struct page *page,
 		    int offset, size_t size, unsigned msg_flags)
 {
+	struct socket *socket = mdev->tconn->data.socket;
 	mm_segment_t oldfs = get_fs();
-	int sent, ok;
 	int len = size;
+	int err = -EIO;
 
 	/* e.g. XFS meta- & log-data is in slab pages, which have a
 	 * page_count of 0 and/or have PageSlab() set.
@@ -1434,25 +1435,25 @@ static int _drbd_send_page(struct drbd_conf *mdev, struct page *page,
 	 * __page_cache_release a page that would actually still be referenced
 	 * by someone, leading to some obscure delayed Oops somewhere else. */
 	if (disable_sendpage || (page_count(page) < 1) || PageSlab(page))
-		return !_drbd_no_send_page(mdev, page, offset, size, msg_flags);
+		return _drbd_no_send_page(mdev, page, offset, size, msg_flags);
 
 	msg_flags |= MSG_NOSIGNAL;
 	drbd_update_congested(mdev->tconn);
 	set_fs(KERNEL_DS);
 	do {
-		sent = mdev->tconn->data.socket->ops->sendpage(mdev->tconn->data.socket, page,
-							offset, len,
-							msg_flags);
-		if (sent == -EAGAIN) {
-			if (we_should_drop_the_connection(mdev->tconn,
-							  mdev->tconn->data.socket))
-				break;
-			else
-				continue;
-		}
+		int sent;
+
+		sent = socket->ops->sendpage(socket, page, offset, len, msg_flags);
 		if (sent <= 0) {
+			if (sent == -EAGAIN) {
+				if (we_should_drop_the_connection(mdev->tconn, socket))
+					break;
+				continue;
+			}
 			dev_warn(DEV, "%s: size=%d len=%d sent=%d\n",
 			     __func__, (int)size, len, sent);
+			if (sent < 0)
+				err = sent;
 			break;
 		}
 		len    -= sent;
@@ -1461,10 +1462,11 @@ static int _drbd_send_page(struct drbd_conf *mdev, struct page *page,
 	set_fs(oldfs);
 	clear_bit(NET_CONGESTED, &mdev->tconn->flags);
 
-	ok = (len == 0);
-	if (likely(ok))
-		mdev->send_cnt += size>>9;
-	return ok;
+	if (len == 0) {
+		err = 0;
+		mdev->send_cnt += size >> 9;
+	}
+	return err;
 }
 
 static int _drbd_send_bio(struct drbd_conf *mdev, struct bio *bio)
@@ -1487,9 +1489,9 @@ static int _drbd_send_zc_bio(struct drbd_conf *mdev, struct bio *bio)
 	int i;
 	/* hint all but last page with MSG_MORE */
 	__bio_for_each_segment(bvec, bio, i, 0) {
-		if (!_drbd_send_page(mdev, bvec->bv_page,
-				     bvec->bv_offset, bvec->bv_len,
-				     i == bio->bi_vcnt -1 ? 0 : MSG_MORE))
+		if (_drbd_send_page(mdev, bvec->bv_page,
+				    bvec->bv_offset, bvec->bv_len,
+				    i == bio->bi_vcnt -1 ? 0 : MSG_MORE))
 			return 0;
 	}
 	return 1;
@@ -1504,8 +1506,8 @@ static int _drbd_send_zc_ee(struct drbd_conf *mdev,
 	/* hint all but last page with MSG_MORE */
 	page_chain_for_each(page) {
 		unsigned l = min_t(unsigned, len, PAGE_SIZE);
-		if (!_drbd_send_page(mdev, page, 0, l,
-				page_chain_next(page) ? MSG_MORE : 0))
+		if (_drbd_send_page(mdev, page, 0, l,
+				    page_chain_next(page) ? MSG_MORE : 0))
 			return 0;
 		len -= l;
 	}
-- 
1.7.4.1

