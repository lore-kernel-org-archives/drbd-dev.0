Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:29 +0200
Message-Id: <1315223145-20640-39-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 38/54] drbd: decode_header(): Return 0 upon
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
 drivers/block/drbd/drbd_receiver.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 8000637..47c9c4d 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -948,7 +948,7 @@ out_release_sockets:
 	return -1;
 }
 
-static bool decode_header(struct drbd_tconn *tconn, struct p_header *h, struct packet_info *pi)
+static int decode_header(struct drbd_tconn *tconn, struct p_header *h, struct packet_info *pi)
 {
 	u32 vol_n_len;
 
@@ -966,9 +966,9 @@ static bool decode_header(struct drbd_tconn *tconn, struct p_header *h, struct p
 		    be32_to_cpu(h->h80.magic),
 		    be16_to_cpu(h->h80.command),
 		    be16_to_cpu(h->h80.length));
-		return false;
+		return -EINVAL;
 	}
-	return true;
+	return 0;
 }
 
 static int drbd_recv_header(struct drbd_tconn *tconn, struct packet_info *pi)
@@ -983,7 +983,7 @@ static int drbd_recv_header(struct drbd_tconn *tconn, struct packet_info *pi)
 		return false;
 	}
 
-	r = decode_header(tconn, h, pi);
+	r = !decode_header(tconn, h, pi);
 	tconn->last_received = jiffies;
 
 	return r;
@@ -4843,7 +4843,7 @@ int drbd_asender(struct drbd_thread *thi)
 		}
 
 		if (received == expect && cmd == NULL) {
-			if (!decode_header(tconn, h, &pi))
+			if (decode_header(tconn, h, &pi))
 				goto reconnect;
 			cmd = &asender_tbl[pi.cmd];
 			if (pi.cmd >= ARRAY_SIZE(asender_tbl) || !cmd) {
-- 
1.7.4.1

