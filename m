Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 849CF101AC7E
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jul 2014 18:16:51 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  1 Jul 2014 18:16:42 +0200
Message-Id: <1404231410-29852-13-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
References: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/20] block: Convert last uses of __FUNCTION__
	to __func__
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

From: Joe Perches <joe@perches.com>

Just about all of these have been converted to __func__,
so convert the last uses.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index fe6595a..b0ab358 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1867,7 +1867,7 @@ static inline void inc_ap_pending(struct drbd_device *device)
 			func, line,					\
 			atomic_read(&device->which))
 
-#define dec_ap_pending(device) _dec_ap_pending(device, __FUNCTION__, __LINE__)
+#define dec_ap_pending(device) _dec_ap_pending(device, __func__, __LINE__)
 static inline void _dec_ap_pending(struct drbd_device *device, const char *func, int line)
 {
 	if (atomic_dec_and_test(&device->ap_pending_cnt))
@@ -1886,7 +1886,7 @@ static inline void inc_rs_pending(struct drbd_device *device)
 	atomic_inc(&device->rs_pending_cnt);
 }
 
-#define dec_rs_pending(device) _dec_rs_pending(device, __FUNCTION__, __LINE__)
+#define dec_rs_pending(device) _dec_rs_pending(device, __func__, __LINE__)
 static inline void _dec_rs_pending(struct drbd_device *device, const char *func, int line)
 {
 	atomic_dec(&device->rs_pending_cnt);
@@ -1907,14 +1907,14 @@ static inline void inc_unacked(struct drbd_device *device)
 	atomic_inc(&device->unacked_cnt);
 }
 
-#define dec_unacked(device) _dec_unacked(device, __FUNCTION__, __LINE__)
+#define dec_unacked(device) _dec_unacked(device, __func__, __LINE__)
 static inline void _dec_unacked(struct drbd_device *device, const char *func, int line)
 {
 	atomic_dec(&device->unacked_cnt);
 	ERR_IF_CNT_IS_NEGATIVE(unacked_cnt, func, line);
 }
 
-#define sub_unacked(device, n) _sub_unacked(device, n, __FUNCTION__, __LINE__)
+#define sub_unacked(device, n) _sub_unacked(device, n, __func__, __LINE__)
 static inline void _sub_unacked(struct drbd_device *device, int n, const char *func, int line)
 {
 	atomic_sub(n, &device->unacked_cnt);
-- 
1.9.1

