Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2801C421740
	for <drbd-dev@lists.linbit.com>; Wed, 15 Feb 2023 17:32:10 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id o15so16448150wrc.9
	for <drbd-dev@lists.linbit.com>; Wed, 15 Feb 2023 08:32:10 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 15 Feb 2023 17:32:00 +0100
Message-Id: <20230215163204.2856631-4-christoph.boehmwalder@linbit.com>
In-Reply-To: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
References: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Andreas Gruenbacher <agruen@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/7] drbd: INFO_bm_xfer_stats(): Pass a peer
	device argument
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

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h      | 4 ++--
 drivers/block/drbd/drbd_main.c     | 2 +-
 drivers/block/drbd/drbd_receiver.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 63919781fe30..8b4d06e10365 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -126,8 +126,8 @@ struct bm_xfer_ctx {
 	unsigned bytes[2];
 };
 
-extern void INFO_bm_xfer_stats(struct drbd_device *device,
-		const char *direction, struct bm_xfer_ctx *c);
+extern void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
+			       const char *direction, struct bm_xfer_ctx *c);
 
 static inline void bm_xfer_ctx_bit_to_word_offset(struct bm_xfer_ctx *c)
 {
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 5d98017497e4..6f2955f2dcc9 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1247,7 +1247,7 @@ send_bitmap_rle_or_plain(struct drbd_peer_device *device, struct bm_xfer_ctx *c)
 	}
 	if (!err) {
 		if (len == 0) {
-			INFO_bm_xfer_stats(device, "send", c);
+			INFO_bm_xfer_stats(peer_device, "send", c);
 			return 0;
 		} else
 			return 1;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 424748f6e4fa..aa896db1767d 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4766,11 +4766,11 @@ decode_bitmap_c(struct drbd_peer_device *peer_device,
 	return -EIO;
 }
 
-void INFO_bm_xfer_stats(struct drbd_device *device,
+void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
 		const char *direction, struct bm_xfer_ctx *c)
 {
 	/* what would it take to transfer it "plaintext" */
-	unsigned int header_size = drbd_header_size(first_peer_device(device)->connection);
+	unsigned int header_size = drbd_header_size(peer_device->connection);
 	unsigned int data_size = DRBD_SOCKET_BUFFER_SIZE - header_size;
 	unsigned int plain =
 		header_size * (DIV_ROUND_UP(c->bm_words, data_size) + 1) +
@@ -4794,7 +4794,7 @@ void INFO_bm_xfer_stats(struct drbd_device *device,
 		r = 1000;
 
 	r = 1000 - r;
-	drbd_info(device, "%s bitmap stats [Bytes(packets)]: plain %u(%u), RLE %u(%u), "
+	drbd_info(peer_device, "%s bitmap stats [Bytes(packets)]: plain %u(%u), RLE %u(%u), "
 	     "total %u; compression: %u.%u%%\n",
 			direction,
 			c->bytes[1], c->packets[1],
@@ -4872,7 +4872,7 @@ static int receive_bitmap(struct drbd_connection *connection, struct packet_info
 			goto out;
 	}
 
-	INFO_bm_xfer_stats(device, "receive", &c);
+	INFO_bm_xfer_stats(peer_device, "receive", &c);
 
 	if (device->state.conn == C_WF_BITMAP_T) {
 		enum drbd_state_rv rv;
-- 
2.39.1

