Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 14 Jun 2013 20:54:20 +0200
Message-Id: <1371236063-17198-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1371236063-17198-1-git-send-email-philipp.reisner@linbit.com>
References: <1371236063-17198-1-git-send-email-philipp.reisner@linbit.com>
Cc: Andreas Gruenbacher <agruen@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/6] drbd: Fix rcu_read_lock balance on error path
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
 drivers/block/drbd/drbd_nl.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 9e3f441..0936d6a 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2658,7 +2658,6 @@ int nla_put_status_info(struct sk_buff *skb, struct drbd_conf *mdev,
 		const struct sib_info *sib)
 {
 	struct state_info *si = NULL; /* for sizeof(si->member); */
-	struct net_conf *nc;
 	struct nlattr *nla;
 	int got_ldev;
 	int err = 0;
@@ -2688,13 +2687,19 @@ int nla_put_status_info(struct sk_buff *skb, struct drbd_conf *mdev,
 		goto nla_put_failure;
 
 	rcu_read_lock();
-	if (got_ldev)
-		if (disk_conf_to_skb(skb, rcu_dereference(mdev->ldev->disk_conf), exclude_sensitive))
-			goto nla_put_failure;
+	if (got_ldev) {
+		struct disk_conf *disk_conf;
 
-	nc = rcu_dereference(mdev->tconn->net_conf);
-	if (nc)
-		err = net_conf_to_skb(skb, nc, exclude_sensitive);
+		disk_conf = rcu_dereference(mdev->ldev->disk_conf);
+		err = disk_conf_to_skb(skb, disk_conf, exclude_sensitive);
+	}
+	if (!err) {
+		struct net_conf *nc;
+
+		nc = rcu_dereference(mdev->tconn->net_conf);
+		if (nc)
+			err = net_conf_to_skb(skb, nc, exclude_sensitive);
+	}
 	rcu_read_unlock();
 	if (err)
 		goto nla_put_failure;
-- 
1.7.9.5

