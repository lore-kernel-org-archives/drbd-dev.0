Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 14 Oct 2011 23:57:47 +0200
Message-Id: <1318629472-11110-7-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318629472-11110-1-git-send-email-philipp.reisner@linbit.com>
References: <1318629472-11110-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/11] drbd: Allow to create devices with a minor
	number > minor_count
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

The minor_count module/kernel parameter serves to scale the size of drbd's
internal memory pool, but it is no longer a limit for the number of minors or
the minor number.  (Minor numbers can be arbitrarily high within the allowed
limit of 2^20.)

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 3250c8f..4e0c914 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3086,8 +3086,7 @@ int drbd_adm_add_minor(struct sk_buff *skb, struct genl_info *info)
 	if (retcode != NO_ERROR)
 		goto out;
 
-	/* FIXME drop minor_count parameter, limit to MINORMASK */
-	if (dh->minor >= minor_count) {
+	if (dh->minor > MINORMASK) {
 		drbd_msg_put_info("requested minor out of range");
 		retcode = ERR_INVALID_REQUEST;
 		goto out;
-- 
1.7.4.1

