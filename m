Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 10 Oct 2011 13:55:05 +0200
Message-Id: <1318247706-7732-13-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
References: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/13] drbd: drbd_adm_prepare(): Pass through
	error codes
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
 drivers/block/drbd/drbd_nl.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index fc0ea77..011f7f4 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -180,15 +180,19 @@ static int drbd_adm_prepare(struct sk_buff *skb, struct genl_info *info,
 	       return -EPERM;
 
 	adm_ctx.reply_skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!adm_ctx.reply_skb)
+	if (!adm_ctx.reply_skb) {
+		err = -ENOMEM;
 		goto fail;
+	}
 
 	adm_ctx.reply_dh = genlmsg_put_reply(adm_ctx.reply_skb,
 					info, &drbd_genl_family, 0, cmd);
 	/* put of a few bytes into a fresh skb of >= 4k will always succeed.
 	 * but anyways */
-	if (!adm_ctx.reply_dh)
+	if (!adm_ctx.reply_dh) {
+		err = -ENOMEM;
 		goto fail;
+	}
 
 	adm_ctx.reply_dh->minor = d_in->minor;
 	adm_ctx.reply_dh->ret_code = NO_ERROR;
@@ -257,7 +261,7 @@ static int drbd_adm_prepare(struct sk_buff *skb, struct genl_info *info,
 fail:
 	nlmsg_free(adm_ctx.reply_skb);
 	adm_ctx.reply_skb = NULL;
-	return -ENOMEM;
+	return err;
 }
 
 static int drbd_adm_finish(struct genl_info *info, int retcode)
-- 
1.7.4.1

