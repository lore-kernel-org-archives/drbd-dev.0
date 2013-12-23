Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2D84D105B0DA
	for <drbd-dev@lists.linbit.com>; Mon, 23 Dec 2013 22:50:59 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 23 Dec 2013 22:50:54 +0100
Message-Id: <1387835456-29695-26-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
References: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 25/27] drbd: Remove unused parameter of
	wire_flags_to_bio()
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

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 5c0239e..b7b05c9 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2029,7 +2029,7 @@ static int wait_for_and_update_peer_seq(struct drbd_peer_device *peer_device, co
 /* see also bio_flags_to_wire()
  * DRBD_REQ_*, because we need to semantically map the flags to data packet
  * flags and back. We may replicate to other kernel versions. */
-static unsigned long wire_flags_to_bio(struct drbd_device *device, u32 dpf)
+static unsigned long wire_flags_to_bio(u32 dpf)
 {
 	return  (dpf & DP_RW_SYNC ? REQ_SYNC : 0) |
 		(dpf & DP_FUA ? REQ_FUA : 0) |
@@ -2215,7 +2215,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	peer_req->w.cb = e_end_block;
 
 	dp_flags = be32_to_cpu(p->dp_flags);
-	rw |= wire_flags_to_bio(device, dp_flags);
+	rw |= wire_flags_to_bio(dp_flags);
 	if (peer_req->pages == NULL) {
 		D_ASSERT(device, peer_req->i.size == 0);
 		D_ASSERT(device, dp_flags & DP_FLUSH);
-- 
1.7.9.5

