Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 32B2E1056447
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 00:26:41 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue, 14 Jun 2016 00:26:11 +0200
Message-Id: <1465856799-2151-3-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/30] drbd: change bitmap write-out when leaving
	resync states
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

When leaving resync states because of disconnect,
do the bitmap write-out synchronously in the drbd_disconnected() path.

When leaving resync states because we go back to AHEAD/BEHIND, or
because resync actually finished, or some disk was lost during resync,
trigger the write-out from after_state_ch().

The bitmap write-out for resync -> ahead/behind was missing completely before.

Note that this is all only an optimization to avoid double-resyncs of
already completed blocks in case this node crashes.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 8 +++++---
 drivers/block/drbd/drbd_state.c    | 9 +++++++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1ee0023..dcadea2 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4795,9 +4795,11 @@ static int drbd_disconnected(struct drbd_peer_device *peer_device)
 
 	drbd_md_sync(device);
 
-	/* serialize with bitmap writeout triggered by the state change,
-	 * if any. */
-	wait_event(device->misc_wait, !test_bit(BITMAP_IO, &device->flags));
+	if (get_ldev(device)) {
+		drbd_bitmap_io(device, &drbd_bm_write_copy_pages,
+				"write from disconnected", BM_LOCKED_CHANGE_ALLOWED);
+		put_ldev(device);
+	}
 
 	/* tcp_close and release of sendpage pages can be deferred.  I don't
 	 * want to use SO_LINGER, because apparently it can be deferred for
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 5a7ef78..59c6467 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1934,12 +1934,17 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 
 	/* This triggers bitmap writeout of potentially still unwritten pages
 	 * if the resync finished cleanly, or aborted because of peer disk
-	 * failure, or because of connection loss.
+	 * failure, or on transition from resync back to AHEAD/BEHIND.
+	 *
+	 * Connection loss is handled in drbd_disconnected() by the receiver.
+	 *
 	 * For resync aborted because of local disk failure, we cannot do
 	 * any bitmap writeout anymore.
+	 *
 	 * No harm done if some bits change during this phase.
 	 */
-	if (os.conn > C_CONNECTED && ns.conn <= C_CONNECTED && get_ldev(device)) {
+	if ((os.conn > C_CONNECTED && os.conn < C_AHEAD) &&
+	    (ns.conn == C_CONNECTED || ns.conn >= C_AHEAD) && get_ldev(device)) {
 		drbd_queue_bitmap_io(device, &drbd_bm_write_copy_pages, NULL,
 			"write from resync_finished", BM_LOCKED_CHANGE_ALLOWED);
 		put_ldev(device);
-- 
2.7.4

