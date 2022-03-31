Return-Path: <jakobkoschel@gmail.com>
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
	[209.85.208.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B964E4201DC
	for <drbd-dev@lists.linbit.com>; Fri,  1 Apr 2022 00:05:55 +0200 (CEST)
Received: by mail-ed1-f45.google.com with SMTP id b15so880925edn.4
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2022 15:05:55 -0700 (PDT)
From: Jakob Koschel <jakobkoschel@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri,  1 Apr 2022 00:03:49 +0200
Message-Id: <20220331220349.885126-2-jakobkoschel@gmail.com>
In-Reply-To: <20220331220349.885126-1-jakobkoschel@gmail.com>
References: <20220331220349.885126-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, "Bos,
	H.J." <h.j.bos@vu.nl>, Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	linux-block@vger.kernel.org, Cristiano Giuffrida <c.giuffrida@vu.nl>,
	Jakob Koschel <jakobkoschel@gmail.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Mike Rapoport <rppt@kernel.org>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/2] drbd: remove check of list iterator against
	head past the loop body
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

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/block/drbd/drbd_req.c | 42 ++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index c04394518b07..b2571dc77fe6 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -332,17 +332,21 @@ static void set_if_null_req_next(struct drbd_peer_device *peer_device, struct dr
 static void advance_conn_req_next(struct drbd_peer_device *peer_device, struct drbd_request *req)
 {
 	struct drbd_connection *connection = peer_device ? peer_device->connection : NULL;
+	struct drbd_request *iter = req;
 	if (!connection)
 		return;
 	if (connection->req_next != req)
 		return;
-	list_for_each_entry_continue(req, &connection->transfer_log, tl_requests) {
-		const unsigned s = req->rq_state;
-		if (s & RQ_NET_QUEUED)
+
+	req = NULL;
+	list_for_each_entry_continue(iter, &connection->transfer_log, tl_requests) {
+		const unsigned int s = iter->rq_state;
+
+		if (s & RQ_NET_QUEUED) {
+			req = iter;
 			break;
+		}
 	}
-	if (&req->tl_requests == &connection->transfer_log)
-		req = NULL;
 	connection->req_next = req;
 }
 
@@ -358,17 +362,21 @@ static void set_if_null_req_ack_pending(struct drbd_peer_device *peer_device, st
 static void advance_conn_req_ack_pending(struct drbd_peer_device *peer_device, struct drbd_request *req)
 {
 	struct drbd_connection *connection = peer_device ? peer_device->connection : NULL;
+	struct drbd_request *iter = req;
 	if (!connection)
 		return;
 	if (connection->req_ack_pending != req)
 		return;
-	list_for_each_entry_continue(req, &connection->transfer_log, tl_requests) {
-		const unsigned s = req->rq_state;
-		if ((s & RQ_NET_SENT) && (s & RQ_NET_PENDING))
+
+	req = NULL;
+	list_for_each_entry_continue(iter, &connection->transfer_log, tl_requests) {
+		const unsigned int s = iter->rq_state;
+
+		if ((s & RQ_NET_SENT) && (s & RQ_NET_PENDING)) {
+			req = iter;
 			break;
+		}
 	}
-	if (&req->tl_requests == &connection->transfer_log)
-		req = NULL;
 	connection->req_ack_pending = req;
 }
 
@@ -384,17 +392,21 @@ static void set_if_null_req_not_net_done(struct drbd_peer_device *peer_device, s
 static void advance_conn_req_not_net_done(struct drbd_peer_device *peer_device, struct drbd_request *req)
 {
 	struct drbd_connection *connection = peer_device ? peer_device->connection : NULL;
+	struct drbd_request *iter = req;
 	if (!connection)
 		return;
 	if (connection->req_not_net_done != req)
 		return;
-	list_for_each_entry_continue(req, &connection->transfer_log, tl_requests) {
-		const unsigned s = req->rq_state;
-		if ((s & RQ_NET_SENT) && !(s & RQ_NET_DONE))
+
+	req = NULL;
+	list_for_each_entry_continue(iter, &connection->transfer_log, tl_requests) {
+		const unsigned int s = iter->rq_state;
+
+		if ((s & RQ_NET_SENT) && !(s & RQ_NET_DONE)) {
+			req = iter;
 			break;
+		}
 	}
-	if (&req->tl_requests == &connection->transfer_log)
-		req = NULL;
 	connection->req_not_net_done = req;
 }
 
-- 
2.25.1

