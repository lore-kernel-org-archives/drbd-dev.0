Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:16 +0200
Message-Id: <1314284934-17999-81-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 080/118] drbd: Converted drbd_recv_fp() from mdev
	to tconn
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2e1972e..080c91b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -704,9 +704,9 @@ static int drbd_send_fp(struct drbd_tconn *tconn, struct socket *sock, enum drbd
 	return _conn_send_cmd(tconn, 0, sock, cmd, h, sizeof(*h), 0);
 }
 
-static enum drbd_packet drbd_recv_fp(struct drbd_conf *mdev, struct socket *sock)
+static enum drbd_packet drbd_recv_fp(struct drbd_tconn *tconn, struct socket *sock)
 {
-	struct p_header80 *h = &mdev->tconn->data.rbuf.header.h80;
+	struct p_header80 *h = &tconn->data.rbuf.header.h80;
 	int rr;
 
 	rr = drbd_recv_short(sock, h, sizeof(*h), 0);
@@ -802,7 +802,7 @@ static int drbd_connect(struct drbd_conf *mdev)
 retry:
 		s = drbd_wait_for_connect(mdev->tconn);
 		if (s) {
-			try = drbd_recv_fp(mdev, s);
+			try = drbd_recv_fp(mdev->tconn, s);
 			drbd_socket_okay(&sock);
 			drbd_socket_okay(&msock);
 			switch (try) {
-- 
1.7.4.1

