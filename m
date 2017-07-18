Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B1B4C1057FE2
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 05:16:35 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 18 Jul 2017 11:16:15 +0800
Message-Id: <20170718031615.18985-1-nwang@suse.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [PATCH] drbdadm: Fix handler called from kernel always
	invalid for stacking resource
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

Handler like "before-resync-target" called from kernel
space does not have "-S" option for stacking resource, it
always return as invalid usage for stacking resource in
normal mode, then the connection will be dropped. Add "-S"
option for stacking resource automatically if the handler
is called from kernel.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com

---
 user/v9/drbdadm_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/user/v9/drbdadm_main.c b/user/v9/drbdadm_main.c
index 3c6e2263..f6cd8b74 100644
--- a/user/v9/drbdadm_main.c
+++ b/user/v9/drbdadm_main.c
@@ -3472,6 +3472,9 @@ int main(int argc, char **argv)
 					       rv = E_USAGE;
 					continue;
 				}
+				if (3 == cmd->show_in_usage && ctx.res->stacked) {
+					is_drbd_top = 1;
+				}
 				if (is_drbd_top != ctx.res->stacked && !is_dump) {
 					err("'%s' is a %s resource, and not available in %s mode.\n",
 					    ctx.res->name,
-- 
2.12.0

