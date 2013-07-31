Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 31 Jul 2013 11:41:11 +0200
Message-Id: <1375263675-18410-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1375263675-18410-1-git-send-email-philipp.reisner@linbit.com>
References: <1375263675-18410-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/5] drbd: fix NULL pointer deref in module init
	error path
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

If we want to iterate over the (as of yet still empty) list in the
cleanup path, we need to initialize the list before the first goto fail.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 55635ed..9e3818b 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2750,13 +2750,6 @@ int __init drbd_init(void)
 		return err;
 	}
 
-	err = drbd_genl_register();
-	if (err) {
-		printk(KERN_ERR "drbd: unable to register generic netlink family\n");
-		goto fail;
-	}
-
-
 	register_reboot_notifier(&drbd_notifier);
 
 	/*
@@ -2767,6 +2760,15 @@ int __init drbd_init(void)
 	drbd_proc = NULL; /* play safe for drbd_cleanup */
 	idr_init(&minors);
 
+	rwlock_init(&global_state_lock);
+	INIT_LIST_HEAD(&drbd_tconns);
+
+	err = drbd_genl_register();
+	if (err) {
+		printk(KERN_ERR "drbd: unable to register generic netlink family\n");
+		goto fail;
+	}
+
 	err = drbd_create_mempools();
 	if (err)
 		goto fail;
@@ -2778,9 +2780,6 @@ int __init drbd_init(void)
 		goto fail;
 	}
 
-	rwlock_init(&global_state_lock);
-	INIT_LIST_HEAD(&drbd_tconns);
-
 	retry.wq = create_singlethread_workqueue("drbd-reissue");
 	if (!retry.wq) {
 		printk(KERN_ERR "drbd: unable to create retry workqueue\n");
-- 
1.7.9.5

