Return-Path: <dhowells@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5B44D4205F5
	for <drbd-dev@lists.linbit.com>; Sat, 17 Jun 2023 14:12:53 +0200 (CEST)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Date: Sat, 17 Jun 2023 13:11:42 +0100
Message-ID: <20230617121146.716077-14-dhowells@redhat.com>
In-Reply-To: <20230617121146.716077-1-dhowells@redhat.com>
References: <20230617121146.716077-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
	Eric Dumazet <edumazet@google.com>, Matthew Wilcox <willy@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH net-next v2 13/17] drbd: Use
	sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
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

Use sendmsg() conditionally with MSG_SPLICE_PAGES in _drbd_send_page()
rather than calling sendpage() or _drbd_no_send_page().

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

Notes:
    ver #2)
     - Wrap lines at 80.

 drivers/block/drbd/drbd_main.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 83987e7a5ef2..8a01a18a2550 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1540,7 +1540,8 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 		    int offset, size_t size, unsigned msg_flags)
 {
 	struct socket *socket = peer_device->connection->data.socket;
-	int len = size;
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = msg_flags, };
 	int err = -EIO;
 
 	/* e.g. XFS meta- & log-data is in slab pages, which have a
@@ -1549,33 +1550,35 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 	 * put_page(); and would cause either a VM_BUG directly, or
 	 * __page_cache_release a page that would actually still be referenced
 	 * by someone, leading to some obscure delayed Oops somewhere else. */
-	if (drbd_disable_sendpage || !sendpage_ok(page))
-		return _drbd_no_send_page(peer_device, page, offset, size, msg_flags);
+	if (!drbd_disable_sendpage && sendpage_ok(page))
+		msg.msg_flags |= MSG_NOSIGNAL | MSG_SPLICE_PAGES;
+
+	bvec_set_page(&bvec, page, offset, size);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
-	msg_flags |= MSG_NOSIGNAL;
 	drbd_update_congested(peer_device->connection);
 	do {
 		int sent;
 
-		sent = socket->ops->sendpage(socket, page, offset, len, msg_flags);
+		sent = sock_sendmsg(socket, &msg);
 		if (sent <= 0) {
 			if (sent == -EAGAIN) {
 				if (we_should_drop_the_connection(peer_device->connection, socket))
 					break;
 				continue;
 			}
-			drbd_warn(peer_device->device, "%s: size=%d len=%d sent=%d\n",
-			     __func__, (int)size, len, sent);
+			drbd_warn(peer_device->device, "%s: size=%d len=%zu sent=%d\n",
+				  __func__, (int)size, msg_data_left(&msg),
+				  sent);
 			if (sent < 0)
 				err = sent;
 			break;
 		}
-		len    -= sent;
-		offset += sent;
-	} while (len > 0 /* THINK && device->cstate >= C_CONNECTED*/);
+	} while (msg_data_left(&msg)
+		 /* THINK && device->cstate >= C_CONNECTED*/);
 	clear_bit(NET_CONGESTED, &peer_device->connection->flags);
 
-	if (len == 0) {
+	if (!msg_data_left(&msg)) {
 		err = 0;
 		peer_device->device->send_cnt += size >> 9;
 	}

