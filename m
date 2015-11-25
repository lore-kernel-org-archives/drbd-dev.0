Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 67FC51056192
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:29 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:53:40 +0100
Message-Id: <1448448851-10343-8-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/38] drbd: Fix locking across all resources
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

Instead of using a rwlock for synchronizing state changes across
resources, take the request locks of all resources for global state
changes.  Use resources_mutex to serialize global state changes.

This means that taking the request lock of a resource is now enough to
prevent changes of that resource.  (Previously, a read lock on the
global state lock was needed as well.)

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h    | 18 ++-------
 drivers/block/drbd/drbd_main.c   | 24 +++++++++++-
 drivers/block/drbd/drbd_nl.c     | 45 +++++++++++----------
 drivers/block/drbd/drbd_state.c  | 14 +++----
 drivers/block/drbd/drbd_state.h  |  6 +--
 drivers/block/drbd/drbd_worker.c | 85 ++++++++++++++++++----------------------
 6 files changed, 99 insertions(+), 93 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 47d4b02..2c9ee22 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -292,6 +292,9 @@ struct drbd_device_work {
 
 extern int drbd_wait_misc(struct drbd_device *, struct drbd_interval *);
 
+extern void lock_all_resources(void);
+extern void unlock_all_resources(void);
+
 struct drbd_request {
 	struct drbd_work w;
 	struct drbd_device *device;
@@ -1418,7 +1421,7 @@ extern struct bio_set *drbd_md_io_bio_set;
 /* to allocate from that set */
 extern struct bio *bio_alloc_drbd(gfp_t gfp_mask);
 
-extern rwlock_t global_state_lock;
+extern struct mutex resources_mutex;
 
 extern int conn_lowest_minor(struct drbd_connection *connection);
 extern enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsigned int minor);
@@ -1688,19 +1691,6 @@ static inline int drbd_peer_req_has_active_page(struct drbd_peer_request *peer_r
 	return 0;
 }
 
-static inline enum drbd_state_rv
-_drbd_set_state(struct drbd_device *device, union drbd_state ns,
-		enum chg_state_flags flags, struct completion *done)
-{
-	enum drbd_state_rv rv;
-
-	read_lock(&global_state_lock);
-	rv = __drbd_set_state(device, ns, flags, done);
-	read_unlock(&global_state_lock);
-
-	return rv;
-}
-
 static inline union drbd_state drbd_read_state(struct drbd_device *device)
 {
 	struct drbd_resource *resource = device->resource;
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 3ee4a44..f66294d 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -117,6 +117,7 @@ module_param_string(usermode_helper, usermode_helper, sizeof(usermode_helper), 0
  */
 struct idr drbd_devices;
 struct list_head drbd_resources;
+struct mutex resources_mutex;
 
 struct kmem_cache *drbd_request_cache;
 struct kmem_cache *drbd_ee_cache;	/* peer requests */
@@ -2923,7 +2924,7 @@ static int __init drbd_init(void)
 	drbd_proc = NULL; /* play safe for drbd_cleanup */
 	idr_init(&drbd_devices);
 
-	rwlock_init(&global_state_lock);
+	mutex_init(&resources_mutex);
 	INIT_LIST_HEAD(&drbd_resources);
 
 	err = drbd_genl_register();
@@ -3746,6 +3747,27 @@ int drbd_wait_misc(struct drbd_device *device, struct drbd_interval *i)
 	return 0;
 }
 
+void lock_all_resources(void)
+{
+	struct drbd_resource *resource;
+	int __maybe_unused i = 0;
+
+	mutex_lock(&resources_mutex);
+	local_irq_disable();
+	for_each_resource(resource, &drbd_resources)
+		spin_lock_nested(&resource->req_lock, i++);
+}
+
+void unlock_all_resources(void)
+{
+	struct drbd_resource *resource;
+
+	for_each_resource(resource, &drbd_resources)
+		spin_unlock(&resource->req_lock);
+	local_irq_enable();
+	mutex_unlock(&resources_mutex);
+}
+
 #ifdef CONFIG_DRBD_FAULT_INJECTION
 /* Fault insertion support including random number generator shamelessly
  * stolen from kernel/rcutorture.c */
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 94e380f..d37c509 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1389,13 +1389,13 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 		goto fail_unlock;
 	}
 
-	write_lock_irq(&global_state_lock);
+	lock_all_resources();
 	retcode = drbd_resync_after_valid(device, new_disk_conf->resync_after);
 	if (retcode == NO_ERROR) {
 		rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
 		drbd_resync_after_changed(device);
 	}
-	write_unlock_irq(&global_state_lock);
+	unlock_all_resources();
 
 	if (retcode != NO_ERROR)
 		goto fail_unlock;
@@ -1539,18 +1539,13 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		goto fail;
 	}
 
