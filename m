Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 10 Oct 2011 13:54:54 +0200
Message-Id: <1318247706-7732-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
References: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/13] drbd: Refuse to change network options
	online when...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

* the peer does not speak protocol_version 100 and the
  user wants to change one of:
    - wire_protocol
    - two_primaries
    - integrity_alg

* the user wants to remove the allow_two_primaries flag
  when there are two primaries

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |   22 ++++++++++++++++++----
 include/linux/drbd.h         |    1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 972178b..87fd3bf 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1771,10 +1771,24 @@ _check_net_options(struct drbd_tconn *tconn, struct net_conf *old_conf, struct n
 	struct drbd_conf *mdev;
 	int i;
 
-	if (old_conf && tconn->agreed_pro_version < 100 &&
-	    tconn->cstate == C_WF_REPORT_PARAMS &&
-	    new_conf->wire_protocol != old_conf->wire_protocol)
-		return ERR_NEED_APV_100;
+	if (old_conf && tconn->cstate == C_WF_REPORT_PARAMS && tconn->agreed_pro_version < 100) {
+		if (new_conf->wire_protocol != old_conf->wire_protocol)
+			return ERR_NEED_APV_100;
+
+		if (new_conf->two_primaries != old_conf->two_primaries)
+			return ERR_NEED_APV_100;
+
+		if (!new_conf->integrity_alg != !old_conf->integrity_alg)
+			return ERR_NEED_APV_100;
+
+		if (strcmp(new_conf->integrity_alg, old_conf->integrity_alg))
+			return ERR_NEED_APV_100;
+	}
+
+	if (!new_conf->two_primaries &&
+	    conn_highest_role(tconn) == R_PRIMARY &&
+	    conn_highest_peer(tconn) == R_PRIMARY)
+		return ERR_NEED_ALLOW_TWO_PRI;
 
 	if (new_conf->two_primaries &&
 	    (new_conf->wire_protocol != DRBD_PROT_C))
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 05063e6..679e811 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -161,6 +161,7 @@ enum drbd_ret_code {
 	ERR_MINOR_EXISTS	= 161,
 	ERR_INVALID_REQUEST	= 162,
 	ERR_NEED_APV_100	= 163,
+	ERR_NEED_ALLOW_TWO_PRI  = 164,
 
 	/* insert new ones above this line */
 	AFTER_LAST_ERR_CODE
-- 
1.7.4.1

