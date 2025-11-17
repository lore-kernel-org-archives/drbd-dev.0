Return-Path: <hsukrut3@gmail.com>
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
	[209.85.214.176])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 30239160923
	for <drbd-dev@lists.linbit.com>; Mon, 17 Nov 2025 18:26:23 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
	d9443c01a7336-297d4a56f97so49798895ad.1
	for <drbd-dev@lists.linbit.com>; Mon, 17 Nov 2025 09:26:23 -0800 (PST)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com (open list:DRBD DRIVER),
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drbd: add missing kernel-doc for peer_device parameter
Date: Mon, 17 Nov 2025 22:55:56 +0530
Message-ID: <20251117172557.355797-1-hsukrut3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Sukrut Heroorkar <hsukrut3@gmail.com>, shuah@kernel.org,
	david.hunter.linux@gmail.com
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

W=1 build warns that peer_device is undocumented in the bitmap I/O
handlers. This parameter was introduced in commit 8164dd6c8ae1
("drbd: Add peer device parameter to whole-bitmap I/O handlers"), but
the kernel-doc was not updated.

Add the missing @peer_device entry.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 drivers/block/drbd/drbd_bitmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 85ca000a0564..2d26f9d2454d 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1213,6 +1213,7 @@ static int bm_rw(struct drbd_device *device, const unsigned int flags, unsigned
 /**
  * drbd_bm_read() - Read the whole bitmap from its on disk location.
  * @device:	DRBD device.
+ * @peer_device: Peer device for which the bitmap read is performed.
  */
 int drbd_bm_read(struct drbd_device *device,
 		 struct drbd_peer_device *peer_device) __must_hold(local)
@@ -1224,6 +1225,7 @@ int drbd_bm_read(struct drbd_device *device,
 /**
  * drbd_bm_write() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
+ * @peer_device: Peer device for which the bitmap write is performed.
  *
  * Will only write pages that have changed since last IO.
  */
@@ -1236,7 +1238,7 @@ int drbd_bm_write(struct drbd_device *device,
 /**
  * drbd_bm_write_all() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
- *
+ * @peer_device: Peer device for which the bitmap write is performed.
  * Will write all pages.
  */
 int drbd_bm_write_all(struct drbd_device *device,
@@ -1258,6 +1260,7 @@ int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_ho
 /**
  * drbd_bm_write_copy_pages() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
+ * @peer_device: Peer device for which the bitmap write is performed.
  *
  * Will only write pages that have changed since last IO.
  * In contrast to drbd_bm_write(), this will copy the bitmap pages
@@ -1275,6 +1278,7 @@ int drbd_bm_write_copy_pages(struct drbd_device *device,
 /**
  * drbd_bm_write_hinted() - Write bitmap pages with "hint" marks, if they have changed.
  * @device:	DRBD device.
+ * @peer_device: Peer device for which the bitmap write is performed.
  */
 int drbd_bm_write_hinted(struct drbd_device *device) __must_hold(local)
 {
-- 
2.43.0

