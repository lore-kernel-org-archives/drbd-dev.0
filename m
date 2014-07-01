Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 95B55101AC79
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jul 2014 18:16:51 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  1 Jul 2014 18:16:44 +0200
Message-Id: <1404231410-29852-15-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
References: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/20] drbd: clear CRASHED_PRIMARY only after
	successful resync
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

If we lost a disk during the first resync after primary crash,
we could have prematurely cleared the CRASHED_PRIMARY flag.
Testing on C_CONNECTED is not what we meant there,
but testing for both peers to become D_UP_TO_DATE.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 4a75b7a..c35c0f0 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1238,7 +1238,8 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 	sib.os = os;
 	sib.ns = ns;
 
-	if (os.conn != C_CONNECTED && ns.conn == C_CONNECTED) {
+	if ((os.disk != D_UP_TO_DATE || os.pdsk != D_UP_TO_DATE)
+	&&  (ns.disk == D_UP_TO_DATE && ns.pdsk == D_UP_TO_DATE)) {
 		clear_bit(CRASHED_PRIMARY, &device->flags);
 		if (device->p_uuid)
 			device->p_uuid[UI_FLAGS] &= ~((u64)2);
-- 
1.9.1

