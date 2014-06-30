Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 69DF8101AC7A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Jun 2014 17:53:08 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 30 Jun 2014 17:53:01 +0200
Message-Id: <1404143587-24344-13-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404143587-24344-1-git-send-email-philipp.reisner@linbit.com>
References: <1404143587-24344-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/18] drbd: trigger tcp_push_pending_frames()
	for PING and PING_ACK
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

This should reduce latency for such in-DRBD-protocol "pings",
and may help reduce spurious disconnect/reconnect cycles due to
 "PingAck did not arrive in time."

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 8e0813d..77d34a6 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -662,6 +662,11 @@ static int __send_command(struct drbd_connection *connection, int vnr,
 			    msg_flags);
 	if (data && !err)
 		err = drbd_send_all(connection, sock->socket, data, size, 0);
+	/* DRBD protocol "pings" are latency critical.
+	 * This is supposed to trigger tcp_push_pending_frames() */
+	if (!err && (cmd == P_PING || cmd == P_PING_ACK))
+		drbd_tcp_nodelay(sock->socket);
+
 	return err;
 }
 
-- 
1.9.1

