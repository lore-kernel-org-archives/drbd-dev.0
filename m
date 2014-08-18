Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0914F101AC7F
	for <drbd-dev@lists.linbit.com>; Tue, 19 Aug 2014 11:27:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id F22E82A54E4
	for <drbd-dev@lists.linbit.com>; Tue, 19 Aug 2014 11:27:17 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9Qa1Pz7Khg8R for <drbd-dev@lists.linbit.com>;
	Tue, 19 Aug 2014 11:27:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D54C12A5A50
	for <drbd-dev@lists.linbit.com>; Tue, 19 Aug 2014 11:27:17 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fGIaxVSOWNR6 for <drbd-dev@lists.linbit.com>;
	Tue, 19 Aug 2014 11:27:17 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 87D262A54E4
	for <drbd-dev@lists.linbit.com>; Tue, 19 Aug 2014 11:27:17 +0200 (CEST)
Resent-Message-ID: <20140819092717.GG4652@soda.linbit>
Date: Mon, 18 Aug 2014 17:37:05 +0300
From: Andreea-Cristina Bernat <bernat.ada@gmail.com>
To: drbd-dev@lists.linbit.com, drbd-user@lists.linbit.com,
	linux-kernel@vger.kernel.org
Message-ID: <20140818143705.GA13718@ada>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: paulmck@linux.vnet.ibm.com
Subject: [Drbd-dev] [PATCH] drbd: Replace rcu_assign_pointer() with
	RCU_INIT_POINTER()
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

The use of "rcu_assign_pointer()" is NULLing out the pointer.
According to RCU_INIT_POINTER()'s block comment:
"1.   This use of RCU_INIT_POINTER() is NULLing out the pointer"
it is better to use it instead of rcu_assign_pointer() because it has a
smaller overhead.

The following Coccinelle semantic patch was used:
@@
@@

- rcu_assign_pointer
+ RCU_INIT_POINTER
  (..., NULL)

Signed-off-by: Andreea-Cristina Bernat <bernat.ada@gmail.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index a5d8aae..73bc23f 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1563,7 +1563,7 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 		old_conf = connection->net_conf;
 		connection->my_addr_len = 0;
 		connection->peer_addr_len = 0;
-		rcu_assign_pointer(connection->net_conf, NULL);
+		RCU_INIT_POINTER(connection->net_conf, NULL);
 		conn_free_crypto(connection);
 		mutex_unlock(&connection->resource->conf_update);
 
-- 
1.9.1

