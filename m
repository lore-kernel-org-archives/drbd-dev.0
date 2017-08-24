Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wr0-f173.google.com (mail-wr0-f173.google.com
	[209.85.128.173])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8D634105801B
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:30:49 +0200 (CEST)
Received: by mail-wr0-f173.google.com with SMTP id a47so2079811wra.4
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:30:49 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:13 +0200
Message-Id: <1503609794-13233-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/17] drbd: abort drbd_start_resync if there is
	no connection
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

From: Roland Kammerer <roland.kammerer@linbit.com>

This was found by a static analysis tool. While highly unlikely, be sure
to return without dereferencing the NULL pointer.

Reported-by: Shaobo <shaobo@cs.utah.edu>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index f0717a9..03471b3 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1756,6 +1756,11 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 		return;
 	}
 
+	if (!connection) {
+		drbd_err(device, "No connection to peer, aborting!\n");
+		return;
+	}
+
 	if (!test_bit(B_RS_H_DONE, &device->flags)) {
 		if (side == C_SYNC_TARGET) {
 			/* Since application IO was locked out during C_WF_BITMAP_T and
-- 
2.7.4

