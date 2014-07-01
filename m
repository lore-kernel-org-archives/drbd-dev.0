Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 87E941019A35
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jul 2014 18:16:51 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  1 Jul 2014 18:16:43 +0200
Message-Id: <1404231410-29852-14-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
References: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/20] drbd: improve resync request throttling
	due to sendbuf size
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

If we throttle resync because the socket sendbuffer is filling up,
tell TCP about it, so it may expand the sendbuffer for us.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 6532a69..0b5e429 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -592,7 +592,7 @@ static int make_resync_request(struct drbd_device *const device, int cancel)
 	const sector_t capacity = drbd_get_capacity(device->this_bdev);
 	int max_bio_size;
 	int number, rollback_i, size;
-	int align, queued, sndbuf;
+	int align, requeue = 0;
 	int i = 0;
 
 	if (unlikely(cancel))
@@ -619,17 +619,22 @@ static int make_resync_request(struct drbd_device *const device, int cancel)
 		goto requeue;
 
 	for (i = 0; i < number; i++) {
-		/* Stop generating RS requests, when half of the send buffer is filled */
+		/* Stop generating RS requests when half of the send buffer is filled,
+		 * but notify TCP that we'd like to have more space. */
 		mutex_lock(&connection->data.mutex);
 		if (connection->data.socket) {
-			queued = connection->data.socket->sk->sk_wmem_queued;
-			sndbuf = connection->data.socket->sk->sk_sndbuf;
-		} else {
-			queued = 1;
-			sndbuf = 0;
-		}
+			struct sock *sk = connection->data.socket->sk;
+			int queued = sk->sk_wmem_queued;
+			int sndbuf = sk->sk_sndbuf;
+			if (queued > sndbuf / 2) {
+				requeue = 1;
+				if (sk->sk_socket)
+					set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+			}
+		} else
+			requeue = 1;
 		mutex_unlock(&connection->data.mutex);
-		if (queued > sndbuf / 2)
+		if (requeue)
 			goto requeue;
 
 next_sector:
-- 
1.9.1

