Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5104B105571D
	for <drbd-dev@lists.linbit.com>; Tue,  4 Aug 2015 14:56:58 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  4 Aug 2015 14:56:27 +0200
Message-Id: <1438693003-17554-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
References: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/19] drbd: prevent NULL pointer deref when
	resuming diskless primary
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

In a multiple error scenario, we may end up with a "frozen" Primary,
that has no access to any data (no local disk, no replication link).

If we then resume-io, we try to generate a new data generation id,
which will fail if there is no longer a local disk.

Double check for available local data,
which prevents the NULL pointer deref.

If we are diskless, turn the resume-io in this situation
into the first stage of a "force down", by bumping the "effective" data
gen id, which will prevent later attach or connect to the former data
set without first being demoted (deconfigured).

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 0152f0f..66e8acd 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2920,7 +2920,30 @@ int drbd_adm_resume_io(struct sk_buff *skb, struct genl_info *info)
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	device = adm_ctx.device;
 	if (test_bit(NEW_CUR_UUID, &device->flags)) {
-		drbd_uuid_new_current(device);
+		if (get_ldev_if_state(device, D_ATTACHING)) {
+			drbd_uuid_new_current(device);
+			put_ldev(device);
+		} else {
+			/* This is effectively a multi-stage "forced down".
+			 * The NEW_CUR_UUID bit is supposedly only set, if we
+			 * lost the replication connection, and are configured
+			 * to freeze IO and wait for some fence-peer handler.
+			 * So we still don't have a replication connection.
+			 * And now we don't have a local disk either.  After
+			 * resume, we will fail all pending and new IO, because
+			 * we don't have any data anymore.  Which means we will
+			 * eventually be able to terminate all users of this
+			 * device, and then take it down.  By bumping the
+			 * "effective" data uuid, we make sure that you really
+			 * need to tear down before you reconfigure, we will
+			 * the refuse to re-connect or re-attach (because no
+			 * matching real data uuid exists).
+			 */
+			u64 val;
+			get_random_bytes(&val, sizeof(u64));
+			drbd_set_ed_uuid(device, val);
+			drbd_warn(device, "Resumed without access to data; please tear down before attempting to re-configure.\n");
+		}
 		clear_bit(NEW_CUR_UUID, &device->flags);
 	}
 	drbd_suspend_io(device);
-- 
1.9.1

