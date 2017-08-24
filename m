Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com
	[209.85.128.180])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5349C105647D
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:28:47 +0200 (CEST)
Received: by mail-wr0-f180.google.com with SMTP id p8so2123189wrf.2
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:28:47 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:01 +0200
Message-Id: <1503609794-13233-5-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/17] drbd: Send P_NEG_ACK upon write error in
	protocol != C
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

In protocol != C, we forgot to send the P_NEG_ACK for failing writes.

Once we no longer submit to local disk, because we already "detached",
due to the typical "on-io-error detach;" config setting,
we already send the neg acks right away.

Only those requests that have been submitted,
and have been error-completed by the local disk,
would forget to send the neg-ack,
and only in asynchronous replication (protocol != C).
Unless this happened during resync,
where we already always send acks, regardless of protocol.

The primary side needs the P_NEG_ACK in order to mark
the affected block(s) for resync in its out-of-sync bitmap.

If the blocks in question are not re-written again,
we may miss to resync them later, causing data inconsistencies.

This patch will always send the neg-acks, and also at least try to
persist the out-of-sync status on the local node already.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 2745db2..72cb0bd 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -128,6 +128,14 @@ void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __releases(l
 	block_id = peer_req->block_id;
 	peer_req->flags &= ~EE_CALL_AL_COMPLETE_IO;
 
+	if (peer_req->flags & EE_WAS_ERROR) {
+		/* In protocol != C, we usually do not send write acks.
+		 * In case of a write error, send the neg ack anyways. */
+		if (!__test_and_set_bit(__EE_SEND_WRITE_ACK, &peer_req->flags))
+			inc_unacked(device);
+		drbd_set_out_of_sync(device, peer_req->i.sector, peer_req->i.size);
+	}
+
 	spin_lock_irqsave(&device->resource->req_lock, flags);
 	device->writ_cnt += peer_req->i.size >> 9;
 	list_move_tail(&peer_req->w.list, &device->done_ee);
-- 
2.7.4

