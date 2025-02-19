Return-Path: <zhengbing.huang@easystack.cn>
Received: from mail-m49214.qiye.163.com (mail-m49214.qiye.163.com
	[45.254.49.214])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0D6EE16B901
	for <drbd-dev@lists.linbit.com>; Wed, 19 Feb 2025 04:13:09 +0100 (CET)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linbit.com
Subject: [PATCH] rdma: Fix drbd_transport_rdma module reference count exception
Date: Wed, 19 Feb 2025 11:08:04 +0800
Message-ID: <20250219030804.1389397-1-zhengbing.huang@easystack.cn>
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

In testing, we find drbd_transport_rdma module reference count is abnormal:
drbd_transport_rdma 262144 28293

we don't have that many drbd devices.

If the XXX_ADDR_ERROR/XXX_ROUTE_ERROR events occurs
and the DSB_CONNECTING flag bit is not set,
the dtr_cma_event_handler() returns 0 directly.
The cm structure cannot be destroyed,
and the drbd_transport_rdma module reference count is abnormal.

So, for XXX_ADDR_ERROR/XXX_ROUTE_ERROR events,
we do not need to judge the DSB_CONNECTING flag,
and we need to kref_put of cm structure.

Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
---
 drbd/drbd_transport_rdma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
index ba4f1baa7..bb59e6501 100644
--- a/drbd/drbd_transport_rdma.c
+++ b/drbd/drbd_transport_rdma.c
@@ -1292,6 +1292,11 @@ static int dtr_cma_event_handler(struct rdma_cm_id *cm_id, struct rdma_cm_event
 		// pr_info("%s: RDMA_CM_EVENT_ADDR_ERROR\n", cm->name);
 	case RDMA_CM_EVENT_ROUTE_ERROR:
 		// pr_info("%s: RDMA_CM_EVENT_ROUTE_ERROR\n", cm->name);
+		set_bit(DSB_ERROR, &cm->state);
+
+		dtr_cma_retry_connect(cm->path, cm);
+		break;
+
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 		// pr_info("%s: RDMA_CM_EVENT_CONNECT_ERROR\n", cm->name);
 	case RDMA_CM_EVENT_UNREACHABLE:
-- 
2.43.0

