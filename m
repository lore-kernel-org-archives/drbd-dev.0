Return-Path: <zhengbing.huang@easystack.cn>
Received: from mail-m21469.qiye.163.com (mail-m21469.qiye.163.com
	[117.135.214.69])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0E04216095D
	for <drbd-dev@lists.linbit.com>; Tue,  8 Jul 2025 12:19:21 +0200 (CEST)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linbit.com
Subject: [PATCH 1/3] rdma: Fix memory leak in error path
Date: Tue,  8 Jul 2025 14:50:38 +0800
Message-ID: <20250708065040.4043169-1-zhengbing.huang@easystack.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In the dtr_send() function, if the __dtr_post_tx_desc() return an error,
it means that  ib_post_send() has failed.
Then, we cannot get this tx_desc and release it through ib_poll_cq().

So, we need to release this tx_desc when __dtr_post_tx_desc() fails in
dtr_send() function.

Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
---
 drbd/drbd_transport_rdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
index 6de0ba625..5270e503a 100644
--- a/drbd/drbd_transport_rdma.c
+++ b/drbd/drbd_transport_rdma.c
@@ -581,6 +581,9 @@ static int dtr_send(struct dtr_path *path, void *buf, size_t size, gfp_t gfp_mas
 		{ .stream = ST_FLOW_CTRL, .sequence = 0 };
 
 	err = __dtr_post_tx_desc(cm, tx_desc);
+	if (err)
+		dtr_free_tx_desc(cm, tx_desc);
+
 out_put:
 	kref_put(&cm->kref, dtr_destroy_cm);
 out:
-- 
2.43.0