-	write_lock_irq(&global_state_lock);
-	retcode = drbd_resync_after_valid(device, new_disk_conf->resync_after);
-	if (retcode != NO_ERROR)
-		goto fail_unlock;
-
 	rcu_read_lock();
 	nc = rcu_dereference(connection->net_conf);
 	if (nc) {
 		if (new_disk_conf->fencing == FP_STONITH && nc->wire_protocol == DRBD_PROT_A) {
 			rcu_read_unlock();
 			retcode = ERR_STONITH_AND_PROT_A;
-			goto fail_unlock;
+			goto fail;
 		}
 	}
 	rcu_read_unlock();
@@ -1561,7 +1556,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		drbd_err(device, "open(\"%s\") failed with %ld\n", new_disk_conf->backing_dev,
 			PTR_ERR(bdev));
 		retcode = ERR_OPEN_DISK;
-		goto fail_unlock;
+		goto fail;
 	}
 	nbc->backing_bdev = bdev;
 
@@ -1581,7 +1576,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		drbd_err(device, "open(\"%s\") failed with %ld\n", new_disk_conf->meta_dev,
 			PTR_ERR(bdev));
 		retcode = ERR_OPEN_MD_DISK;
-		goto fail_unlock;
+		goto fail;
 	}
 	nbc->md_bdev = bdev;
 
@@ -1589,7 +1584,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	    (new_disk_conf->meta_dev_idx == DRBD_MD_INDEX_INTERNAL ||
 	     new_disk_conf->meta_dev_idx == DRBD_MD_INDEX_FLEX_INT)) {
 		retcode = ERR_MD_IDX_INVALID;
-		goto fail_unlock;
+		goto fail;
 	}
 
 	resync_lru = lc_create("resync", drbd_bm_ext_cache,
@@ -1597,14 +1592,14 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 			offsetof(struct bm_extent, lce));
 	if (!resync_lru) {
 		retcode = ERR_NOMEM;
-		goto fail_unlock;
+		goto fail;
 	}
 
 	/* Read our meta data super block early.
 	 * This also sets other on-disk offsets. */
 	retcode = drbd_md_read(device, nbc);
 	if (retcode != NO_ERROR)
-		goto fail_unlock;
+		goto fail;
 
 	if (new_disk_conf->al_extents < DRBD_AL_EXTENTS_MIN)
 		new_disk_conf->al_extents = DRBD_AL_EXTENTS_MIN;
@@ -1616,7 +1611,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 			(unsigned long long) drbd_get_max_capacity(nbc),
 			(unsigned long long) new_disk_conf->disk_size);
 		retcode = ERR_DISK_TOO_SMALL;
-		goto fail_unlock;
+		goto fail;
 	}
 
 	if (new_disk_conf->meta_dev_idx < 0) {
@@ -1633,7 +1628,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		drbd_warn(device, "refusing attach: md-device too small, "
 		     "at least %llu sectors needed for this meta-disk type\n",
 		     (unsigned long long) min_md_device_sectors);
-		goto fail_unlock;
+		goto fail;
 	}
 
 	/* Make sure the new disk is big enough
@@ -1641,7 +1636,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	if (drbd_get_max_capacity(nbc) <
 	    drbd_get_capacity(device->this_bdev)) {
 		retcode = ERR_DISK_TOO_SMALL;
-		goto fail_unlock;
+		goto fail;
 	}
 
 	nbc->known_size = drbd_get_capacity(nbc->backing_bdev);
@@ -1671,7 +1666,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	retcode = rv;  /* FIXME: Type mismatch. */
 	drbd_resume_io(device);
 	if (rv < SS_SUCCESS)
