Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DF2831055734
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jul 2015 13:22:08 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2015 13:21:50 +0200
Message-Id: <1438255314-14877-16-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
References: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 15/19] drbd: add comment why we want to first
	call local-io-error, then send state
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

Even though we really want to get the state information about our bad
disk to the peer as soon as possible, it is useful to first call the
local-io-error handler.

People may chose to hard-reset the box from there.
If that looks and behaves exactly like a "regular node crash", without
bumping the data generation UUIDs on the peer in between, it makes it
easier to deal with.

If you intend to return from the local-io-error handler, then better
return as quickly as possible to avoid triggering other timeouts.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 06afd4d..a4e4505 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1859,6 +1859,10 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 
 			was_io_error = test_and_clear_bit(WAS_IO_ERROR, &device->flags);
 
+			/* Intentionally call this handler first, before drbd_send_state().
+			 * See: 2932204 drbd: call local-io-error handler early
+			 * People may chose to hard-reset the box from this handler.
+			 * It is useful if this looks like a "regular node crash". */
 			if (was_io_error && eh == EP_CALL_HELPER)
 				drbd_khelper(device, "local-io-error");
 
-- 
1.9.1

