Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1B7D41056473
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jun 2016 16:09:25 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2016 16:09:06 +0200
Message-Id: <1465826958-19398-19-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
References: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 18/30] drbd: if there is no good data accessible,
	writes should be IO errors
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

If DRBD lost all path to good data,
and the on-no-data-accessible policy is OND_SUSPEND_IO,
all pending and new IO requests are suspended (will block).

If that setting is OND_IO_ERROR, IO will still be completed.
READ to "clean" areas (e.g. on an D_INCONSISTENT device,
and bitmap indicates a block is already in sync) will succeed.
READ to "unclean" areas (bitmap indicates block is out-of-sync),
will return EIO.

If we are already D_DISKLESS (or D_FAILED), we also return EIO.

Unfortunately, on a former R_PRIMARY C_SYNC_TARGET D_INCONSISTENT,
after replication link loss, new WRITE requests still went through OK.

The would also set the "out-of-sync" bit on their way, so READ after
WRITE would still return EIO. Also, the data generation UUIDs had not
been bumped, we would cause data divergence, without being able to
detect it on the next sync handshake, given the right sequence of events
in a multiple error scenario and "improper" order of recovery actions.

The right thing to do is to return EIO for all new writes,
unless we have access to good, current, D_UP_TO_DATE data.

The "established best practices" way to avoid these situations in the
first place is to set OND_SUSPEND_IO, or even do a hard-reset from
the pri-on-incon-degr policy helper hook.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 7e441ff..8260dfa6 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1258,6 +1258,22 @@ drbd_request_prepare(struct drbd_device *device, struct bio *bio, unsigned long
 	return NULL;
 }
 
+/* Require at least one path to current data.
+ * We don't want to allow writes on C_STANDALONE D_INCONSISTENT:
+ * We would not allow to read what was written,
+ * we would not have bumped the data generation uuids,
+ * we would cause data divergence for all the wrong reasons.
+ *
+ * If we don't see at least one D_UP_TO_DATE, we will fail this request,
+ * which either returns EIO, or, if OND_SUSPEND_IO is set, suspends IO,
+ * and queues for retry later.
+ */
+static bool may_do_writes(struct drbd_device *device)
+{
+	const union drbd_dev_state s = device->state;
+	return s.disk == D_UP_TO_DATE || s.pdsk == D_UP_TO_DATE;
+}
+
 static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request *req)
 {
 	struct drbd_resource *resource = device->resource;
@@ -1312,6 +1328,12 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 	}
 
 	if (rw == WRITE) {
+		if (req->private_bio && !may_do_writes(device)) {
+			bio_put(req->private_bio);
+			req->private_bio = NULL;
+			put_ldev(device);
+			goto nodata;
+		}
 		if (!drbd_process_write_request(req))
 			no_remote = true;
 	} else {
-- 
2.7.4

