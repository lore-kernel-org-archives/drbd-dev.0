Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C0D361055731
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jul 2015 13:22:08 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2015 13:21:49 +0200
Message-Id: <1438255314-14877-15-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
References: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/19] drbd: also bump UUIDs if a diskless
	primary connects
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

If for some reason the primary lost its disk *and* the replication link
before it is able to communicate the disk loss, probably blocked IO,
then later is able to re-establish the connection, the peer needs to
bump its UUIDs just like it does when peer only loses the disk
and is able to communicate this in time.

Otherwise, a later re-attach of the disk on the primary may start a
resync in the "wrong" direction.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index bc4b45b..06afd4d 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1781,7 +1781,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 	}
 
 	if (ns.pdsk < D_INCONSISTENT && get_ldev(device)) {
-		if (os.peer == R_SECONDARY && ns.peer == R_PRIMARY &&
+		if (os.peer != R_PRIMARY && ns.peer == R_PRIMARY &&
 		    device->ldev->md.uuid[UI_BITMAP] == 0 && ns.disk >= D_UP_TO_DATE) {
 			drbd_uuid_new_current(device);
 			drbd_send_uuids(peer_device);
-- 
1.9.1

