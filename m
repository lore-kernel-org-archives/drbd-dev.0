Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6EE141056475
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jun 2016 16:09:25 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2016 16:09:07 +0200
Message-Id: <1465826958-19398-20-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
References: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 19/30] drbd: only restart frozen disk io when
	D_UP_TO_DATE
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

When re-attaching the local backend device to a C_STANDALONE D_DISKLESS
R_PRIMARY with OND_SUSPEND_IO, we may only resume IO if we recognize the
backend that is being attached as D_UP_TO_DATE.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 59c6467..24422e8 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1675,7 +1675,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 			what = RESEND;
 
 		if ((os.disk == D_ATTACHING || os.disk == D_NEGOTIATING) &&
-		    conn_lowest_disk(connection) > D_NEGOTIATING)
+		    conn_lowest_disk(connection) == D_UP_TO_DATE)
 			what = RESTART_FROZEN_DISK_IO;
 
 		if (resource->susp_nod && what != NOTHING) {
-- 
2.7.4

