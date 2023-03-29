Return-Path: <dhowells@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 379F74202EC
	for <drbd-dev@lists.linbit.com>; Wed, 29 Mar 2023 16:23:03 +0200 (CEST)
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Date: Wed, 29 Mar 2023 15:13:53 +0100
Message-Id: <20230329141354.516864-48-dhowells@redhat.com>
In-Reply-To: <20230329141354.516864-1-dhowells@redhat.com>
References: <20230329141354.516864-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
	Chuck Lever III <chuck.lever@oracle.com>,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [RFC PATCH v2 47/48] drdb: Send an entire bio in a
	single sendmsg
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

Since _drdb_sendpage() is now using sendmsg to send the pages rather
sendpage, pass the entire bio in one go using a bvec iterator instead of
doing it piecemeal.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Philipp Reisner <philipp.reisner@linbit.com>
cc: Lars Ellenberg <lars.ellenberg@linbit.com>
cc: "Christoph Böhmwalder" <christoph.boehmwalder@linbit.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: drbd-dev@lists.linbit.com
cc: linux-block@vger.kernel.org
cc: netdev@vger.kernel.org
---
 drivers/block/drbd/drbd_main.c | 77 +++++++++++-----------------------
 1 file changed, 25 insertions(+), 52 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index e5f90abd29b6..ab63d6138407 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1512,28 +1512,15 @@ static void drbd_update_congested(struct drbd_connection *connection)
  * As a workaround, we disable sendpage on pages
  * with page_count == 0 or PageSlab.
  */
-static int _drbd_no_send_page(struct drbd_peer_device *peer_device, struct page *page,
-			      int offset, size_t size, unsigned msg_flags)
-{
-	struct socket *socket;
-	void *addr;
-	int err;
-
-	socket = peer_device->connection->data.socket;
-	addr = kmap(page) + offset;
-	err = drbd_send_all(peer_device->connection, socket, addr, size, msg_flags);
-	kunmap(page);
-	if (!err)
-		peer_device->device->send_cnt += size >> 9;
-	return err;
-}
-
-static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *page,
-		    int offset, size_t size, unsigned msg_flags)
+static int _drbd_send_pages(struct drbd_peer_device *peer_device,
+			    struct iov_iter *iter, unsigned msg_flags)
 {
 	struct socket *socket = peer_device->connection->data.socket;
-	struct bio_vec bvec;
-	struct msghdr msg = { .msg_flags = msg_flags, };
+	struct msghdr msg = {
+		.msg_flags	= msg_flags | MSG_NOSIGNAL,
+		.msg_iter	= *iter,
+	};
+	size_t size = iov_iter_count(iter);
 	int err = -EIO;
 
 	/* e.g. XFS meta- & log-data is in slab pages, which have a
@@ -1542,11 +1529,8 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 	 * put_page(); and would cause either a VM_BUG directly, or
 	 * __page_cache_release a page that would actually still be referenced
 	 * by someone, leading to some obscure delayed Oops somewhere else. */
-	if (!drbd_disable_sendpage && sendpage_ok(page))
-		msg.msg_flags |= MSG_NOSIGNAL | MSG_SPLICE_PAGES;
-
-	bvec_set_page(&bvec, page, offset, size);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
+	if (drbd_disable_sendpage)
+		msg.msg_flags &= ~(MSG_NOSIGNAL | MSG_SPLICE_PAGES);
 
 	drbd_update_congested(peer_device->connection);
 	do {
@@ -1577,39 +1561,22 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 
 static int _drbd_send_bio(struct drbd_peer_device *peer_device, struct bio *bio)
 {
-	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct iov_iter iter;
 
-	/* hint all but last page with MSG_MORE */
-	bio_for_each_segment(bvec, bio, iter) {
-		int err;
+	iov_iter_bvec(&iter, ITER_SOURCE, bio->bi_io_vec, bio->bi_vcnt,
+		      bio->bi_iter.bi_size);
 
-		err = _drbd_no_send_page(peer_device, bvec.bv_page,
-					 bvec.bv_offset, bvec.bv_len,
-					 bio_iter_last(bvec, iter)
-					 ? 0 : MSG_MORE);
-		if (err)
-			return err;
-	}
-	return 0;
+	return _drbd_send_pages(peer_device, &iter, 0);
 }
 
 static int _drbd_send_zc_bio(struct drbd_peer_device *peer_device, struct bio *bio)
 {
-	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct iov_iter iter;
 
-	/* hint all but last page with MSG_MORE */
-	bio_for_each_segment(bvec, bio, iter) {
-		int err;
+	iov_iter_bvec(&iter, ITER_SOURCE, bio->bi_io_vec, bio->bi_vcnt,
+		      bio->bi_iter.bi_size);
 
-		err = _drbd_send_page(peer_device, bvec.bv_page,
-				      bvec.bv_offset, bvec.bv_len,
-				      bio_iter_last(bvec, iter) ? 0 : MSG_MORE);
-		if (err)
-			return err;
-	}
-	return 0;
+	return _drbd_send_pages(peer_device, &iter, MSG_SPLICE_PAGES);
 }
 
 static int _drbd_send_zc_ee(struct drbd_peer_device *peer_device,
@@ -1621,10 +1588,16 @@ static int _drbd_send_zc_ee(struct drbd_peer_device *peer_device,
 
 	/* hint all but last page with MSG_MORE */
 	page_chain_for_each(page) {
+		struct iov_iter iter;
+		struct bio_vec bvec;
 		unsigned l = min_t(unsigned, len, PAGE_SIZE);
 
-		err = _drbd_send_page(peer_device, page, 0, l,
-				      page_chain_next(page) ? MSG_MORE : 0);
+		bvec_set_page(&bvec, page, 0, l);
+		iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, l);
+
+		err = _drbd_send_pages(peer_device, &iter,
+				       MSG_SPLICE_PAGES |
+				       (page_chain_next(page) ? MSG_MORE : 0));
 		if (err)
 			return err;
 		len -= l;

