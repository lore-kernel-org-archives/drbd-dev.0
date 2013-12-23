Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 15BE0105B0BB
	for <drbd-dev@lists.linbit.com>; Mon, 23 Dec 2013 22:50:58 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 23 Dec 2013 22:50:43 +0100
Message-Id: <1387835456-29695-15-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
References: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/27] drbd: Remove useless assertion
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

From: Andreas Gruenbacher <agruen@kernel.org>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_state.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 1aef152..3f5c5a5 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1165,10 +1165,8 @@ static int w_after_state_ch(struct drbd_work *w, int unused)
 	struct drbd_device *device = w->device;
 
 	after_state_ch(device, ascw->os, ascw->ns, ascw->flags);
-	if (ascw->flags & CS_WAIT_COMPLETE) {
-		D_ASSERT(device, ascw->done != NULL);
+	if (ascw->flags & CS_WAIT_COMPLETE)
 		complete(ascw->done);
-	}
 	kfree(ascw);
 
 	return 0;
-- 
1.7.9.5

