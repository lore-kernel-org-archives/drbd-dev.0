Return-Path: <zhengbing.huang@easystack.cn>
Received: from mail-m32121.qiye.163.com (mail-m32121.qiye.163.com
	[220.197.32.121])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E9BCA4205D4
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2024 07:52:01 +0200 (CEST)
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 78DF87E06C5
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2024 13:46:23 +0800 (CST)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linbit.com
Subject: [PATCH 06/11] drbd_transport_rdma: put kref in error path
Date: Mon, 24 Jun 2024 13:46:14 +0800
Message-Id: <20240624054619.23212-6-zhengbing.huang@easystack.cn>
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
 drbd/drbd_transport_rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
index 9a6d15b78..c7adc87e3 100644
--- a/drbd/drbd_transport_rdma.c
+++ b/drbd/drbd_transport_rdma.c
@@ -1157,6 +1157,7 @@ static void dtr_cma_connect_work_fn(struct work_struct *work)
 	kref_get(&cm->kref); /* for the path->cm pointer */
 	err = dtr_path_prepare(path, cm, true);
 	if (err) {
+		kref_put(&cm->kref, dtr_destroy_cm);
 		tr_err(transport, "dtr_path_prepare() = %d\n", err);
 		goto out;
 	}
-- 
2.27.0

