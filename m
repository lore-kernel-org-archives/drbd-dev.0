Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  6 Oct 2011 15:37:50 +0200
Message-Id: <1317908280-28951-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317908280-28951-1-git-send-email-philipp.reisner@linbit.com>
References: <1317908280-28951-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/15] drbd: Renamed (old|new)_conf into
	(old|new)_net_conf in receive_SyncParam
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Preparing RCU for disk_conf

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 23614e4..bba0050 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3146,7 +3146,7 @@ static int receive_SyncParam(struct drbd_tconn *tconn, struct packet_info *pi)
 	unsigned int header_size, data_size, exp_max_sz;
 	struct crypto_hash *verify_tfm = NULL;
 	struct crypto_hash *csums_tfm = NULL;
-	struct net_conf *old_conf, *new_conf = NULL;
+	struct net_conf *old_net_conf, *new_net_conf = NULL;
 	const int apv = tconn->agreed_pro_version;
 	int *rs_plan_s = NULL;
 	int fifo_size = 0;
@@ -3222,12 +3222,12 @@ static int receive_SyncParam(struct drbd_tconn *tconn, struct packet_info *pi)
 		}
 
 		mutex_lock(&mdev->tconn->conf_update);
-		old_conf = mdev->tconn->net_conf;
+		old_net_conf = mdev->tconn->net_conf;
 
-		if (strcmp(old_conf->verify_alg, p->verify_alg)) {
+		if (strcmp(old_net_conf->verify_alg, p->verify_alg)) {
 			if (mdev->state.conn == C_WF_REPORT_PARAMS) {
 				dev_err(DEV, "Different verify-alg settings. me=\"%s\" peer=\"%s\"\n",
-				    old_conf->verify_alg, p->verify_alg);
+				    old_net_conf->verify_alg, p->verify_alg);
 				goto disconnect;
 			}
 			verify_tfm = drbd_crypto_alloc_digest_safe(mdev,
@@ -3238,10 +3238,10 @@ static int receive_SyncParam(struct drbd_tconn *tconn, struct packet_info *pi)
 			}
 		}
 
-		if (apv >= 89 && strcmp(old_conf->csums_alg, p->csums_alg)) {
+		if (apv >= 89 && strcmp(old_net_conf->csums_alg, p->csums_alg)) {
 			if (mdev->state.conn == C_WF_REPORT_PARAMS) {
 				dev_err(DEV, "Different csums-alg settings. me=\"%s\" peer=\"%s\"\n",
-				    old_conf->csums_alg, p->csums_alg);
+				    old_net_conf->csums_alg, p->csums_alg);
 				goto disconnect;
 			}
 			csums_tfm = drbd_crypto_alloc_digest_safe(mdev,
@@ -3272,34 +3272,34 @@ static int receive_SyncParam(struct drbd_tconn *tconn, struct packet_info *pi)
 		}
 
 		if (verify_tfm || csums_tfm) {
-			new_conf = kzalloc(sizeof(struct net_conf), GFP_KERNEL);
-			if (!new_conf) {
+			new_net_conf = kzalloc(sizeof(struct net_conf), GFP_KERNEL);
+			if (!new_net_conf) {
 				dev_err(DEV, "Allocation of new net_conf failed\n");
 				goto disconnect;
 			}
 
-			*new_conf = *old_conf;
+			*new_net_conf = *old_net_conf;
 
 			if (verify_tfm) {
-				strcpy(new_conf->verify_alg, p->verify_alg);
-				new_conf->verify_alg_len = strlen(p->verify_alg) + 1;
+				strcpy(new_net_conf->verify_alg, p->verify_alg);
+				new_net_conf->verify_alg_len = strlen(p->verify_alg) + 1;
 				crypto_free_hash(mdev->tconn->verify_tfm);
 				mdev->tconn->verify_tfm = verify_tfm;
 				dev_info(DEV, "using verify-alg: \"%s\"\n", p->verify_alg);
 			}
 			if (csums_tfm) {
-				strcpy(new_conf->csums_alg, p->csums_alg);
-				new_conf->csums_alg_len = strlen(p->csums_alg) + 1;
+				strcpy(new_net_conf->csums_alg, p->csums_alg);
+				new_net_conf->csums_alg_len = strlen(p->csums_alg) + 1;
 				crypto_free_hash(mdev->tconn->csums_tfm);
 				mdev->tconn->csums_tfm = csums_tfm;
 				dev_info(DEV, "using csums-alg: \"%s\"\n", p->csums_alg);
 			}
-			rcu_assign_pointer(tconn->net_conf, new_conf);
+			rcu_assign_pointer(tconn->net_conf, new_net_conf);
 		}
 		mutex_unlock(&mdev->tconn->conf_update);
-		if (new_conf) {
+		if (new_net_conf) {
 			synchronize_rcu();
-			kfree(old_conf);
+			kfree(old_net_conf);
 		}
 
 		spin_lock(&mdev->peer_seq_lock);
-- 
1.7.4.1

