Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 13 Oct 2011 12:32:11 +0200
Message-Id: <1318501936-11689-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318501936-11689-1-git-send-email-philipp.reisner@linbit.com>
References: <1318501936-11689-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/10] drbd: Fixed state transitions in case
	reading meta data failes
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
 drivers/block/drbd/drbd_nl.c    |    2 +-
 drivers/block/drbd/drbd_state.c |    7 -------
 2 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index ec4829b..0f8d473 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1685,7 +1685,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
  force_diskless_dec:
 	put_ldev(mdev);
  force_diskless:
-	drbd_force_state(mdev, NS(disk, D_FAILED));
+	drbd_force_state(mdev, NS(disk, D_DISKLESS));
 	drbd_md_sync(mdev);
  fail:
 	conn_reconfig_done(mdev->tconn);
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 3221743..65ba12b 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -655,13 +655,6 @@ is_valid_transition(union drbd_state os, union drbd_state ns)
 	if (ns.disk == D_FAILED && os.disk == D_DISKLESS)
 		rv = SS_IS_DISKLESS;
 
-	/* if we are only D_ATTACHING yet,
-	 * we can (and should) go directly to D_DISKLESS. */
-	if (ns.disk == D_FAILED && os.disk == D_ATTACHING) {
-		printk("TODO: FIX ME\n");
-		rv = SS_IS_DISKLESS;
-	}
-
 	return rv;
 }
 
-- 
1.7.4.1

