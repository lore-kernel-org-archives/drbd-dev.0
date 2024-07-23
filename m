Return-Path: <horms@kernel.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C252E420653
	for <drbd-dev@lists.linbit.com>;
	Tue, 23 Jul 2024 11:48:06 +0200 (CEST)
From: Simon Horman <horms@kernel.org>
Date: Tue, 23 Jul 2024 10:41:52 +0100
Subject: [PATCH] drbd: Add peer_device to Kernel doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-drbd-doc-v1-1-a04d9b7a9688@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Andreas Gruenbacher <agruen@kernel.org>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Add missing documentation of peer_device parameter to Kernel doc.

These parameters were added in commit 8164dd6c8ae1 ("drbd: Add peer
device parameter to whole-bitmap I/O handlers")

Flagged by W=1 builds.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/block/drbd/drbd_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index f92673f05c7a..a9e49b212341 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3422,6 +3422,7 @@ void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(local)
 /**
  * drbd_bmio_set_n_write() - io_fn for drbd_queue_bitmap_io() or drbd_bitmap_io()
  * @device:	DRBD device.
+ * @peer_device: Peer DRBD device.
  *
  * Sets all bits in the bitmap and writes the whole bitmap to stable storage.
  */
@@ -3448,6 +3449,7 @@ int drbd_bmio_set_n_write(struct drbd_device *device,
 /**
  * drbd_bmio_clear_n_write() - io_fn for drbd_queue_bitmap_io() or drbd_bitmap_io()
  * @device:	DRBD device.
+ * @peer_device: Peer DRBD device.
  *
  * Clears all bits in the bitmap and writes the whole bitmap to stable storage.
  */
@@ -3501,6 +3503,7 @@ static int w_bitmap_io(struct drbd_work *w, int unused)
  * @done:	callback to be called after the bitmap IO was performed
  * @why:	Descriptive text of the reason for doing the IO
  * @flags:	Bitmap flags
+ * @peer_device: Peer DRBD device.
  *
  * While IO on the bitmap happens we freeze application IO thus we ensure
  * that drbd_set_out_of_sync() can not be called. This function MAY ONLY be
@@ -3549,6 +3552,7 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
  * @io_fn:	IO callback to be called when bitmap IO is possible
  * @why:	Descriptive text of the reason for doing the IO
  * @flags:	Bitmap flags
+ * @peer_device: Peer DRBD device.
  *
  * freezes application IO while that the actual IO operations runs. This
  * functions MAY NOT be called from worker context.

