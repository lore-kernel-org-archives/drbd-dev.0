Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed,  5 Oct 2011 11:37:54 +0200
Message-Id: <1317807484-24628-7-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317807484-24628-1-git-send-email-philipp.reisner@linbit.com>
References: <1317807484-24628-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/16] drbd: Wrong use of RCU in
	receive_protocol()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

It is not enough to grab net_conf->integrity_alg under rcu_read_lock()
and access it outside of it; the entire net_conf object may be gone by
then.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 6da7aeb..98f03b1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2998,7 +2998,6 @@ static int receive_protocol(struct drbd_tconn *tconn, struct packet_info *pi)
 	int p_proto, p_after_sb_0p, p_after_sb_1p, p_after_sb_2p;
 	int p_want_lose, p_two_primaries, cf;
 	char p_integrity_alg[SHARED_SECRET_MAX] = "";
-	unsigned char *my_alg;
 	struct net_conf *nc;
 
 	p_proto		= be32_to_cpu(p->protocol);
@@ -3009,6 +3008,18 @@ static int receive_protocol(struct drbd_tconn *tconn, struct packet_info *pi)
 	cf		= be32_to_cpu(p->conn_flags);
 	p_want_lose = cf & CF_WANT_LOSE;
 
+	if (tconn->agreed_pro_version >= 87) {
+		int err;
+
+		if (pi->size > sizeof(p_integrity_alg))
+			return -EIO;
+		err = drbd_recv_all(tconn, p_integrity_alg, pi->size);
+		if (err)
+			return err;
+
+		p_integrity_alg[SHARED_SECRET_MAX-1] = 0;
+	}
+
 	clear_bit(CONN_DRY_RUN, &tconn->flags);
 
 	if (cf & CF_DRY_RUN)
@@ -3047,23 +3058,18 @@ static int receive_protocol(struct drbd_tconn *tconn, struct packet_info *pi)
 		goto disconnect_rcu_unlock;
 	}
 
-	my_alg = nc->integrity_alg;
-	rcu_read_unlock();
-
 	if (tconn->agreed_pro_version >= 87) {
-		int err;
-
-		err = drbd_recv_all(tconn, p_integrity_alg, pi->size);
-		if (err)
-			return err;
-
-		p_integrity_alg[SHARED_SECRET_MAX-1] = 0;
-		if (strcmp(p_integrity_alg, my_alg)) {
+		if (strcmp(p_integrity_alg, nc->integrity_alg)) {
 			conn_err(tconn, "incompatible setting of the data-integrity-alg\n");
 			goto disconnect;
 		}
+	}
+
+	rcu_read_unlock();
+
+	if (tconn->agreed_pro_version >= 87) {
 		conn_info(tconn, "data-integrity-alg: %s\n",
-		     my_alg[0] ? my_alg : (unsigned char *)"<not-used>");
+			  nc->integrity_alg[0] ? nc->integrity_alg : (unsigned char *)"<not-used>");
 	}
 
 	return 0;
-- 
1.7.4.1

