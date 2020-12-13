Return-Path: <michael.d.labriola@gmail.com>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
	[209.85.222.194])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A24D1420637
	for <drbd-dev@lists.linbit.com>; Sun, 13 Dec 2020 06:07:26 +0100 (CET)
Received: by mail-qk1-f194.google.com with SMTP id 22so2485964qkf.9
	for <drbd-dev@lists.linbit.com>; Sat, 12 Dec 2020 21:07:26 -0800 (PST)
From: Michael D Labriola <michael.d.labriola@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Sun, 13 Dec 2020 00:07:04 -0500
Message-Id: <20201213050704.997-9-michael.d.labriola@gmail.com>
In-Reply-To: <20201213050704.997-1-michael.d.labriola@gmail.com>
References: <20201213050704.997-1-michael.d.labriola@gmail.com>
Subject: [Drbd-dev] [PATCH 8/8] compat: remove set_bdi_cap_stable_writes
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

BDI_CAP_STABLE_WRITES goes away in 5.10, resulting in tons of warnings at
compile time.  It doesn't look like anything in either drbd or drbd-utils
is using the resulting set_bdi_cap_stable_writes macro anyways, so this
commit removes it.

Signed-off-by: Michael D Labriola <michael.d.labriola@gmail.com>
---
 drbd/drbd-kernel-compat/drbd_wrappers.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drbd/drbd-kernel-compat/drbd_wrappers.h b/drbd/drbd-kernel-compat/drbd_wrappers.h
index c0d8981c..01fdbf22 100644
--- a/drbd/drbd-kernel-compat/drbd_wrappers.h
+++ b/drbd/drbd-kernel-compat/drbd_wrappers.h
@@ -127,13 +127,6 @@ static inline void blk_queue_write_cache(struct request_queue *q, bool enabled,
 #define KREF_INIT(N) { ATOMIC_INIT(N) }
 #endif
 
-#ifdef BDI_CAP_STABLE_WRITES /* >= v3.9 */
-#define set_bdi_cap_stable_writes(cap)	do { (cap) |= BDI_CAP_STABLE_WRITES; } while (0)
-#else /* < v3.9 */
-#warning "BDI_CAP_STABLE_WRITES not available"
-#define set_bdi_cap_stable_writes(cap)	do { } while (0)
-#endif
-
 #ifdef COMPAT_HAVE_POINTER_BACKING_DEV_INFO /* >= v4.11 */
 #define bdi_from_device(device) (device->ldev->backing_bdev->bd_disk->queue->backing_dev_info)
 #else /* < v4.11 */
-- 
2.17.1

