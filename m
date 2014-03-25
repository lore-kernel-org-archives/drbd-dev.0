Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BF7C7101AC78
	for <drbd-dev@lists.linbit.com>; Wed, 26 Mar 2014 10:49:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id AFD0C3318B7
	for <drbd-dev@lists.linbit.com>; Wed, 26 Mar 2014 10:49:44 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id XfUws-UYKUsP for <drbd-dev@lists.linbit.com>;
	Wed, 26 Mar 2014 10:49:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 91D013318B8
	for <drbd-dev@lists.linbit.com>; Wed, 26 Mar 2014 10:49:44 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AObDENg8dwMn for <drbd-dev@lists.linbit.com>;
	Wed, 26 Mar 2014 10:49:44 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 748C83318B7
	for <drbd-dev@lists.linbit.com>; Wed, 26 Mar 2014 10:49:44 +0100 (CET)
Resent-Message-ID: <20140326094944.GK2209@soda.linbit>
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 25 Mar 2014 12:35:05 -0700
Message-Id: <fec7be25b0bae2280231f4e7779378b93de642f9.1395775901.git.joe@perches.com>
In-Reply-To: <cover.1395775901.git.joe@perches.com>
References: <cover.1395775901.git.joe@perches.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 3/5] block: Convert last uses of __FUNCTION__ to
	__func__
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

Just about all of these have been converted to __func__,
so convert the last uses.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/block/drbd/drbd_int.h | 8 ++++----
 drivers/block/xen-blkfront.c  | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index e7093d4..e312f73 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1781,7 +1781,7 @@ static inline void inc_ap_pending(struct drbd_device *device)
 			func, line,					\
 			atomic_read(&device->which))
 
-#define dec_ap_pending(device) _dec_ap_pending(device, __FUNCTION__, __LINE__)
+#define dec_ap_pending(device) _dec_ap_pending(device, __func__, __LINE__)
 static inline void _dec_ap_pending(struct drbd_device *device, const char *func, int line)
 {
 	if (atomic_dec_and_test(&device->ap_pending_cnt))
@@ -1800,7 +1800,7 @@ static inline void inc_rs_pending(struct drbd_device *device)
 	atomic_inc(&device->rs_pending_cnt);
 }
 
-#define dec_rs_pending(device) _dec_rs_pending(device, __FUNCTION__, __LINE__)
+#define dec_rs_pending(device) _dec_rs_pending(device, __func__, __LINE__)
 static inline void _dec_rs_pending(struct drbd_device *device, const char *func, int line)
 {
 	atomic_dec(&device->rs_pending_cnt);
@@ -1821,14 +1821,14 @@ static inline void inc_unacked(struct drbd_device *device)
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
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index efe1b47..375aea5 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1366,8 +1366,8 @@ static int blkfront_probe(struct xenbus_device *dev,
 
 			if (major != XENVBD_MAJOR) {
 				printk(KERN_INFO
-						"%s: HVM does not support vbd %d as xen block device\n",
-						__FUNCTION__, vdevice);
+				       "%s: HVM does not support vbd %d as xen block device\n",
+				       __func__, vdevice);
 				return -ENODEV;
 			}
 		}
-- 
1.8.1.2.459.gbcd45b4.dirty