-		goto fail_unlock;
+		goto fail;
 
 	if (!get_ldev_if_state(device, D_ATTACHING))
 		goto force_diskless;
@@ -1706,6 +1701,13 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		goto force_diskless_dec;
 	}
 
+	lock_all_resources();
+	retcode = drbd_resync_after_valid(device, new_disk_conf->resync_after);
+	if (retcode != NO_ERROR) {
+		unlock_all_resources();
+		goto force_diskless_dec;
+	}
+
 	/* Reset the "barriers don't work" bits here, then force meta data to
 	 * be written, to ensure we determine if barriers are supported. */
 	if (new_disk_conf->md_flushes)
@@ -1728,6 +1730,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 
 	drbd_resync_after_changed(device);
 	drbd_bump_write_ordering(device->resource, device->ldev, WO_BDEV_FLUSH);
+	unlock_all_resources();
 
 	if (drbd_md_test_flag(device->ldev, MDF_CRASHED_PRIMARY))
 		set_bit(CRASHED_PRIMARY, &device->flags);
@@ -1850,8 +1853,6 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	if (rv < SS_SUCCESS)
 		goto force_diskless_dec;
 
-	write_unlock(&global_state_lock);
-
 	mod_timer(&device->request_timer, jiffies + HZ);
 
 	if (device->state.role == R_PRIMARY)
@@ -1874,8 +1875,6 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
  force_diskless:
 	drbd_force_state(device, NS(disk, D_DISKLESS));
 	drbd_md_sync(device);
