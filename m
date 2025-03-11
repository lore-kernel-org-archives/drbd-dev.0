Return-Path: <zhengbing.huang@easystack.cn>
Received: from mail-m15571.qiye.163.com (mail-m15571.qiye.163.com
	[101.71.155.71])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E0A1E160657
	for <drbd-dev@lists.linbit.com>; Tue, 11 Mar 2025 12:11:41 +0100 (CET)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linbit.com
Subject: [PATCH] rdma: Add network ping detection
Date: Tue, 11 Mar 2025 19:06:32 +0800
Message-ID: <20250311110633.1122918-1-zhengbing.huang@easystack.cn>
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

In rdma mode, the drbd establishes a connection between two nodes,
and without I/O. If one node suddenly crash,
the connection status of the remain node is still normal.
That is, the remain node cannot detect the exception of the peer node.

So in rdma transport mode, we also add a ping work, like tcp transport mode.

Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
---
 drbd/drbd_transport_rdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
index 427065789..9799be396 100644
--- a/drbd/drbd_transport_rdma.c
+++ b/drbd/drbd_transport_rdma.c
@@ -3152,6 +3152,9 @@ static void dtr_set_rcvtimeo(struct drbd_transport *transport, enum drbd_stream
 		container_of(transport, struct dtr_transport, transport);
 
 	rdma_transport->stream[stream].recv_timeout = timeout;
+
+	if (stream == CONTROL_STREAM)
+		mod_timer(&rdma_transport->control_timer, jiffies + timeout);
 }
 
 static long dtr_get_rcvtimeo(struct drbd_transport *transport, enum drbd_stream stream)
-- 
2.43.0

