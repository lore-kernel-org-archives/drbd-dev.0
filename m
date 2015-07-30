Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A3CA01055F49
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jul 2015 13:22:09 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2015 13:21:54 +0200
Message-Id: <1438255314-14877-20-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
References: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 19/19] drbd: fix refcount error during detach of
	an already failed disk
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

A D_FAILED disk transitions as quickly as possible to
D_DISKLESS. But in the "unresponsive local disk" case,
there remains a time window where a administrative detach command could
find the disk already failed, but some internal meta data IO against the
unresponsive local disk still pending.

In that case, drbd_md_get_buffer() will return NULL.
Don't unconditionally call drbd_md_put_buffer(), or it will cause
refcount imbalance, and prevent any further re-attach on this volume
(until it is deleted and re-created).

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 7229d8e..4c8d8e7 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1915,6 +1915,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 static int adm_detach(struct drbd_device *device, int force)
 {
 	enum drbd_state_rv retcode;
+	void *buffer;
 	int ret;
 
 	if (force) {
@@ -1925,9 +1926,12 @@ static int adm_detach(struct drbd_device *device, int force)
 	}
 
 	drbd_suspend_io(device); /* so no-one is stuck in drbd_al_begin_io */
-	drbd_md_get_buffer(device, __func__); /* make sure there is no in-flight meta-data IO */
-	retcode = drbd_request_state(device, NS(disk, D_FAILED));
-	drbd_md_put_buffer(device);
+	buffer = drbd_md_get_buffer(device, __func__); /* make sure there is no in-flight meta-data IO */
+	if (buffer) {
+		retcode = drbd_request_state(device, NS(disk, D_FAILED));
+		drbd_md_put_buffer(device);
+	} else /* already <= D_FAILED */
+		retcode = SS_NOTHING_TO_DO;
 	/* D_FAILED will transition to DISKLESS. */
 	drbd_resume_io(device);
 	ret = wait_event_interruptible(device->misc_wait,
-- 
1.9.1

