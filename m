Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E3A09426845
	for <drbd-dev@lists.linbit.com>; Thu, 28 Sep 2023 11:39:02 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
	ffacd0b85a97d-323168869daso9890771f8f.2
	for <drbd-dev@lists.linbit.com>; Thu, 28 Sep 2023 02:39:02 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 28 Sep 2023 11:38:50 +0200
Message-ID: <20230928093852.676786-4-christoph.boehmwalder@linbit.com>
In-Reply-To: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
References: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Lars Ellenberg <lars@linbit.com>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/5] drbd: Move connection independent work from
	"sender" to "worker"
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

Originally-from: Andreas Gruenbacher <agruen@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 drivers/block/drbd/drbd_req.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0c9f54197768..6e21df44b5aa 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5890,7 +5890,7 @@ static int got_OVResult(struct drbd_connection *connection, struct packet_info *
 		if (dw) {
 			dw->w.cb = w_ov_finished;
 			dw->device = device;
-			drbd_queue_work(&peer_device->connection->sender_work, &dw->w);
+			drbd_queue_work(&device->resource->work, &dw->w);
 		} else {
 			drbd_err(device, "kmalloc(dw) failed.");
 			ov_out_of_sync_print(peer_device);
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index cd56fd0f3b06..fbb47138a52b 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -823,8 +823,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 
 		get_ldev(device); /* always succeeds in this call path */
 		req->w.cb = w_restart_disk_io;
-		drbd_queue_work(&connection->sender_work,
-				&req->w);
+		drbd_queue_work(&device->resource->work, &req->w);
 		break;
 
 	case RESEND:
-- 
2.41.0

