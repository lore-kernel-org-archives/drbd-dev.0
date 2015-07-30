Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9D4091055729
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jul 2015 13:22:08 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2015 13:21:48 +0200
Message-Id: <1438255314-14877-14-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
References: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/19] drbd: drbdsetup detach of an unresponsive
	local disk should not block IO "forever"
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

When detaching, we make sure no application IO is in-flight
by internally suspending IO, then trigger the state change,
wait for the result, and finally internally resume IO again.

Once we triggered the stat change to "Failed",
we expect it to change from Failed to Diskless.
(To avoid races, we actually wait for it to leave "Failed").

On an unresponsive local IO backend, this may not happen, ever.
Don't have a "hung" detach block IO "forever", but resume IO
before waiting for the state change to Diskless.

We may well be able to continue IO to and from a healthy peer.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 2178fb7..7229d8e 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1929,9 +1929,9 @@ static int adm_detach(struct drbd_device *device, int force)
 	retcode = drbd_request_state(device, NS(disk, D_FAILED));
 	drbd_md_put_buffer(device);
 	/* D_FAILED will transition to DISKLESS. */
+	drbd_resume_io(device);
 	ret = wait_event_interruptible(device->misc_wait,
 			device->state.disk != D_FAILED);
-	drbd_resume_io(device);
 	if ((int)retcode == (int)SS_IS_DISKLESS)
 		retcode = SS_NOTHING_TO_DO;
 	if (ret)
-- 
1.9.1

