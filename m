Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 20 Dec 2013 13:29:08 +0100
Message-Id: <1387542563-6833-12-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387542563-6833-1-git-send-email-philipp.reisner@linbit.com>
References: <1387542563-6833-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/26] drbd: drbd_adm_down(): Move valid resource
	name check to drbd_adm_prepare()
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

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a332399..7e22046 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -221,6 +221,8 @@ static int drbd_adm_prepare(struct sk_buff *skb, struct genl_info *info,
 	}
 	if (!adm_ctx.connection && (flags & DRBD_ADM_NEED_RESOURCE)) {
 		drbd_msg_put_info("unknown resource");
+		if (adm_ctx.resource_name)
+			return ERR_RES_NOT_KNOWN;
 		return ERR_INVALID_REQUEST;
 	}
 
@@ -3355,17 +3357,12 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 	struct drbd_device *device;
 	unsigned i;
 
-	retcode = drbd_adm_prepare(skb, info, 0);
+	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_RESOURCE);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
 		goto out;
 
-	if (!adm_ctx.connection) {
-		retcode = ERR_RES_NOT_KNOWN;
-		goto out;
-	}
-
 	/* demote */
 	idr_for_each_entry(&adm_ctx.connection->volumes, device, i) {
 		retcode = drbd_set_role(device, R_SECONDARY, 0);
-- 
1.7.9.5

