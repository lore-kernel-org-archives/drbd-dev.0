Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:20 +0200
Message-Id: <1314284934-17999-85-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 084/118] drbd: Converted decode_header() from
	mdev to tconn
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
 drivers/block/drbd/drbd_receiver.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index deb0837..66b35e9 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -930,7 +930,7 @@ out_release_sockets:
 	return -1;
 }
 
-static bool decode_header(struct drbd_conf *mdev, struct p_header *h, struct packet_info *pi)
+static bool decode_header(struct drbd_tconn *tconn, struct p_header *h, struct packet_info *pi)
 {
 	u32 vol_n_len;
 
@@ -943,7 +943,7 @@ static bool decode_header(struct drbd_conf *mdev, struct p_header *h, struct pac
 		pi->size = vol_n_len & 0x00ffffff;
 		pi->vnr  = vol_n_len >> 24;
 	} else {
-		dev_err(DEV, "magic?? on data m: 0x%08x c: %d l: %d\n",
+		conn_err(tconn, "magic?? on data m: 0x%08x c: %d l: %d\n",
 		    be32_to_cpu(h->h80.magic),
 		    be16_to_cpu(h->h80.command),
 		    be16_to_cpu(h->h80.length));
@@ -964,7 +964,7 @@ static int drbd_recv_header(struct drbd_conf *mdev, struct packet_info *pi)
 		return false;
 	}
 
-	r = decode_header(mdev, h, pi);
+	r = decode_header(mdev->tconn, h, pi);
 	mdev->tconn->last_received = jiffies;
 
 	return r;
@@ -4648,7 +4648,7 @@ int drbd_asender(struct drbd_thread *thi)
 		}
 
 		if (received == expect && cmd == NULL) {
-			if (!decode_header(mdev, h, &pi))
+			if (!decode_header(mdev->tconn, h, &pi))
 				goto reconnect;
 			cmd = get_asender_cmd(pi.cmd);
 			if (unlikely(cmd == NULL)) {
-- 
1.7.4.1

