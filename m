Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 10 Oct 2011 13:54:57 +0200
Message-Id: <1318247706-7732-5-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
References: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/13] drbd: Allocation of int_dig_in and
	int_dig_vv was missing
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
 drivers/block/drbd/drbd_receiver.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index b5eeb8d..61b57fc 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3004,6 +3004,7 @@ static int receive_protocol(struct drbd_tconn *tconn, struct packet_info *pi)
 	int p_proto, p_after_sb_0p, p_after_sb_1p, p_after_sb_2p;
 	int p_discard_my_data, p_two_primaries, cf;
 	struct net_conf *nc;
+	void *int_dig_in = NULL, *int_dig_vv = NULL;
 
 	p_proto		= be32_to_cpu(p->protocol);
 	p_after_sb_0p	= be32_to_cpu(p->after_sb_0p);
@@ -3026,6 +3027,8 @@ static int receive_protocol(struct drbd_tconn *tconn, struct packet_info *pi)
 		integrity_alg[SHARED_SECRET_MAX-1] = 0;
 
 		if (integrity_alg[0]) {
+			int hash_size;
+
 			tfm = crypto_alloc_hash(integrity_alg, 0, CRYPTO_ALG_ASYNC);
 			if (!tfm) {
 				conn_err(tconn, "peer data-integrity-alg %s not supported\n",
@@ -3033,11 +3036,23 @@ static int receive_protocol(struct drbd_tconn *tconn, struct packet_info *pi)
 				goto disconnect;
 			}
 			conn_info(tconn, "peer data-integrity-alg: %s\n", integrity_alg);
+
+			hash_size = crypto_hash_digestsize(tfm);
+			int_dig_in = kmalloc(hash_size, GFP_KERNEL);
+			int_dig_vv = kmalloc(hash_size, GFP_KERNEL);
+			if (!(int_dig_in && int_dig_vv)) {
+				crypto_free_hash(tfm);
+				goto disconnect;
+			}
 		}
 
 		if (tconn->peer_integrity_tfm)
 			crypto_free_hash(tconn->peer_integrity_tfm);
 		tconn->peer_integrity_tfm = tfm;
+		kfree(tconn->int_dig_in);
+		kfree(tconn->int_dig_vv);
+		tconn->int_dig_in = int_dig_in;
+		tconn->int_dig_vv = int_dig_vv;
 	}
 
 	clear_bit(CONN_DRY_RUN, &tconn->flags);
-- 
1.7.4.1

