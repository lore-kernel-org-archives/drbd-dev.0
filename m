Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 12 Oct 2011 14:27:33 +0200
Message-Id: <1318422455-17539-12-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318422455-17539-1-git-send-email-philipp.reisner@linbit.com>
References: <1318422455-17539-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/13] drbd: Remove dead code
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d361a07..557c514 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -297,9 +297,6 @@ fail:
 
 static int drbd_adm_finish(struct genl_info *info, int retcode)
 {
-	struct nlattr *nla;
-	const char *resource_name = NULL;
-
 	if (adm_ctx.tconn) {
 		kref_put(&adm_ctx.tconn->kref, &conn_destroy);
 		adm_ctx.tconn = NULL;
@@ -309,15 +306,6 @@ static int drbd_adm_finish(struct genl_info *info, int retcode)
 		return -ENOMEM;
 
 	adm_ctx.reply_dh->ret_code = retcode;
-
-	nla = info->attrs[DRBD_NLA_CFG_CONTEXT];
-	if (nla) {
-		int maxtype = ARRAY_SIZE(drbd_cfg_context_nl_policy) - 1;
-		nla = drbd_nla_find_nested(maxtype, nla, __nla_type(T_ctx_resource_name));
-		if (nla && !IS_ERR(nla))
-			resource_name = nla_data(nla);
-	}
-
 	drbd_adm_send_reply(adm_ctx.reply_skb, info);
 	return 0;
 }
-- 
1.7.4.1

