Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 30 Sep 2011 14:48:23 +0200
Message-Id: <1317386906-19260-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317386906-19260-1-git-send-email-philipp.reisner@linbit.com>
References: <1317386906-19260-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/11] drbd: Allow online change of replication
	protocol only with agreed_pv >= 100
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |    5 +++++
 include/linux/drbd.h         |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 0bf1c2e..bb41af1 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1711,6 +1711,11 @@ check_net_options(struct drbd_tconn *tconn, struct net_conf *new_conf)
 	struct drbd_conf *mdev;
 	int i;
 
+	if (tconn->net_conf && tconn->agreed_pro_version < 100 &&
+	    tconn->cstate == C_WF_REPORT_PARAMS &&
+	    new_conf->wire_protocol != tconn->net_conf->wire_protocol)
+		return ERR_NEED_APV_100;
+
 	if (new_conf->two_primaries &&
 	    (new_conf->wire_protocol != DRBD_PROT_C))
 		return ERR_NOT_PROTO_C;
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index fe8d6ba..6c7c85d 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -160,6 +160,7 @@ enum drbd_ret_code {
 	ERR_MINOR_CONFIGURED    = 160,
 	ERR_MINOR_EXISTS	= 161,
 	ERR_INVALID_REQUEST	= 162,
+	ERR_NEED_APV_100	= 163,
 
 	/* insert new ones above this line */
 	AFTER_LAST_ERR_CODE
-- 
1.7.4.1

