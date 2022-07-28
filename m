Return-Path: <rui.xu@easystack.cn>
Received: from mail-m2457.qiye.163.com (mail-m2457.qiye.163.com
	[220.194.24.57])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 52F984207B8
	for <drbd-dev@lists.linbit.com>; Thu, 28 Jul 2022 13:58:04 +0200 (CEST)
From: Rui Xu <rui.xu@easystack.cn>
To: philipp.reisner@linbit.com, drbd-dev@lists.linbit.com,
	joel.colledge@linbit.com
Date: Thu, 28 Jul 2022 19:47:59 +0800
Message-Id: <20220728114759.810371-1-rui.xu@easystack.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Rui Xu <rui.xu@easystack.cn>, dongsheng.yang@easystack.cn
Subject: [Drbd-dev] [PATCH] drbd: fix a bug with two-primaries configuration
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

There is a bug when execute 'drbdsetup disconnect' in
two-primaries configuration.

When 'drbdsetup disconnect' is called by user, two primary
nodes will going to outdated in do_change_cstate, then the
command will failed since there is no UpToDate node.

Fix it by modify the judgment condition in do_change_cstate.

Signed-off-by: Rui Xu <rui.xu@easystack.cn>
---
 drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index 792a96d5..c4f3f776 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -5406,7 +5406,7 @@ static bool do_change_cstate(struct change_context *context, enum change_phase p
 		u64 directly_reachable = directly_connected_nodes(resource, NEW) |
 			NODE_MASK(resource->res_opts.node_id);
 
-		if (reply->primary_nodes & ~directly_reachable)
+		if (!(reply->primary_nodes & directly_reachable))
 			__outdate_myself(resource);
 	}
 
-- 
2.25.1

