Return-Path: <rdunlap@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 33BB0420150
	for <drbd-dev@lists.linbit.com>; Fri, 22 Dec 2023 08:24:33 +0100 (CET)
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 21 Dec 2023 22:19:08 -0800
Message-ID: <20231222061909.8791-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: actlog: fix kernel-doc warnings and
	spelling
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

Fix all kernel-doc warnings in drbd_actlog.c:

drbd_actlog.c:963: warning: No description found for return value of 'drbd_rs_begin_io'
drbd_actlog.c:1015: warning: Function parameter or member 'peer_device' not described in 'drbd_try_rs_begin_io'
drbd_actlog.c:1015: warning: Excess function parameter 'device' description in 'drbd_try_rs_begin_io'
drbd_actlog.c:1015: warning: No description found for return value of 'drbd_try_rs_begin_io'
drbd_actlog.c:1197: warning: No description found for return value of 'drbd_rs_del_all'

Fix one spelling error (s/ore/or/).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 drivers/block/drbd/drbd_actlog.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff -- a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -838,8 +838,8 @@ static bool plausible_request_size(int s
 }
 
 /* clear the bit corresponding to the piece of storage in question:
- * size byte of data starting from sector.  Only clear a bits of the affected
- * one ore more _aligned_ BM_BLOCK_SIZE blocks.
+ * size byte of data starting from sector.  Only clear bits of the affected
+ * one or more _aligned_ BM_BLOCK_SIZE blocks.
  *
  * called by worker on C_SYNC_TARGET and receiver on SyncSource.
  *
@@ -957,7 +957,9 @@ static int _is_in_al(struct drbd_device
  * @device:	DRBD device.
  * @sector:	The sector number.
  *
- * This functions sleeps on al_wait. Returns 0 on success, -EINTR if interrupted.
+ * This functions sleeps on al_wait.
+ *
+ * Returns: %0 on success, -EINTR if interrupted.
  */
 int drbd_rs_begin_io(struct drbd_device *device, sector_t sector)
 {
@@ -1004,11 +1006,13 @@ retry:
 
 /**
  * drbd_try_rs_begin_io() - Gets an extent in the resync LRU cache, does not sleep
- * @device:	DRBD device.
+ * @peer_device: DRBD device.
  * @sector:	The sector number.
  *
  * Gets an extent in the resync LRU cache, sets it to BME_NO_WRITES, then
- * tries to set it to BME_LOCKED. Returns 0 upon success, and -EAGAIN
+ * tries to set it to BME_LOCKED.
+ *
+ * Returns: %0 upon success, and -EAGAIN
  * if there is still application IO going on in this area.
  */
 int drbd_try_rs_begin_io(struct drbd_peer_device *peer_device, sector_t sector)
@@ -1190,7 +1194,7 @@ void drbd_rs_cancel_all(struct drbd_devi
  * drbd_rs_del_all() - Gracefully remove all extents from the resync LRU
  * @device:	DRBD device.
  *
- * Returns 0 upon success, -EAGAIN if at least one reference count was
+ * Returns: %0 upon success, -EAGAIN if at least one reference count was
  * not zero.
  */
 int drbd_rs_del_all(struct drbd_device *device)
