Return-Path: <rui.xu@easystack.cn>
Received: from mail-m2458.qiye.163.com (mail-m2458.qiye.163.com
	[220.194.24.58])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B97E8421798
	for <drbd-dev@lists.linbit.com>; Wed,  2 Mar 2022 13:35:31 +0100 (CET)
From: Rui Xu <rui.xu@easystack.cn>
To: joel.colledge@linbit.com, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed,  2 Mar 2022 20:35:23 +0800
Message-Id: <20220302123523.471277-1-rui.xu@easystack.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Rui Xu <rui.xu@easystack.cn>, dongsheng.yang@easystack.cn
Subject: [Drbd-dev] [PATCH] drbd:do not wait for negotiation result with
	unconnected peer
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

The commit 8a962a6a from Dec 2014
"drbd: fix leaving of D_NEGOTIATING if some peer do not have the minor yet"
introduced a bug that disk state will always stay in negotiating since there
will never be negotiation result with unconnected peer.

So do not wait for an negotiation result with unconnected peer!

Signed-off-by: Rui Xu <rui.xu@easystack.cn>
---
 drbd/drbd_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index aeaf36a..f79f5a4 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -1912,7 +1912,8 @@ static void sanitize_state(struct drbd_resource *resource)
 				enum drbd_repl_state nr = peer_device->negotiation_result;
 				enum drbd_disk_state pdsk = peer_device->disk_state[NEW];
 
-				if (pdsk == D_UNKNOWN || pdsk < D_NEGOTIATING)
+				if (pdsk == D_UNKNOWN || pdsk < D_NEGOTIATING ||
+				    peer_device->connection->cstate[NEW] < C_CONNECTED)
 					continue;
 
 				if (pdsk == D_UP_TO_DATE)
-- 
1.8.3.1

