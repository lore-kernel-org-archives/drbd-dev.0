Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F373310518BD
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jul 2015 13:22:06 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2015 13:21:40 +0200
Message-Id: <1438255314-14877-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
References: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/19] drbd: drbd_adm_attach(): Add missing
	drbd_resync_after_changed()
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

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index e1d5453..186dc9e 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1541,9 +1541,8 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 
 	write_lock_irq(&global_state_lock);
 	retcode = drbd_resync_after_valid(device, new_disk_conf->resync_after);
-	write_unlock_irq(&global_state_lock);
 	if (retcode != NO_ERROR)
-		goto fail;
+		goto fail_unlock;
 
 	rcu_read_lock();
 	nc = rcu_dereference(connection->net_conf);
@@ -1551,7 +1550,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		if (new_disk_conf->fencing == FP_STONITH && nc->wire_protocol == DRBD_PROT_A) {
 			rcu_read_unlock();
 			retcode = ERR_STONITH_AND_PROT_A;
-			goto fail;
+			goto fail_unlock;
 		}
 	}
 	rcu_read_unlock();
@@ -1562,7 +1561,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		drbd_err(device, "open(\"%s\") failed with %ld\n", new_disk_conf->backing_dev,
 			PTR_ERR(bdev));
 		retcode = ERR_OPEN_DISK;
-		goto fail;
+		goto fail_unlock;
 	}
 	nbc->backing_bdev = bdev;
 
@@ -1582,7 +1581,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		drbd_err(device, "open(\"%s\") failed with %ld\n", new_disk_conf->meta_dev,
 			PTR_ERR(bdev));
 		retcode = ERR_OPEN_MD_DISK;
-		goto fail;
+		goto fail_unlock;
 	}
 	nbc->md_bdev = bdev;
 
@@ -1590,7 +1589,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	    (new_disk_conf->meta_dev_idx == DRBD_MD_INDEX_INTERNAL ||
 	     new_disk_conf->meta_dev_idx == DRBD_MD_INDEX_FLEX_INT)) {
 		retcode = ERR_MD_IDX_INVALID;
-		goto fail;
+		goto fail_unlock;
 	}
 
 	resync_lru = lc_create("resync", drbd_bm_ext_cache,
@@ -1598,14 +1597,14 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 			offsetof(struct bm_extent, lce));
 	if (!resync_lru) {
 		retcode = ERR_NOMEM;
-		goto fail;
+		goto fail_unlock;
 	}
 
 	/* Read our meta data super block early.
 	 * This also sets other on-disk offsets. */
 	retcode = drbd_md_read(device, nbc);
 	if (retcode != NO_ERROR)
-		goto fail;
+		goto fail_unlock;
 
 	if (new_disk_conf->al_extents < DRBD_AL_EXTENTS_MIN)
 		new_disk_conf->al_extents = DRBD_AL_EXTENTS_MIN;
@@ -1617,7 +1616,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 			(unsigned long long) drbd_get_max_capacity(nbc),
 			(unsigned long long) new_disk_conf->disk_size);
 		retcode = ERR_DISK_TOO_SMALL;
-		goto fail;
+		goto fail_unlock;
 	}
 
 	if (new_disk_conf->meta_dev_idx < 0) {
@@ -1634,7 +1633,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		drbd_warn(device, "refusing attach: md-device too small, "
 		     "at least %llu sectors needed for this meta-disk type\n",
 		     (unsigned long long) min_md_device_sectors);
-		goto fail;
+		goto fail_unlock;
 	}
 
 	/* Make sure the new disk is big enough
@@ -1642,7 +1641,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	if (drbd_get_max_capacity(nbc) <
 	    drbd_get_capacity(device->this_bdev)) {
 		retcode = ERR_DISK_TOO_SMALL;
-		goto fail;
+		goto fail_unlock;
 	}
 
 	nbc->known_size = drbd_get_capacity(nbc->backing_bdev);
@@ -1672,7 +1671,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	retcode = rv;  /* FIXME: Type mismatch. */
 	drbd_resume_io(device);
 	if (rv < SS_SUCCESS)
-		goto fail;
+		goto fail_unlock;
 
 	if (!get_ldev_if_state(device, D_ATTACHING))
 		goto force_diskless;
@@ -1727,6 +1726,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	new_disk_conf = NULL;
 	new_plan = NULL;
 
+	drbd_resync_after_changed(device);
 	drbd_bump_write_ordering(device->resource, device->ldev, WO_BDEV_FLUSH);
 
 	if (drbd_md_test_flag(device->ldev, MDF_CRASHED_PRIMARY))
@@ -1850,6 +1850,8 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	if (rv < SS_SUCCESS)
 		goto force_diskless_dec;
 
+	write_unlock(&global_state_lock);
+
 	mod_timer(&device->request_timer, jiffies + HZ);
 
 	if (device->state.role == R_PRIMARY)
@@ -1872,6 +1874,8 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
  force_diskless:
 	drbd_force_state(device, NS(disk, D_DISKLESS));
 	drbd_md_sync(device);
+ fail_unlock:
+	write_unlock_irq(&global_state_lock);
  fail:
 	conn_reconfig_done(connection);
 	if (nbc) {
-- 
1.9.1

