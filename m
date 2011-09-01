Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  1 Sep 2011 14:49:01 +0200
Message-Id: <1314881345-6420-15-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
References: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/18] drbd: Allow a Diskless Secondary volume to
	be removed
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Even if the connection is still established.
We should be able to reduce a volume from a replication group,
without taking the whole group offline.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index c389995..740649b 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -248,6 +248,8 @@ static int drbd_adm_prepare(struct sk_buff *skb, struct genl_info *info,
 		drbd_msg_put_info("over-determined configuration context mismatch");
 		return ERR_INVALID_REQUEST;
 	}
+	if (adm_ctx.mdev && !adm_ctx.tconn)
+		adm_ctx.tconn = adm_ctx.mdev->tconn;
 	return NO_ERROR;
 
 fail:
@@ -2676,10 +2678,15 @@ int drbd_adm_delete_minor(struct sk_buff *skb, struct genl_info *info)
 
 	mdev = adm_ctx.mdev;
 	if (mdev->state.disk == D_DISKLESS &&
-	    mdev->state.conn == C_STANDALONE &&
+	    /* no need to be mdev->state.conn == C_STANDALONE &&
+	     * we may want to delete a minor from a live replication group.
+	     */
 	    mdev->state.role == R_SECONDARY) {
 		drbd_delete_device(mdev_to_minor(mdev));
 		retcode = NO_ERROR;
+		/* if this was the last volume of this connection,
+		 * this will terminate all threads */
+		conn_reconfig_done(adm_ctx.tconn);
 	} else
 		retcode = ERR_MINOR_CONFIGURED;
 out:
-- 
1.7.4.1

