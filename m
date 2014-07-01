Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 31B58101AC79
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jul 2014 18:16:51 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  1 Jul 2014 18:16:37 +0200
Message-Id: <1404231410-29852-8-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
References: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/20] drbd: Limit the time we are waiting for
	the first packet on an accepted socket
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

Before the patch
'drbd: Keep the listening socket open while trying to connect to the peer'

the newly created socket inherited the receive timeout from the listen
socket. The listen socket had a receive timeout of connect-intervall
+- 30% random jitter.

The real issue is that after the mentioned patch we had no timeout at all.
Now use 4 times the ping-timeout.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index d326af6..7da83f3 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -791,8 +791,18 @@ static int receive_first_packet(struct drbd_connection *connection, struct socke
 {
 	unsigned int header_size = drbd_header_size(connection);
 	struct packet_info pi;
+	struct net_conf *nc;
 	int err;
 
+	rcu_read_lock();
+	nc = rcu_dereference(connection->net_conf);
+	if (!nc) {
+		rcu_read_unlock();
+		return -EIO;
+	}
+	sock->sk->sk_rcvtimeo = nc->ping_timeo * 4 * HZ / 10;
+	rcu_read_unlock();
+
 	err = drbd_recv_short(sock, connection->data.rbuf, header_size, 0);
 	if (err != header_size) {
 		if (err >= 0)
-- 
1.9.1

