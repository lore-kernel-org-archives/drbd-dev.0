Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 14 Oct 2011 23:57:50 +0200
Message-Id: <1318629472-11110-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318629472-11110-1-git-send-email-philipp.reisner@linbit.com>
References: <1318629472-11110-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/11] drbd: receive_protocol(): Make the program
	flow less confusing
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
 drivers/block/drbd/drbd_receiver.c |   73 +++++++++++++++++------------------
 1 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 11f2e72..06bbf0f 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3083,55 +3083,52 @@ static int receive_protocol(struct drbd_tconn *tconn, struct packet_info *pi)
 
 		synchronize_rcu();
 		kfree(old_net_conf);
+	} else {
+		clear_bit(CONN_DRY_RUN, &tconn->flags);
 
-		return 0;
-	}
-
-	clear_bit(CONN_DRY_RUN, &tconn->flags);
+		if (cf & CF_DRY_RUN)
+			set_bit(CONN_DRY_RUN, &tconn->flags);
 
-	if (cf & CF_DRY_RUN)
-		set_bit(CONN_DRY_RUN, &tconn->flags);
+		rcu_read_lock();
+		nc = rcu_dereference(tconn->net_conf);
 
-	rcu_read_lock();
-	nc = rcu_dereference(tconn->net_conf);
+		if (p_proto != nc->wire_protocol) {
+			conn_err(tconn, "incompatible communication protocols\n");
+			goto disconnect_rcu_unlock;
+		}
 
-	if (p_proto != nc->wire_protocol) {
-		conn_err(tconn, "incompatible communication protocols\n");
-		goto disconnect_rcu_unlock;
-	}
+		if (convert_after_sb(p_after_sb_0p) != nc->after_sb_0p) {
+			conn_err(tconn, "incompatible after-sb-0pri settings\n");
+			goto disconnect_rcu_unlock;
+		}
 
-	if (convert_after_sb(p_after_sb_0p) != nc->after_sb_0p) {
-		conn_err(tconn, "incompatible after-sb-0pri settings\n");
-		goto disconnect_rcu_unlock;
-	}
+		if (convert_after_sb(p_after_sb_1p) != nc->after_sb_1p) {
+			conn_err(tconn, "incompatible after-sb-1pri settings\n");
+			goto disconnect_rcu_unlock;
+		}
 
-	if (convert_after_sb(p_after_sb_1p) != nc->after_sb_1p) {
-		conn_err(tconn, "incompatible after-sb-1pri settings\n");
-		goto disconnect_rcu_unlock;
-	}
+		if (convert_after_sb(p_after_sb_2p) != nc->after_sb_2p) {
+			conn_err(tconn, "incompatible after-sb-2pri settings\n");
+			goto disconnect_rcu_unlock;
+		}
 
-	if (convert_after_sb(p_after_sb_2p) != nc->after_sb_2p) {
-		conn_err(tconn, "incompatible after-sb-2pri settings\n");
-		goto disconnect_rcu_unlock;
-	}
+		if (p_discard_my_data && nc->discard_my_data) {
+			conn_err(tconn, "both sides have the 'discard_my_data' flag set\n");
+			goto disconnect_rcu_unlock;
+		}
 
-	if (p_discard_my_data && nc->discard_my_data) {
-		conn_err(tconn, "both sides have the 'discard_my_data' flag set\n");
-		goto disconnect_rcu_unlock;
-	}
+		if (p_two_primaries != nc->two_primaries) {
+			conn_err(tconn, "incompatible setting of the two-primaries options\n");
+			goto disconnect_rcu_unlock;
+		}
 
-	if (p_two_primaries != nc->two_primaries) {
-		conn_err(tconn, "incompatible setting of the two-primaries options\n");
-		goto disconnect_rcu_unlock;
-	}
+		if (strcmp(integrity_alg, nc->integrity_alg)) {
+			conn_err(tconn, "incompatible setting of the data-integrity-alg\n");
+			goto disconnect_rcu_unlock;
+		}
 
-	if (strcmp(integrity_alg, nc->integrity_alg)) {
-		conn_err(tconn, "incompatible setting of the data-integrity-alg\n");
-		goto disconnect_rcu_unlock;
+		rcu_read_unlock();
 	}
-
-	rcu_read_unlock();
-
 	return 0;
 
 disconnect_rcu_unlock:
-- 
1.7.4.1

