Return-Path: <zhengbing.huang@easystack.cn>
Received: from mail-m25467.xmail.ntesmail.com (mail-m25467.xmail.ntesmail.com
	[103.129.254.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CE0FC4205D4
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2024 09:27:02 +0200 (CEST)
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 403777E06EC
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2024 13:46:25 +0800 (CST)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linbit.com
Subject: [PATCH 09/11] drbd_transport_rdma: introduce timeout for
	rdma_disocnnect
Date: Mon, 24 Jun 2024 13:46:17 +0800
Message-Id: <20240624054619.23212-9-zhengbing.huang@easystack.cn>
In-Reply-To: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
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

From: Dongsheng Yang <dongsheng.yang@easystack.cn>

The rdma driver timeout for dreq is too long in network failure, we can
introduce a timeout for rdma_disconnect().

If timeout we will put kref, and finaly it will go to rdma_destory_id(),
which will cancel all dreq in rdma driver, so dont worry about use-after-free
problem in dtr_cma_event_handler.

Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
---
 drbd/drbd_transport_rdma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
index c47b344f8..811f1a20a 100644
--- a/drbd/drbd_transport_rdma.c
+++ b/drbd/drbd_transport_rdma.c
@@ -2760,9 +2760,15 @@ static void __dtr_disconnect_path(struct dtr_path *path)
 	}
 
 	/* There might be a signal pending here. Not incorruptible! */
-	wait_event_timeout(cm->state_wq,
-			   !test_bit(DSB_CONNECTED, &cm->state),
-			   HZ);
+	err = wait_event_timeout(cm->state_wq,
+			   !test_bit(DSB_CONNECTED, &cm->state), 20 * HZ);
+
+	if (err == 0 && test_and_clear_bit(DSB_CONNECTED, &cm->state)) {
+		dtr_remove_cm_from_path(path, cm);
+
+		kref_put(&cm->kref, dtr_destroy_cm);
+		clear_bit(TR_ESTABLISHED, &path->path.flags);
+	}
 
 	if (test_bit(DSB_CONNECTED, &cm->state))
 		tr_warn(transport, "WARN: not properly disconnected, state = %lu\n",
-- 
2.27.0

