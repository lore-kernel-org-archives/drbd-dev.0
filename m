Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 902FF101AC77
	for <drbd-dev@lists.linbit.com>; Mon, 24 Mar 2014 14:57:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 524833305C0
	for <drbd-dev@lists.linbit.com>; Mon, 24 Mar 2014 14:57:56 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id QJxJi661SnjG for <drbd-dev@lists.linbit.com>;
	Mon, 24 Mar 2014 14:57:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 358103305C9
	for <drbd-dev@lists.linbit.com>; Mon, 24 Mar 2014 14:57:56 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 80DkhxoQqsHA for <drbd-dev@lists.linbit.com>;
	Mon, 24 Mar 2014 14:57:56 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 1482B3305C0
	for <drbd-dev@lists.linbit.com>; Mon, 24 Mar 2014 14:57:56 +0100 (CET)
Resent-Message-ID: <20140324135755.GC2209@soda.linbit>
From: Monam Agarwal <monamagarwal123@gmail.com>
To: drbd-dev@lists.linbit.com, drbd-user@lists.linbit.com,
	linux-kernel@vger.kernel.org
Date: Sun, 23 Mar 2014 02:02:29 +0530
Message-Id: <1395520349-3033-1-git-send-email-monamagarwal123@gmail.com>
Subject: [Drbd-dev] [PATCH] drivers/block: Use RCU_INIT_POINTER(x,
	NULL) in drbd/drbd_state.c
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

This patch replaces rcu_assign_pointer(x, NULL) with RCU_INIT_POINTER(x, NULL)

The rcu_assign_pointer() ensures that the initialization of a structure       
is carried out before storing a pointer to that structure. 
And in the case of the NULL pointer, there is no structure to initialize. 
So, rcu_assign_pointer(p, NULL) can be safely converted to RCU_INIT_POINTER(p, NULL)

Signed-off-by: Monam Agarwal <monamagarwal123@gmail.com>
---
 drivers/block/drbd/drbd_state.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 216d47b..a45a0d3 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1547,7 +1547,7 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 		old_conf = tconn->net_conf;
 		tconn->my_addr_len = 0;
 		tconn->peer_addr_len = 0;
-		rcu_assign_pointer(tconn->net_conf, NULL);
+		RCU_INIT_POINTER(tconn->net_conf, NULL);
 		conn_free_crypto(tconn);
 		mutex_unlock(&tconn->conf_update);
 
-- 
1.7.9.5

