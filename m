Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:22 +0200
Message-Id: <1398703415-17780-12-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/24] drbd: allow parallel promote/demote actions
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

We plan to use genl_family->parallel_ops = true in the future,
but need to review all possible interactions first.

For now, only selectively drop genl_lock() in drbd_set_role(),
instead serializing on our own internal resource->conf_update mutex.

We now can be promoted/demoted on many resources in parallel,
which may significantly improve cluster failover times
when fencing is required.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h  |   1 +
 drivers/block/drbd/drbd_main.c |   1 +
 drivers/block/drbd/drbd_nl.c   | 100 +++++++++++++++++++++++++++++++++++------
 3 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 20a1772..fe6295c 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -579,6 +579,7 @@ struct drbd_resource {
 	struct list_head resources;
 	struct res_opts res_opts;
 	struct mutex conf_update;	/* mutex for ready-copy-update of net_conf and disk_conf */
+	struct mutex adm_mutex;		/* mutex to serialize administrative requests */
 	spinlock_t req_lock;
 
 	unsigned susp:1;		/* IO suspended by user */
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 865fdb3..05db597 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2570,6 +2570,7 @@ struct drbd_resource *drbd_create_resource(const char *name)
 	INIT_LIST_HEAD(&resource->connections);
 	list_add_tail_rcu(&resource->resources, &drbd_resources);
 	mutex_init(&resource->conf_update);
+	mutex_init(&resource->adm_mutex);
 	spin_lock_init(&resource->req_lock);
 	return resource;
 
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 118ac72..bb36792 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -115,6 +115,10 @@ int drbd_msg_put_info(struct sk_buff *skb, const char *info)
  * and per-family private info->pointers.
  * But we need to stay compatible with older kernels.
  * If it returns successfully, adm_ctx members are valid.
+ *
+ * At this point, we still rely on the global genl_lock().
+ * If we want to avoid that, and allow "genl_family.parallel_ops", we may need
+ * to add additional synchronization against object destruction/modification.
  */
 #define DRBD_ADM_NEED_MINOR	1
 #define DRBD_ADM_NEED_RESOURCE	2
@@ -166,7 +170,7 @@ static int drbd_adm_prepare(struct drbd_config_context *adm_ctx,
 		if (err)
 			goto fail;
 
-		/* and assign stuff to the global adm_ctx */
+		/* and assign stuff to the adm_ctx */
 		nla = nested_attr_tb[__nla_type(T_ctx_volume)];
 		if (nla)
 			adm_ctx->volume = nla_get_u32(nla);
@@ -186,6 +190,13 @@ static int drbd_adm_prepare(struct drbd_config_context *adm_ctx,
 
 	adm_ctx->minor = d_in->minor;
 	adm_ctx->device = minor_to_device(d_in->minor);
+
+	/* We are protected by the global genl_lock().
+	 * But we may explicitly drop it/retake it in drbd_adm_set_role(),
+	 * so make sure this object stays around. */
+	if (adm_ctx->device)
+		kref_get(&adm_ctx->device->kref);
+
 	if (adm_ctx->resource_name) {
 		adm_ctx->resource = drbd_find_resource(adm_ctx->resource_name);
 	}
@@ -241,6 +252,14 @@ static int drbd_adm_prepare(struct drbd_config_context *adm_ctx,
 		return ERR_INVALID_REQUEST;
 	}
 
+	/* still, provide adm_ctx->resource always, if possible. */
+	if (!adm_ctx->resource) {
+		adm_ctx->resource = adm_ctx->device ? adm_ctx->device->resource
+			: adm_ctx->connection ? adm_ctx->connection->resource : NULL;
+		if (adm_ctx->resource)
+			kref_get(&adm_ctx->resource->kref);
+	}
+
 	return NO_ERROR;
 
 fail:
@@ -252,6 +271,10 @@ fail:
 static int drbd_adm_finish(struct drbd_config_context *adm_ctx,
 	struct genl_info *info, int retcode)
 {
+	if (adm_ctx->device) {
+		kref_put(&adm_ctx->device->kref, drbd_destroy_device);
+		adm_ctx->device = NULL;
+	}
 	if (adm_ctx->connection) {
 		kref_put(&adm_ctx->connection->kref, &drbd_destroy_connection);
 		adm_ctx->connection = NULL;
@@ -635,11 +658,11 @@ drbd_set_role(struct drbd_device *device, enum drbd_role new_role, int force)
 			put_ldev(device);
 		}
 	} else {
-		mutex_lock(&device->resource->conf_update);
+		/* Called from drbd_adm_set_role only.
+		 * We are still holding the conf_update mutex. */
 		nc = first_peer_device(device)->connection->net_conf;
 		if (nc)
 			nc->discard_my_data = 0; /* without copy; single bit op is atomic */
-		mutex_unlock(&device->resource->conf_update);
 
 		set_disk_ro(device->vdisk, false);
 		if (get_ldev(device)) {
@@ -701,11 +724,16 @@ int drbd_adm_set_role(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 	}
+	genl_unlock();
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 
 	if (info->genlhdr->cmd == DRBD_ADM_PRIMARY)
 		retcode = drbd_set_role(adm_ctx.device, R_PRIMARY, parms.assume_uptodate);
 	else
 		retcode = drbd_set_role(adm_ctx.device, R_SECONDARY, 0);
+
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
+	genl_lock();
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -1251,9 +1279,10 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
-		goto out;
+		goto finish;
 
 	device = adm_ctx.device;
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 
 	/* we also need a disk
 	 * to change the options on */
@@ -1368,6 +1397,8 @@ fail_unlock:
 success:
 	put_ldev(device);
  out:
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
+ finish:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
@@ -1397,6 +1428,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		goto finish;
 
 	device = adm_ctx.device;
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	conn_reconfig_start(first_peer_device(device)->connection);
 
 	/* if you want to reconfigure, please tear down first */
@@ -1781,6 +1813,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	kobject_uevent(&disk_to_dev(device->vdisk)->kobj, KOBJ_CHANGE);
 	put_ldev(device);
 	conn_reconfig_done(first_peer_device(device)->connection);
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 
@@ -1803,7 +1836,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	kfree(new_disk_conf);
 	lc_destroy(resync_lru);
 	kfree(new_plan);
-
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
  finish:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -1864,7 +1897,9 @@ int drbd_adm_detach(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	retcode = adm_detach(adm_ctx.device, parms.force_detach);
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -2053,9 +2088,10 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
-		goto out;
+		goto finish;
 
 	connection = adm_ctx.connection;
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 
 	new_net_conf = kzalloc(sizeof(struct net_conf), GFP_KERNEL);
 	if (!new_net_conf) {
@@ -2153,6 +2189,8 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
  done:
 	conn_reconfig_done(connection);
  out:
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
+ finish:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
@@ -2202,6 +2240,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	connection = first_connection(adm_ctx.resource);
 	conn_reconfig_start(connection);
 
@@ -2271,6 +2310,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	retcode = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
 
 	conn_reconfig_done(connection);
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 
@@ -2279,6 +2319,7 @@ fail:
 	kfree(new_net_conf);
 
 	conn_reconfig_done(connection);
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -2367,11 +2408,13 @@ int drbd_adm_disconnect(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	rv = conn_try_disconnect(connection, parms.force_disconnect);
 	if (rv < SS_SUCCESS)
 		retcode = rv;  /* FIXME: Type mismatch. */
 	else
 		retcode = NO_ERROR;
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
  fail:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -2410,8 +2453,9 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
-		goto fail;
+		goto finish;
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	device = adm_ctx.device;
 	if (!get_ldev(device)) {
 		retcode = ERR_NO_DISK;
@@ -2517,6 +2561,8 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 	}
 
  fail:
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
+ finish:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 
@@ -2549,12 +2595,14 @@ int drbd_adm_resource_opts(struct sk_buff *skb, struct genl_info *info)
 		goto fail;
 	}
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	err = set_resource_options(adm_ctx.resource, &res_opts);
 	if (err) {
 		retcode = ERR_INVALID_REQUEST;
 		if (err == -ENOMEM)
 			retcode = ERR_NOMEM;
 	}
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 
 fail:
 	drbd_adm_finish(&adm_ctx, info, retcode);
@@ -2573,6 +2621,7 @@ int drbd_adm_invalidate(struct sk_buff *skb, struct genl_info *info)
 	if (retcode != NO_ERROR)
 		goto out;
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	device = adm_ctx.device;
 
 	/* If there is still bitmap IO pending, probably because of a previous
@@ -2596,7 +2645,7 @@ int drbd_adm_invalidate(struct sk_buff *skb, struct genl_info *info)
 	} else
 		retcode = drbd_request_state(device, NS(conn, C_STARTING_SYNC_T));
 	drbd_resume_io(device);
-
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -2614,7 +2663,9 @@ static int drbd_adm_simple_request_state(struct sk_buff *skb, struct genl_info *
 	if (retcode != NO_ERROR)
 		goto out;
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	retcode = drbd_request_state(adm_ctx.device, mask, val);
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -2641,6 +2692,7 @@ int drbd_adm_invalidate_peer(struct sk_buff *skb, struct genl_info *info)
 	if (retcode != NO_ERROR)
 		goto out;
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	device = adm_ctx.device;
 
 	/* If there is still bitmap IO pending, probably because of a previous
@@ -2667,7 +2719,7 @@ int drbd_adm_invalidate_peer(struct sk_buff *skb, struct genl_info *info)
 	} else
 		retcode = drbd_request_state(device, NS(conn, C_STARTING_SYNC_S));
 	drbd_resume_io(device);
-
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -2684,8 +2736,10 @@ int drbd_adm_pause_sync(struct sk_buff *skb, struct genl_info *info)
 	if (retcode != NO_ERROR)
 		goto out;
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	if (drbd_request_state(adm_ctx.device, NS(user_isp, 1)) == SS_NOTHING_TO_DO)
 		retcode = ERR_PAUSE_IS_SET;
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -2703,6 +2757,7 @@ int drbd_adm_resume_sync(struct sk_buff *skb, struct genl_info *info)
 	if (retcode != NO_ERROR)
 		goto out;
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	if (drbd_request_state(adm_ctx.device, NS(user_isp, 0)) == SS_NOTHING_TO_DO) {
 		s = adm_ctx.device->state;
 		if (s.conn == C_PAUSED_SYNC_S || s.conn == C_PAUSED_SYNC_T) {
@@ -2712,7 +2767,7 @@ int drbd_adm_resume_sync(struct sk_buff *skb, struct genl_info *info)
 			retcode = ERR_PAUSE_IS_CLEAR;
 		}
 	}
-
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -2735,6 +2790,7 @@ int drbd_adm_resume_io(struct sk_buff *skb, struct genl_info *info)
 	if (retcode != NO_ERROR)
 		goto out;
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	device = adm_ctx.device;
 	if (test_bit(NEW_CUR_UUID, &device->flags)) {
 		drbd_uuid_new_current(device);
@@ -2749,7 +2805,7 @@ int drbd_adm_resume_io(struct sk_buff *skb, struct genl_info *info)
 			tl_restart(first_peer_device(device)->connection, FAIL_FROZEN_DISK_IO);
 	}
 	drbd_resume_io(device);
-
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -3182,6 +3238,8 @@ int drbd_adm_start_ov(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 	}
+	mutex_lock(&adm_ctx.resource->adm_mutex);
+
 	/* w_make_ov_request expects position to be aligned */
 	device->ov_start_sector = parms.ov_start_sector & ~(BM_SECT_PER_BIT-1);
 	device->ov_stop_sector = parms.ov_stop_sector;
@@ -3192,6 +3250,8 @@ int drbd_adm_start_ov(struct sk_buff *skb, struct genl_info *info)
 	wait_event(device->misc_wait, !test_bit(BITMAP_IO, &device->flags));
 	retcode = drbd_request_state(device, NS(conn, C_VERIFY_S));
 	drbd_resume_io(device);
+
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -3224,6 +3284,7 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	mutex_lock(device->state_mutex); /* Protects us against serialized state changes. */
 
 	if (!get_ldev(device)) {
@@ -3268,6 +3329,7 @@ out_dec:
 	put_ldev(device);
 out:
 	mutex_unlock(device->state_mutex);
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out_nolock:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -3324,6 +3386,7 @@ int drbd_adm_new_resource(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	/* not yet safe for genl_family.parallel_ops */
 	if (!conn_create(adm_ctx.resource_name, &res_opts))
 		retcode = ERR_NOMEM;
 out:
@@ -3363,7 +3426,9 @@ int drbd_adm_new_minor(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	retcode = drbd_create_device(&adm_ctx, dh->minor);
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -3395,7 +3460,9 @@ int drbd_adm_del_minor(struct sk_buff *skb, struct genl_info *info)
 	if (retcode != NO_ERROR)
 		goto out;
 
+	mutex_lock(&adm_ctx.resource->adm_mutex);
 	retcode = adm_del_minor(adm_ctx.device);
+	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -3414,9 +3481,10 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
-		goto out;
+		goto finish;
 
 	resource = adm_ctx.resource;
+	mutex_lock(&resource->adm_mutex);
 	/* demote */
 	for_each_connection(connection, resource) {
 		struct drbd_peer_device *peer_device;
@@ -3467,8 +3535,9 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 	synchronize_rcu();
 	drbd_free_resource(resource);
 	retcode = NO_ERROR;
-
 out:
+	mutex_unlock(&resource->adm_mutex);
+finish:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
@@ -3484,9 +3553,10 @@ int drbd_adm_del_resource(struct sk_buff *skb, struct genl_info *info)
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
-		goto out;
+		goto finish;
 
 	resource = adm_ctx.resource;
+	mutex_lock(&resource->adm_mutex);
 	for_each_connection(connection, resource) {
 		if (connection->cstate > C_STANDALONE) {
 			retcode = ERR_NET_CONFIGURED;
@@ -3505,6 +3575,8 @@ int drbd_adm_del_resource(struct sk_buff *skb, struct genl_info *info)
 	drbd_free_resource(resource);
 	retcode = NO_ERROR;
 out:
+	mutex_unlock(&resource->adm_mutex);
+finish:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
-- 
1.9.1

