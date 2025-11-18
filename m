Return-Path: <hsukrut3@gmail.com>
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
	[209.85.214.180])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2C2851608F4
	for <drbd-dev@lists.linbit.com>; Tue, 18 Nov 2025 10:08:20 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
	d9443c01a7336-2957850c63bso54346455ad.0
	for <drbd-dev@lists.linbit.com>; Tue, 18 Nov 2025 01:08:20 -0800 (PST)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com (open list:DRBD DRIVER),
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drbd: turn bitmap I/O comments into regular block comments
Date: Tue, 18 Nov 2025 14:37:53 +0530
Message-ID: <20251118090753.390818-1-hsukrut3@gmail.com>
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

W=1 build warns because the bitmap I/O comments use '/**', which
marks them as kernel-doc comments even though these functions do not
document an external API.

Convert these comments to regular block comments so kernel-doc no
longer parses them.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
See: https://lore.kernel.org/all/20251117172557.355797-1-hsukrut3@gmail.com/t/

 drivers/block/drbd/drbd_bitmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 85ca000a0564..d90fa3e7f4cf 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1210,7 +1210,7 @@ static int bm_rw(struct drbd_device *device, const unsigned int flags, unsigned
 	return err;
 }
 
-/**
+/*
  * drbd_bm_read() - Read the whole bitmap from its on disk location.
  * @device:	DRBD device.
  */
@@ -1221,7 +1221,7 @@ int drbd_bm_read(struct drbd_device *device,
 	return bm_rw(device, BM_AIO_READ, 0);
 }
 
-/**
+/*
  * drbd_bm_write() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
  *
@@ -1233,7 +1233,7 @@ int drbd_bm_write(struct drbd_device *device,
 	return bm_rw(device, 0, 0);
 }
 
-/**
+/*
  * drbd_bm_write_all() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
  *
@@ -1255,7 +1255,7 @@ int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_ho
 	return bm_rw(device, BM_AIO_COPY_PAGES, upper_idx);
 }
 
-/**
+/*
  * drbd_bm_write_copy_pages() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
  *
@@ -1272,7 +1272,7 @@ int drbd_bm_write_copy_pages(struct drbd_device *device,
 	return bm_rw(device, BM_AIO_COPY_PAGES, 0);
 }
 
-/**
+/*
  * drbd_bm_write_hinted() - Write bitmap pages with "hint" marks, if they have changed.
  * @device:	DRBD device.
  */
-- 
2.43.0