- fail_unlock:
-	write_unlock_irq(&global_state_lock);
  fail:
 	conn_reconfig_done(connection);
 	if (nbc) {
@@ -3453,8 +3452,10 @@ int drbd_adm_new_resource(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* not yet safe for genl_family.parallel_ops */
+	mutex_lock(&resources_mutex);
 	if (!conn_create(adm_ctx.resource_name, &res_opts))
 		retcode = ERR_NOMEM;
+	mutex_unlock(&resources_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -3545,7 +3546,9 @@ static int adm_del_resource(struct drbd_resource *resource)
 	if (!idr_is_empty(&resource->devices))
 		return ERR_RES_IN_USE;
 
+	mutex_lock(&resources_mutex);
 	list_del_rcu(&resource->resources);
+	mutex_unlock(&resources_mutex);
 	/* Make sure all threads have actually stopped: state handling only
 	 * does drbd_thread_stop_nowait(). */
 	list_for_each_entry(connection, &resource->connections, connections)
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 2d7dd26..535ae47 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -937,7 +937,7 @@ void drbd_resume_al(struct drbd_device *device)
 		drbd_info(device, "Resumed AL updates\n");
 }
 
-/* helper for __drbd_set_state */
+/* helper for _drbd_set_state */
 static void set_ov_position(struct drbd_device *device, enum drbd_conns cs)
 {
 	if (first_peer_device(device)->connection->agreed_pro_version < 90)
@@ -965,17 +965,17 @@ static void set_ov_position(struct drbd_device *device, enum drbd_conns cs)
 }
 
 /**
- * __drbd_set_state() - Set a new DRBD state
+ * _drbd_set_state() - Set a new DRBD state
  * @device:	DRBD device.
  * @ns:		new state.
  * @flags:	Flags
  * @done:	Optional completion, that will get completed after the after_state_ch() finished
  *
- * Caller needs to hold req_lock, and global_state_lock. Do not call directly.
+ * Caller needs to hold req_lock. Do not call directly.
  */
 enum drbd_state_rv
-__drbd_set_state(struct drbd_device *device, union drbd_state ns,
-	         enum chg_state_flags flags, struct completion *done)
+_drbd_set_state(struct drbd_device *device, union drbd_state ns,
+	        enum chg_state_flags flags, struct completion *done)
 {
 	struct drbd_peer_device *peer_device = first_peer_device(device);
 	struct drbd_connection *connection = peer_device ? peer_device->connection : NULL;
@@ -1444,7 +1444,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 	if (os.disk != D_FAILED && ns.disk == D_FAILED) {
 		enum drbd_io_error_p eh = EP_PASS_ON;
 		int was_io_error = 0;
-		/* corresponding get_ldev was in __drbd_set_state, to serialize
+		/* corresponding get_ldev was in _drbd_set_state, to serialize
 		 * our cleanup here with the transition to D_DISKLESS.
 		 * But is is still not save to dreference ldev here, since
 		 * we might come from an failed Attach before ldev was set. */
@@ -1759,7 +1759,7 @@ conn_set_state(struct drbd_connection *connection, union drbd_state mask, union
 		if (flags & CS_IGN_OUTD_FAIL && ns.disk == D_OUTDATED && os.disk < D_OUTDATED)
 			ns.disk = os.disk;
 
-		rv = __drbd_set_state(device, ns, flags, NULL);
+		rv = _drbd_set_state(device, ns, flags, NULL);
 		if (rv < SS_SUCCESS)
 			BUG();
 
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index 7f53c40..bd98953 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -122,9 +122,9 @@ extern enum drbd_state_rv
 _drbd_request_state_holding_state_mutex(struct drbd_device *, union drbd_state,
 					union drbd_state, enum chg_state_flags);
 
-extern enum drbd_state_rv __drbd_set_state(struct drbd_device *, union drbd_state,
-					   enum chg_state_flags,
-					   struct completion *done);
+extern enum drbd_state_rv _drbd_set_state(struct drbd_device *, union drbd_state,
+					  enum chg_state_flags,
+					  struct completion *done);
 extern void print_st_err(struct drbd_device *, union drbd_state,
 			union drbd_state, int);
 
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 5578c14..3b3d980 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -55,13 +55,6 @@ static int make_resync_request(struct drbd_device *, int);
  *
  */
 
-
-/* About the global_state_lock
-   Each state transition on an device holds a read lock. In case we have
-   to evaluate the resync after dependencies, we grab a write lock, because
-   we need stable states on all devices for that.  */
-rwlock_t global_state_lock;
-
 /* used for synchronous meta data and bitmap IO
  * submitted by drbd_md_sync_page_io()
  */
@@ -1456,70 +1449,73 @@ static int _drbd_may_sync_now(struct drbd_device *device)
 }
 
 /**
- * _drbd_pause_after() - Pause resync on all devices that may not resync now
+ * drbd_pause_after() - Pause resync on all devices that may not resync now
  * @device:	DRBD device.
  *
  * Called from process context only (admin command and after_state_ch).
  */
-static int _drbd_pause_after(struct drbd_device *device)
+static bool drbd_pause_after(struct drbd_device *device)
 {
+	bool changed = false;
 	struct drbd_device *odev;
-	int i, rv = 0;
+	int i;
 
 	rcu_read_lock();
 	idr_for_each_entry(&drbd_devices, odev, i) {
 		if (odev->state.conn == C_STANDALONE && odev->state.disk == D_DISKLESS)
 			continue;
-		if (!_drbd_may_sync_now(odev))
-			rv |= (__drbd_set_state(_NS(odev, aftr_isp, 1), CS_HARD, NULL)
-			       != SS_NOTHING_TO_DO);
+		if (!_drbd_may_sync_now(odev) &&
+		    _drbd_set_state(_NS(odev, aftr_isp, 1),
+				    CS_HARD, NULL) != SS_NOTHING_TO_DO)
+			changed = true;
 	}
 	rcu_read_unlock();
 
-	return rv;
+	return changed;
 }
 
 /**
- * _drbd_resume_next() - Resume resync on all devices that may resync now
+ * drbd_resume_next() - Resume resync on all devices that may resync now
  * @device:	DRBD device.
  *
  * Called from process context only (admin command and worker).
  */
-static int _drbd_resume_next(struct drbd_device *device)
+static bool drbd_resume_next(struct drbd_device *device)
 {
+	bool changed = false;
 	struct drbd_device *odev;
-	int i, rv = 0;
+	int i;
 
 	rcu_read_lock();
 	idr_for_each_entry(&drbd_devices, odev, i) {
 		if (odev->state.conn == C_STANDALONE && odev->state.disk == D_DISKLESS)
 			continue;
 		if (odev->state.aftr_isp) {
-			if (_drbd_may_sync_now(odev))
-				rv |= (__drbd_set_state(_NS(odev, aftr_isp, 0),
-							CS_HARD, NULL)
-				       != SS_NOTHING_TO_DO) ;
+			if (_drbd_may_sync_now(odev) &&
+			    _drbd_set_state(_NS(odev, aftr_isp, 0),
+					    CS_HARD, NULL) != SS_NOTHING_TO_DO)
+				changed = true;
 		}
 	}
 	rcu_read_unlock();
-	return rv;
+	return changed;
 }
 
 void resume_next_sg(struct drbd_device *device)
 {
-	write_lock_irq(&global_state_lock);
-	_drbd_resume_next(device);
-	write_unlock_irq(&global_state_lock);
+	lock_all_resources();
+	drbd_resume_next(device);
+	unlock_all_resources();
 }
 
 void suspend_other_sg(struct drbd_device *device)
 {
-	write_lock_irq(&global_state_lock);
-	_drbd_pause_after(device);
-	write_unlock_irq(&global_state_lock);
+	lock_all_resources();
+	drbd_pause_after(device);
+	unlock_all_resources();
 }
 
-/* caller must hold global_state_lock */
+/* caller must lock_all_resources() */
 enum drbd_ret_code drbd_resync_after_valid(struct drbd_device *device, int o_minor)
 {
 	struct drbd_device *odev;
@@ -1557,15 +1553,15 @@ enum drbd_ret_code drbd_resync_after_valid(struct drbd_device *device, int o_min
 	}
 }
 
-/* caller must hold global_state_lock */
+/* caller must lock_all_resources() */
 void drbd_resync_after_changed(struct drbd_device *device)
 {
-	int changes;
+	int changed;
 
 	do {
-		changes  = _drbd_pause_after(device);
-		changes |= _drbd_resume_next(device);
-	} while (changes);
+		changed  = drbd_pause_after(device);
+		changed |= drbd_resume_next(device);
+	} while (changed);
 }
 
 void drbd_rs_controller_reset(struct drbd_device *device)
@@ -1685,19 +1681,14 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 	} else {
 		mutex_lock(device->state_mutex);
 	}
-	clear_bit(B_RS_H_DONE, &device->flags);
 
-	/* req_lock: serialize with drbd_send_and_submit() and others
-	 * global_state_lock: for stable sync-after dependencies */
-	spin_lock_irq(&device->resource->req_lock);
-	write_lock(&global_state_lock);
+	lock_all_resources();
+	clear_bit(B_RS_H_DONE, &device->flags);
 	/* Did some connection breakage or IO error race with us? */
 	if (device->state.conn < C_CONNECTED
 	|| !get_ldev_if_state(device, D_NEGOTIATING)) {
-		write_unlock(&global_state_lock);
-		spin_unlock_irq(&device->resource->req_lock);
-		mutex_unlock(device->state_mutex);
-		return;
+		unlock_all_resources();
+		goto out;
 	}
 
 	ns = drbd_read_state(device);
@@ -1711,7 +1702,7 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 	else /* side == C_SYNC_SOURCE */
 		ns.pdsk = D_INCONSISTENT;
 
-	r = __drbd_set_state(device, ns, CS_VERBOSE, NULL);
+	r = _drbd_set_state(device, ns, CS_VERBOSE, NULL);
 	ns = drbd_read_state(device);
 
 	if (ns.conn < C_CONNECTED)
@@ -1732,7 +1723,7 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 			device->rs_mark_left[i] = tw;
 			device->rs_mark_time[i] = now;
 		}
-		_drbd_pause_after(device);
+		drbd_pause_after(device);
 		/* Forget potentially stale cached per resync extent bit-counts.
 		 * Open coded drbd_rs_cancel_all(device), we already have IRQs
 		 * disabled, and know the disk state is ok. */
@@ -1742,8 +1733,7 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 		device->resync_wenr = LC_FREE;
 		spin_unlock(&device->al_lock);
 	}
-	write_unlock(&global_state_lock);
-	spin_unlock_irq(&device->resource->req_lock);
+	unlock_all_resources();
 
 	if (r == SS_SUCCESS) {
 		wake_up(&device->al_wait); /* for lc_reset() above */
@@ -1807,6 +1797,7 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 		drbd_md_sync(device);
 	}
 	put_ldev(device);
+out:
 	mutex_unlock(device->state_mutex);
 }
 
-- 
1.9.1

