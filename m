Return-Path: <jakobkoschel@gmail.com>
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
	[209.85.208.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E6CCA4201DC
	for <drbd-dev@lists.linbit.com>; Fri,  1 Apr 2022 00:05:54 +0200 (CEST)
Received: by mail-ed1-f53.google.com with SMTP id h4so883922edr.3
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2022 15:05:54 -0700 (PDT)
From: Jakob Koschel <jakobkoschel@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri,  1 Apr 2022 00:03:48 +0200
Message-Id: <20220331220349.885126-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, "Bos,
	H.J." <h.j.bos@vu.nl>, Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	linux-block@vger.kernel.org, Cristiano Giuffrida <c.giuffrida@vu.nl>,
	Jakob Koschel <jakobkoschel@gmail.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Mike Rapoport <rppt@kernel.org>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/2] drbd: remove usage of list iterator variable
	after loop for list_for_each_entry_safe_from()
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

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to iterate through the list [1].

Since that variable should not be used past the loop iteration, a
separate variable is used to 'remember the current location within the
loop'.

To either continue iterating from that position or skip the iteration
(if the previous iteration was complete) list_prepare_entry() is used.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 96881d5babd9..9676a1d214bc 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -171,7 +171,7 @@ void tl_release(struct drbd_connection *connection, unsigned int barrier_nr,
 		unsigned int set_size)
 {
 	struct drbd_request *r;
-	struct drbd_request *req = NULL;
+	struct drbd_request *req = NULL, *tmp = NULL;
 	int expect_epoch = 0;
 	int expect_size = 0;
 
@@ -225,8 +225,11 @@ void tl_release(struct drbd_connection *connection, unsigned int barrier_nr,
 	 * to catch requests being barrier-acked "unexpectedly".
 	 * It usually should find the same req again, or some READ preceding it. */
 	list_for_each_entry(req, &connection->transfer_log, tl_requests)
-		if (req->epoch == expect_epoch)
+		if (req->epoch == expect_epoch) {
+			tmp = req;
 			break;
+		}
+	req = list_prepare_entry(tmp, &connection->transfer_log, tl_requests);
 	list_for_each_entry_safe_from(req, r, &connection->transfer_log, tl_requests) {
 		if (req->epoch != expect_epoch)
 			break;

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

