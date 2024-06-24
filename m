Return-Path: <zhengbing.huang@easystack.cn>
Received: from mail-m25467.xmail.ntesmail.com (mail-m25467.xmail.ntesmail.com
	[103.129.254.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CAA224205A9
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2024 09:27:02 +0200 (CEST)
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 00AE07E06C8
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2024 13:46:21 +0800 (CST)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linbit.com
Subject: [PATCH 04/11] drbd_transport_rdma: dont schedule retry_connect_work
	in active is false
Date: Mon, 24 Jun 2024 13:46:12 +0800
Message-Id: <20240624054619.23212-4-zhengbing.huang@easystack.cn>
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

Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
---
 drbd/drbd_transport_rdma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
index eccd0c6ce..b7ccb15d4 100644
--- a/drbd/drbd_transport_rdma.c
+++ b/drbd/drbd_transport_rdma.c
@@ -1089,9 +1089,13 @@ static void dtr_cma_retry_connect_work_fn(struct work_struct *work)
 	if (err) {
 		struct dtr_path *path = container_of(cs, struct dtr_path, cs);
 		struct drbd_transport *transport = path->path.transport;
+		struct dtr_transport *rdma_transport =
+			container_of(transport, struct dtr_transport, transport);
 
 		tr_err(transport, "dtr_start_try_connect failed  %d\n", err);
-		schedule_delayed_work(&cs->retry_connect_work, HZ);
+		if (rdma_transport->active) {
+			schedule_delayed_work(&cs->retry_connect_work, HZ);
+		}
 	}
 }
 
@@ -1116,6 +1120,8 @@ static void dtr_remove_cm_from_path(struct dtr_path *path, struct dtr_cm *failed
 static void dtr_cma_retry_connect(struct dtr_path *path, struct dtr_cm *failed_cm)
 {
 	struct drbd_transport *transport = path->path.transport;
+	struct dtr_transport *rdma_transport =
+		container_of(transport, struct dtr_transport, transport);
 	struct dtr_connect_state *cs = &path->cs;
 	long connect_int = 10 * HZ;
 	struct net_conf *nc;
@@ -1128,7 +1134,9 @@ static void dtr_cma_retry_connect(struct dtr_path *path, struct dtr_cm *failed_c
 		connect_int = nc->connect_int * HZ;
 	rcu_read_unlock();
 
-	schedule_delayed_work(&cs->retry_connect_work, connect_int);
+	if (rdma_transport->active) {
+		schedule_delayed_work(&cs->retry_connect_work, connect_int);
+	}
 }
 
 static void dtr_cma_connect_work_fn(struct work_struct *work)
-- 
2.27.0

