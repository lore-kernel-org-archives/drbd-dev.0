Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C78FB1056198
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:29 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:53:41 +0100
Message-Id: <1448448851-10343-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/38] drbd: Backport the "events2" command
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

The events2 command originates from drbd-9 development. It features
more information but requires a incompatible change in output
format.
Therefore the previous events command continues to exist, the new
improved events2 command becomes available now.

This prepares the user-base for a later switch to the complete
drbd9 code base.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h          |  45 +++
 drivers/block/drbd/drbd_nl.c           | 625 ++++++++++++++++++++++++++++++++-
 drivers/block/drbd/drbd_receiver.c     |   6 -
 drivers/block/drbd/drbd_state.c        | 424 +++++++++++++++++++++-
 drivers/block/drbd/drbd_state_change.h |  63 ++++
 include/linux/drbd.h                   |  16 +
 include/linux/drbd_genl.h              | 114 ++++++
 7 files changed, 1281 insertions(+), 12 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_state_change.h

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 2c9ee22..965aae0 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -667,6 +667,8 @@ enum {
 	DEVICE_WORK_PENDING,	/* tell worker that some device has pending work */
 };
 
+enum which_state { NOW, OLD = NOW, NEW };
+
 struct drbd_resource {
 	char *name;
 #ifdef CONFIG_DEBUG_FS
@@ -785,6 +787,17 @@ struct drbd_connection {
 	} send;
 };
 
+static inline bool has_net_conf(struct drbd_connection *connection)
+{
+	bool has_net_conf;
+
+	rcu_read_lock();
+	has_net_conf = rcu_dereference(connection->net_conf);
+	rcu_read_unlock();
+
+	return has_net_conf;
+}
+
 void __update_timing_details(
 		struct drbd_thread_timing_details *tdp,
 		unsigned int *cb_nr,
@@ -1017,6 +1030,12 @@ static inline struct drbd_peer_device *first_peer_device(struct drbd_device *dev
 	return list_first_entry_or_null(&device->peer_devices, struct drbd_peer_device, peer_devices);
 }
 
+static inline struct drbd_peer_device *
+conn_peer_device(struct drbd_connection *connection, int volume_number)
+{
+	return idr_find(&connection->peer_devices, volume_number);
+}
+
 #define for_each_resource(resource, _resources) \
 	list_for_each_entry(resource, _resources, resources)
 
@@ -1451,6 +1470,9 @@ extern int is_valid_ar_handle(struct drbd_request *, sector_t);
 
 
 /* drbd_nl.c */
+
+extern struct mutex notification_mutex;
+
 extern void drbd_suspend_io(struct drbd_device *device);
 extern void drbd_resume_io(struct drbd_device *device);
 extern char *ppsize(char *buf, unsigned long long size);
@@ -1665,6 +1687,29 @@ struct sib_info {
 };
 void drbd_bcast_event(struct drbd_device *device, const struct sib_info *sib);
 
+extern void notify_resource_state(struct sk_buff *,
+				  unsigned int,
+				  struct drbd_resource *,
+				  struct resource_info *,
+				  enum drbd_notification_type);
+extern void notify_device_state(struct sk_buff *,
+				unsigned int,
+				struct drbd_device *,
+				struct device_info *,
+				enum drbd_notification_type);
+extern void notify_connection_state(struct sk_buff *,
+				    unsigned int,
+				    struct drbd_connection *,
+				    struct connection_info *,
+				    enum drbd_notification_type);
+extern void notify_peer_device_state(struct sk_buff *,
+				     unsigned int,
+				     struct drbd_peer_device *,
+				     struct peer_device_info *,
+				     enum drbd_notification_type);
+extern void notify_helper(enum drbd_notification_type, struct drbd_device *,
+			  struct drbd_connection *, const char *, int);
+
 /*
  * inline helper functions
  *************************/
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d37c509..aa805cd 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -36,6 +36,7 @@
 #include "drbd_int.h"
 #include "drbd_protocol.h"
 #include "drbd_req.h"
+#include "drbd_state_change.h"
 #include <asm/unaligned.h>
 #include <linux/drbd_limits.h>
 #include <linux/kthread.h>
@@ -75,11 +76,17 @@ int drbd_adm_get_status(struct sk_buff *skb, struct genl_info *info);
 int drbd_adm_get_timeout_type(struct sk_buff *skb, struct genl_info *info);
 /* .dumpit */
 int drbd_adm_get_status_all(struct sk_buff *skb, struct netlink_callback *cb);
+int drbd_adm_get_initial_state(struct sk_buff *skb, struct netlink_callback *cb);
 
 #include <linux/drbd_genl_api.h>
 #include "drbd_nla.h"
 #include <linux/genl_magic_func.h>
 
+static atomic_t drbd_genl_seq = ATOMIC_INIT(2); /* two. */
+static atomic_t notify_genl_seq = ATOMIC_INIT(2); /* two. */
+
+DEFINE_MUTEX(notification_mutex);
+
 /* used blkdev_get_by_path, to claim our meta data device(s) */
 static char *drbd_m_holder = "Hands off! this is DRBD's meta data device.";
 
@@ -349,6 +356,7 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 	sib.sib_reason = SIB_HELPER_PRE;
 	sib.helper_name = cmd;
 	drbd_bcast_event(device, &sib);
+	notify_helper(NOTIFY_CALL, device, connection, cmd, 0);
 	ret = call_usermodehelper(usermode_helper, argv, envp, UMH_WAIT_PROC);
 	if (ret)
 		drbd_warn(device, "helper command: %s %s %s exit code %u (0x%x)\n",
@@ -361,6 +369,7 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 	sib.sib_reason = SIB_HELPER_POST;
 	sib.helper_exit_code = ret;
 	drbd_bcast_event(device, &sib);
+	notify_helper(NOTIFY_RESPONSE, device, connection, cmd, ret);
 
 	if (current == connection->worker.task)
 		clear_bit(CALLBACK_PENDING, &connection->flags);
@@ -388,6 +397,7 @@ static int conn_khelper(struct drbd_connection *connection, char *cmd)
 
 	drbd_info(connection, "helper command: %s %s %s\n", usermode_helper, cmd, resource_name);
 	/* TODO: conn_bcast_event() ?? */
+	notify_helper(NOTIFY_CALL, NULL, connection, cmd, 0);
 
 	ret = call_usermodehelper(usermode_helper, argv, envp, UMH_WAIT_PROC);
 	if (ret)
@@ -399,6 +409,7 @@ static int conn_khelper(struct drbd_connection *connection, char *cmd)
 			  usermode_helper, cmd, resource_name,
 			  (ret >> 8) & 0xff, ret);
 	/* TODO: conn_bcast_event() ?? */
+	notify_helper(NOTIFY_RESPONSE, NULL, connection, cmd, ret);
 
 	if (ret < 0) /* Ignore any ERRNOs we got. */
 		ret = 0;
@@ -2248,8 +2259,31 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static void connection_to_info(struct connection_info *info,
+			       struct drbd_connection *connection)
+{
+	info->conn_connection_state = connection->cstate;
+	info->conn_role = conn_highest_peer(connection);
+}
+
+static void peer_device_to_info(struct peer_device_info *info,
+				struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+
+	info->peer_repl_state =
+		max_t(enum drbd_conns, C_WF_REPORT_PARAMS, device->state.conn);
+	info->peer_disk_state = device->state.pdsk;
+	info->peer_resync_susp_user = device->state.user_isp;
+	info->peer_resync_susp_peer = device->state.peer_isp;
+	info->peer_resync_susp_dependency = device->state.aftr_isp;
+}
+
 int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 {
+	struct connection_info connection_info;
+	enum drbd_notification_type flags;
+	unsigned int peer_devices = 0;
 	struct drbd_config_context adm_ctx;
 	struct drbd_peer_device *peer_device;
 	struct net_conf *old_net_conf, *new_net_conf = NULL;
@@ -2350,6 +2384,22 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	connection->peer_addr_len = nla_len(adm_ctx.peer_addr);
 	memcpy(&connection->peer_addr, nla_data(adm_ctx.peer_addr), connection->peer_addr_len);
 
+	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+		peer_devices++;
+	}
+
+	connection_to_info(&connection_info, connection);
+	flags = (peer_devices--) ? NOTIFY_CONTINUES : 0;
+	mutex_lock(&notification_mutex);
+	notify_connection_state(NULL, 0, connection, &connection_info, NOTIFY_CREATE | flags);
+	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+		struct peer_device_info peer_device_info;
+
+		peer_device_to_info(&peer_device_info, peer_device);
+		flags = (peer_devices--) ? NOTIFY_CONTINUES : 0;
+		notify_peer_device_state(NULL, 0, peer_device, &peer_device_info, NOTIFY_CREATE | flags);
+	}
+	mutex_unlock(&notification_mutex);
 	mutex_unlock(&adm_ctx.resource->conf_update);
 
 	rcu_read_lock();
@@ -2431,6 +2481,8 @@ static enum drbd_state_rv conn_try_disconnect(struct drbd_connection *connection
 			drbd_err(connection,
 				"unexpected rv2=%d in conn_try_disconnect()\n",
 				rv2);
+		/* Unlike in DRBD 9, the state engine has generated
+		 * NOTIFY_DESTROY events before clearing connection->net_conf. */
 	}
 	return rv;
 }
@@ -3417,8 +3469,18 @@ drbd_check_resource_name(struct drbd_config_context *adm_ctx)
 	return NO_ERROR;
 }
 
+static void resource_to_info(struct resource_info *info,
+			     struct drbd_resource *resource)
+{
+	info->res_role = conn_highest_role(first_connection(resource));
+	info->res_susp = resource->susp;
+	info->res_susp_nod = resource->susp_nod;
+	info->res_susp_fen = resource->susp_fen;
+}
+
 int drbd_adm_new_resource(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_connection *connection;
 	struct drbd_config_context adm_ctx;
 	enum drbd_ret_code retcode;
 	struct res_opts res_opts;
@@ -3453,14 +3515,32 @@ int drbd_adm_new_resource(struct sk_buff *skb, struct genl_info *info)
 
 	/* not yet safe for genl_family.parallel_ops */
 	mutex_lock(&resources_mutex);
-	if (!conn_create(adm_ctx.resource_name, &res_opts))
-		retcode = ERR_NOMEM;
+	connection = conn_create(adm_ctx.resource_name, &res_opts);
 	mutex_unlock(&resources_mutex);
+
+	if (connection) {
+		struct resource_info resource_info;
+
+		mutex_lock(&notification_mutex);
+		resource_to_info(&resource_info, connection->resource);
+		notify_resource_state(NULL, 0, connection->resource,
+				      &resource_info, NOTIFY_CREATE);
+		mutex_unlock(&notification_mutex);
+	} else
+		retcode = ERR_NOMEM;
+
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
+static void device_to_info(struct device_info *info,
+			   struct drbd_device *device)
+{
+	info->dev_disk_state = device->state.disk;
+}
+
+
 int drbd_adm_new_minor(struct sk_buff *skb, struct genl_info *info)
 {
 	struct drbd_config_context adm_ctx;
@@ -3495,6 +3575,36 @@ int drbd_adm_new_minor(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	retcode = drbd_create_device(&adm_ctx, dh->minor);
+	if (retcode == NO_ERROR) {
+		struct drbd_device *device;
+		struct drbd_peer_device *peer_device;
+		struct device_info info;
+		unsigned int peer_devices = 0;
+		enum drbd_notification_type flags;
+
+		device = minor_to_device(dh->minor);
+		for_each_peer_device(peer_device, device) {
+			if (!has_net_conf(peer_device->connection))
+				continue;
+			peer_devices++;
+		}
+
+		device_to_info(&info, device);
+		mutex_lock(&notification_mutex);
+		flags = (peer_devices--) ? NOTIFY_CONTINUES : 0;
+		notify_device_state(NULL, 0, device, &info, NOTIFY_CREATE | flags);
+		for_each_peer_device(peer_device, device) {
+			struct peer_device_info peer_device_info;
+
+			if (!has_net_conf(peer_device->connection))
+				continue;
+			peer_device_to_info(&peer_device_info, peer_device);
+			flags = (peer_devices--) ? NOTIFY_CONTINUES : 0;
+			notify_peer_device_state(NULL, 0, peer_device, &peer_device_info,
+						 NOTIFY_CREATE | flags);
+		}
+		mutex_unlock(&notification_mutex);
+	}
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
@@ -3503,13 +3613,35 @@ out:
 
 static enum drbd_ret_code adm_del_minor(struct drbd_device *device)
 {
+	struct drbd_peer_device *peer_device;
+
 	if (device->state.disk == D_DISKLESS &&
 	    /* no need to be device->state.conn == C_STANDALONE &&
 	     * we may want to delete a minor from a live replication group.
 	     */
 	    device->state.role == R_SECONDARY) {
+		struct drbd_connection *connection =
+			first_connection(device->resource);
+
 		_drbd_request_state(device, NS(conn, C_WF_REPORT_PARAMS),
 				    CS_VERBOSE + CS_WAIT_COMPLETE);
+
+		/* If the state engine hasn't stopped the sender thread yet, we
+		 * need to flush the sender work queue before generating the
+		 * DESTROY events here. */
+		if (get_t_state(&connection->worker) == RUNNING)
+			drbd_flush_workqueue(&connection->sender_work);
+
+		mutex_lock(&notification_mutex);
+		for_each_peer_device(peer_device, device) {
+			if (!has_net_conf(peer_device->connection))
+				continue;
+			notify_peer_device_state(NULL, 0, peer_device, NULL,
+						 NOTIFY_DESTROY | NOTIFY_CONTINUES);
+		}
+		notify_device_state(NULL, 0, device, NULL, NOTIFY_DESTROY);
+		mutex_unlock(&notification_mutex);
+
 		drbd_delete_device(device);
 		return NO_ERROR;
 	} else
@@ -3546,6 +3678,13 @@ static int adm_del_resource(struct drbd_resource *resource)
 	if (!idr_is_empty(&resource->devices))
 		return ERR_RES_IN_USE;
 
+	/* The state engine has stopped the sender thread, so we don't
+	 * need to flush the sender work queue before generating the
+	 * DESTROY event here. */
+	mutex_lock(&notification_mutex);
+	notify_resource_state(NULL, 0, resource, NULL, NOTIFY_DESTROY);
+	mutex_unlock(&notification_mutex);
+
 	mutex_lock(&resources_mutex);
 	list_del_rcu(&resource->resources);
 	mutex_unlock(&resources_mutex);
@@ -3644,7 +3783,6 @@ finish:
 
 void drbd_bcast_event(struct drbd_device *device, const struct sib_info *sib)
 {
-	static atomic_t drbd_genl_seq = ATOMIC_INIT(2); /* two. */
 	struct sk_buff *msg;
 	struct drbd_genlmsghdr *d_out;
 	unsigned seq;
@@ -3679,3 +3817,484 @@ failed:
 			"Event seq:%u sib_reason:%u\n",
 			err, seq, sib->sib_reason);
 }
+
+static void device_to_statistics(struct device_statistics *s,
+				 struct drbd_device *device)
+{
+	memset(s, 0, sizeof(*s));
+	s->dev_upper_blocked = !may_inc_ap_bio(device);
+	if (get_ldev(device)) {
+		struct drbd_md *md = &device->ldev->md;
+		u64 *history_uuids = (u64 *)s->history_uuids;
+		struct request_queue *q;
+		int n;
+
+		spin_lock_irq(&md->uuid_lock);
+		s->dev_current_uuid = md->uuid[UI_CURRENT];
+		BUILD_BUG_ON(sizeof(s->history_uuids) < UI_HISTORY_END - UI_HISTORY_START + 1);
+		for (n = 0; n < UI_HISTORY_END - UI_HISTORY_START + 1; n++)
+			history_uuids[n] = md->uuid[UI_HISTORY_START + n];
+		for (; n < HISTORY_UUIDS; n++)
+			history_uuids[n] = 0;
+		s->history_uuids_len = HISTORY_UUIDS;
+		spin_unlock_irq(&md->uuid_lock);
+
+		s->dev_disk_flags = md->flags;
+		q = bdev_get_queue(device->ldev->backing_bdev);
+		s->dev_lower_blocked =
+			bdi_congested(&q->backing_dev_info,
+				      (1 << WB_async_congested) |
+				      (1 << WB_sync_congested));
+		put_ldev(device);
+	}
+	s->dev_size = drbd_get_capacity(device->this_bdev);
+	s->dev_read = device->read_cnt;
+	s->dev_write = device->writ_cnt;
+	s->dev_al_writes = device->al_writ_cnt;
+	s->dev_bm_writes = device->bm_writ_cnt;
+	s->dev_upper_pending = atomic_read(&device->ap_bio_cnt);
+	s->dev_lower_pending = atomic_read(&device->local_cnt);
+	s->dev_al_suspended = test_bit(AL_SUSPENDED, &device->flags);
+	s->dev_exposed_data_uuid = device->ed_uuid;
+}
+
+enum mdf_peer_flag {
+	MDF_PEER_CONNECTED =	1 << 0,
+	MDF_PEER_OUTDATED =	1 << 1,
+	MDF_PEER_FENCING =	1 << 2,
+	MDF_PEER_FULL_SYNC =	1 << 3,
+};
+
+static void peer_device_to_statistics(struct peer_device_statistics *s,
+				      struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+
+	memset(s, 0, sizeof(*s));
+	s->peer_dev_received = device->recv_cnt;
+	s->peer_dev_sent = device->send_cnt;
+	s->peer_dev_pending = atomic_read(&device->ap_pending_cnt) +
+			      atomic_read(&device->rs_pending_cnt);
+	s->peer_dev_unacked = atomic_read(&device->unacked_cnt);
+	s->peer_dev_out_of_sync = drbd_bm_total_weight(device) << (BM_BLOCK_SHIFT - 9);
+	s->peer_dev_resync_failed = device->rs_failed << (BM_BLOCK_SHIFT - 9);
+	if (get_ldev(device)) {
+		struct drbd_md *md = &device->ldev->md;
+
+		spin_lock_irq(&md->uuid_lock);
+		s->peer_dev_bitmap_uuid = md->uuid[UI_BITMAP];
+		spin_unlock_irq(&md->uuid_lock);
+		s->peer_dev_flags =
+			(drbd_md_test_flag(device->ldev, MDF_CONNECTED_IND) ?
+				MDF_PEER_CONNECTED : 0) +
+			(drbd_md_test_flag(device->ldev, MDF_CONSISTENT) &&
+			 !drbd_md_test_flag(device->ldev, MDF_WAS_UP_TO_DATE) ?
+				MDF_PEER_OUTDATED : 0) +
+			/* FIXME: MDF_PEER_FENCING? */
+			(drbd_md_test_flag(device->ldev, MDF_FULL_SYNC) ?
+				MDF_PEER_FULL_SYNC : 0);
+		put_ldev(device);
+	}
+}
+
+static int nla_put_notification_header(struct sk_buff *msg,
+				       enum drbd_notification_type type)
+{
+	struct drbd_notification_header nh = {
+		.nh_type = type,
+	};
+
+	return drbd_notification_header_to_skb(msg, &nh, true);
+}
+
+void notify_resource_state(struct sk_buff *skb,
+			   unsigned int seq,
+			   struct drbd_resource *resource,
+			   struct resource_info *resource_info,
+			   enum drbd_notification_type type)
+{
+	struct resource_statistics resource_statistics;
+	struct drbd_genlmsghdr *dh;
+	bool multicast = false;
+	int err;
+
+	if (!skb) {
+		seq = atomic_inc_return(&notify_genl_seq);
+		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+		err = -ENOMEM;
+		if (!skb)
+			goto failed;
+		multicast = true;
+	}
+
+	err = -EMSGSIZE;
+	dh = genlmsg_put(skb, 0, seq, &drbd_genl_family, 0, DRBD_RESOURCE_STATE);
+	if (!dh)
+		goto nla_put_failure;
+	dh->minor = -1U;
+	dh->ret_code = NO_ERROR;
+	if (nla_put_drbd_cfg_context(skb, resource, NULL, NULL) ||
+	    nla_put_notification_header(skb, type) ||
+	    ((type & ~NOTIFY_FLAGS) != NOTIFY_DESTROY &&
+	     resource_info_to_skb(skb, resource_info, true)))
+		goto nla_put_failure;
+	resource_statistics.res_stat_write_ordering = resource->write_ordering;
+	err = resource_statistics_to_skb(skb, &resource_statistics, !capable(CAP_SYS_ADMIN));
+	if (err)
+		goto nla_put_failure;
+	genlmsg_end(skb, dh);
+	if (multicast) {
+		err = drbd_genl_multicast_events(skb, 0);
+		/* skb has been consumed or freed in netlink_broadcast() */
+		if (err && err != -ESRCH)
+			goto failed;
+	}
+	return;
+
+nla_put_failure:
+	nlmsg_free(skb);
+failed:
+	drbd_err(resource, "Error %d while broadcasting event. Event seq:%u\n",
+			err, seq);
+}
+
+void notify_device_state(struct sk_buff *skb,
+			 unsigned int seq,
+			 struct drbd_device *device,
+			 struct device_info *device_info,
+			 enum drbd_notification_type type)
+{
+	struct device_statistics device_statistics;
+	struct drbd_genlmsghdr *dh;
+	bool multicast = false;
+	int err;
+
+	if (!skb) {
+		seq = atomic_inc_return(&notify_genl_seq);
+		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+		err = -ENOMEM;
+		if (!skb)
+			goto failed;
+		multicast = true;
+	}
+
+	err = -EMSGSIZE;
+	dh = genlmsg_put(skb, 0, seq, &drbd_genl_family, 0, DRBD_DEVICE_STATE);
+	if (!dh)
+		goto nla_put_failure;
+	dh->minor = device->minor;
+	dh->ret_code = NO_ERROR;
+	if (nla_put_drbd_cfg_context(skb, device->resource, NULL, device) ||
+	    nla_put_notification_header(skb, type) ||
+	    ((type & ~NOTIFY_FLAGS) != NOTIFY_DESTROY &&
+	     device_info_to_skb(skb, device_info, true)))
+		goto nla_put_failure;
+	device_to_statistics(&device_statistics, device);
+	device_statistics_to_skb(skb, &device_statistics, !capable(CAP_SYS_ADMIN));
+	genlmsg_end(skb, dh);
+	if (multicast) {
+		err = drbd_genl_multicast_events(skb, 0);
+		/* skb has been consumed or freed in netlink_broadcast() */
+		if (err && err != -ESRCH)
+			goto failed;
+	}
+	return;
+
+nla_put_failure:
+	nlmsg_free(skb);
+failed:
+	drbd_err(device, "Error %d while broadcasting event. Event seq:%u\n",
+		 err, seq);
+}
+
+void notify_connection_state(struct sk_buff *skb,
+			     unsigned int seq,
+			     struct drbd_connection *connection,
+			     struct connection_info *connection_info,
+			     enum drbd_notification_type type)
+{
+	struct connection_statistics connection_statistics;
+	struct drbd_genlmsghdr *dh;
+	bool multicast = false;
+	int err;
+
+	if (!skb) {
+		seq = atomic_inc_return(&notify_genl_seq);
+		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+		err = -ENOMEM;
+		if (!skb)
+			goto failed;
+		multicast = true;
+	}
+
+	err = -EMSGSIZE;
+	dh = genlmsg_put(skb, 0, seq, &drbd_genl_family, 0, DRBD_CONNECTION_STATE);
+	if (!dh)
+		goto nla_put_failure;
+	dh->minor = -1U;
+	dh->ret_code = NO_ERROR;
+	if (nla_put_drbd_cfg_context(skb, connection->resource, connection, NULL) ||
+	    nla_put_notification_header(skb, type) ||
+	    ((type & ~NOTIFY_FLAGS) != NOTIFY_DESTROY &&
+	     connection_info_to_skb(skb, connection_info, true)))
+		goto nla_put_failure;
+	connection_statistics.conn_congested = test_bit(NET_CONGESTED, &connection->flags);
+	connection_statistics_to_skb(skb, &connection_statistics, !capable(CAP_SYS_ADMIN));
+	genlmsg_end(skb, dh);
+	if (multicast) {
+		err = drbd_genl_multicast_events(skb, 0);
+		/* skb has been consumed or freed in netlink_broadcast() */
+		if (err && err != -ESRCH)
+			goto failed;
+	}
+	return;
+
+nla_put_failure:
+	nlmsg_free(skb);
+failed:
+	drbd_err(connection, "Error %d while broadcasting event. Event seq:%u\n",
+		 err, seq);
+}
+
+void notify_peer_device_state(struct sk_buff *skb,
+			      unsigned int seq,
+			      struct drbd_peer_device *peer_device,
+			      struct peer_device_info *peer_device_info,
+			      enum drbd_notification_type type)
+{
+	struct peer_device_statistics peer_device_statistics;
+	struct drbd_resource *resource = peer_device->device->resource;
+	struct drbd_genlmsghdr *dh;
+	bool multicast = false;
+	int err;
+
+	if (!skb) {
+		seq = atomic_inc_return(&notify_genl_seq);
+		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+		err = -ENOMEM;
+		if (!skb)
+			goto failed;
+		multicast = true;
+	}
+
+	err = -EMSGSIZE;
+	dh = genlmsg_put(skb, 0, seq, &drbd_genl_family, 0, DRBD_PEER_DEVICE_STATE);
+	if (!dh)
+		goto nla_put_failure;
+	dh->minor = -1U;
+	dh->ret_code = NO_ERROR;
+	if (nla_put_drbd_cfg_context(skb, resource, peer_device->connection, peer_device->device) ||
+	    nla_put_notification_header(skb, type) ||
+	    ((type & ~NOTIFY_FLAGS) != NOTIFY_DESTROY &&
+	     peer_device_info_to_skb(skb, peer_device_info, true)))
+		goto nla_put_failure;
+	peer_device_to_statistics(&peer_device_statistics, peer_device);
+	peer_device_statistics_to_skb(skb, &peer_device_statistics, !capable(CAP_SYS_ADMIN));
+	genlmsg_end(skb, dh);
+	if (multicast) {
+		err = drbd_genl_multicast_events(skb, 0);
+		/* skb has been consumed or freed in netlink_broadcast() */
+		if (err && err != -ESRCH)
+			goto failed;
+	}
+	return;
+
+nla_put_failure:
+	nlmsg_free(skb);
+failed:
+	drbd_err(peer_device, "Error %d while broadcasting event. Event seq:%u\n",
+		 err, seq);
+}
+
+void notify_helper(enum drbd_notification_type type,
+		   struct drbd_device *device, struct drbd_connection *connection,
+		   const char *name, int status)
+{
+	struct drbd_resource *resource = device ? device->resource : connection->resource;
+	struct drbd_helper_info helper_info;
+	unsigned int seq = atomic_inc_return(&notify_genl_seq);
+	struct sk_buff *skb = NULL;
+	struct drbd_genlmsghdr *dh;
+	int err;
+
+	strlcpy(helper_info.helper_name, name, sizeof(helper_info.helper_name));
+	helper_info.helper_name_len = min(strlen(name), sizeof(helper_info.helper_name));
+	helper_info.helper_status = status;
+
+	skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+	err = -ENOMEM;
+	if (!skb)
+		goto fail;
+
+	err = -EMSGSIZE;
+	dh = genlmsg_put(skb, 0, seq, &drbd_genl_family, 0, DRBD_HELPER);
+	if (!dh)
+		goto fail;
+	dh->minor = device ? device->minor : -1;
+	dh->ret_code = NO_ERROR;
+	mutex_lock(&notification_mutex);
+	if (nla_put_drbd_cfg_context(skb, resource, connection, device) ||
+	    nla_put_notification_header(skb, type) ||
+	    drbd_helper_info_to_skb(skb, &helper_info, true))
+		goto unlock_fail;
+	genlmsg_end(skb, dh);
+	err = drbd_genl_multicast_events(skb, 0);
+	skb = NULL;
+	/* skb has been consumed or freed in netlink_broadcast() */
+	if (err && err != -ESRCH)
+		goto unlock_fail;
+	mutex_unlock(&notification_mutex);
+	return;
+
+unlock_fail:
+	mutex_unlock(&notification_mutex);
+fail:
+	nlmsg_free(skb);
+	drbd_err(resource, "Error %d while broadcasting event. Event seq:%u\n",
+		 err, seq);
+}
+
+static void notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
+{
+	struct drbd_genlmsghdr *dh;
+	int err;
+
+	err = -EMSGSIZE;
+	dh = genlmsg_put(skb, 0, seq, &drbd_genl_family, 0, DRBD_INITIAL_STATE_DONE);
+	if (!dh)
+		goto nla_put_failure;
+	dh->minor = -1U;
+	dh->ret_code = NO_ERROR;
+	if (nla_put_notification_header(skb, NOTIFY_EXISTS))
+		goto nla_put_failure;
+	genlmsg_end(skb, dh);
+	return;
+
+nla_put_failure:
+	nlmsg_free(skb);
+	pr_err("Error %d sending event. Event seq:%u\n", err, seq);
+}
+
+static void free_state_changes(struct list_head *list)
+{
+	while (!list_empty(list)) {
+		struct drbd_state_change *state_change =
+			list_first_entry(list, struct drbd_state_change, list);
+		list_del(&state_change->list);
+		forget_state_change(state_change);
+	}
+}
+
+static unsigned int notifications_for_state_change(struct drbd_state_change *state_change)
+{
+	return 1 +
+	       state_change->n_connections +
+	       state_change->n_devices +
+	       state_change->n_devices * state_change->n_connections;
+}
+
+static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct drbd_state_change *state_change = (struct drbd_state_change *)cb->args[0];
+	unsigned int seq = cb->args[2];
+	unsigned int n;
+	enum drbd_notification_type flags = 0;
+
+	/* There is no need for taking notification_mutex here: it doesn't
+	   matter if the initial state events mix with later state chage
+	   events; we can always tell the events apart by the NOTIFY_EXISTS
+	   flag. */
+
+	cb->args[5]--;
+	if (cb->args[5] == 1) {
+		notify_initial_state_done(skb, seq);
+		goto out;
+	}
+	n = cb->args[4]++;
+	if (cb->args[4] < cb->args[3])
+		flags |= NOTIFY_CONTINUES;
+	if (n < 1) {
+		notify_resource_state_change(skb, seq, state_change->resource,
+					     NOTIFY_EXISTS | flags);
+		goto next;
+	}
+	n--;
+	if (n < state_change->n_connections) {
+		notify_connection_state_change(skb, seq, &state_change->connections[n],
+					       NOTIFY_EXISTS | flags);
+		goto next;
+	}
+	n -= state_change->n_connections;
+	if (n < state_change->n_devices) {
+		notify_device_state_change(skb, seq, &state_change->devices[n],
+					   NOTIFY_EXISTS | flags);
+		goto next;
+	}
+	n -= state_change->n_devices;
+	if (n < state_change->n_devices * state_change->n_connections) {
+		notify_peer_device_state_change(skb, seq, &state_change->peer_devices[n],
+						NOTIFY_EXISTS | flags);
+		goto next;
+	}
+
+next:
+	if (cb->args[4] == cb->args[3]) {
+		struct drbd_state_change *next_state_change =
+			list_entry(state_change->list.next,
+				   struct drbd_state_change, list);
+		cb->args[0] = (long)next_state_change;
+		cb->args[3] = notifications_for_state_change(next_state_change);
+		cb->args[4] = 0;
+	}
+out:
+	return skb->len;
+}
+
+int drbd_adm_get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct drbd_resource *resource;
+	LIST_HEAD(head);
+
+	if (cb->args[5] >= 1) {
+		if (cb->args[5] > 1)
+			return get_initial_state(skb, cb);
+		if (cb->args[0]) {
+			struct drbd_state_change *state_change =
+				(struct drbd_state_change *)cb->args[0];
+
+			/* connect list to head */
+			list_add(&head, &state_change->list);
+			free_state_changes(&head);
+		}
+		return 0;
+	}
+
+	cb->args[5] = 2;  /* number of iterations */
+	mutex_lock(&resources_mutex);
+	for_each_resource(resource, &drbd_resources) {
+		struct drbd_state_change *state_change;
+
+		state_change = remember_old_state(resource, GFP_KERNEL);
+		if (!state_change) {
+			if (!list_empty(&head))
+				free_state_changes(&head);
+			mutex_unlock(&resources_mutex);
+			return -ENOMEM;
+		}
+		copy_old_to_new_state_change(state_change);
+		list_add_tail(&state_change->list, &head);
+		cb->args[5] += notifications_for_state_change(state_change);
+	}
+	mutex_unlock(&resources_mutex);
+
+	if (!list_empty(&head)) {
+		struct drbd_state_change *state_change =
+			list_entry(head.next, struct drbd_state_change, list);
+		cb->args[0] = (long)state_change;
+		cb->args[3] = notifications_for_state_change(state_change);
+		list_del(&head);  /* detach list from head */
+	}
+
+	cb->args[2] = cb->nlh->nlmsg_seq;
+	return get_initial_state(skb, cb);
+}
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index bf38b95..61b73c7 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1508,12 +1508,6 @@ static void conn_wait_active_ee_empty(struct drbd_connection *connection)
 	rcu_read_unlock();
 }
 
-static struct drbd_peer_device *
-conn_peer_device(struct drbd_connection *connection, int volume_number)
-{
-	return idr_find(&connection->peer_devices, volume_number);
-}
-
 static int receive_Barrier(struct drbd_connection *connection, struct packet_info *pi)
 {
 	int rv;
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 535ae47..bc4b45b 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -29,6 +29,7 @@
 #include "drbd_int.h"
 #include "drbd_protocol.h"
 #include "drbd_req.h"
+#include "drbd_state_change.h"
 
 struct after_state_chg_work {
 	struct drbd_work w;
@@ -37,6 +38,7 @@ struct after_state_chg_work {
 	union drbd_state ns;
 	enum chg_state_flags flags;
 	struct completion *done;
+	struct drbd_state_change *state_change;
 };
 
 enum sanitize_state_warnings {
@@ -48,9 +50,266 @@ enum sanitize_state_warnings {
 	IMPLICITLY_UPGRADED_PDSK,
 };
 
+static void count_objects(struct drbd_resource *resource,
+			  unsigned int *n_devices,
+			  unsigned int *n_connections)
+{
+	struct drbd_device *device;
+	struct drbd_connection *connection;
+	int vnr;
+
+	*n_devices = 0;
+	*n_connections = 0;
+
+	idr_for_each_entry(&resource->devices, device, vnr)
+		(*n_devices)++;
+	for_each_connection(connection, resource) {
+		if (!has_net_conf(connection))
+			continue;
+		(*n_connections)++;
+	}
+}
+
+static struct drbd_state_change *alloc_state_change(unsigned int n_devices, unsigned int n_connections, gfp_t gfp)
+{
+	struct drbd_state_change *state_change;
+	unsigned int size, n;
+
+	size = sizeof(struct drbd_state_change) +
+	       n_devices * sizeof(struct drbd_device_state_change) +
+	       n_connections * sizeof(struct drbd_connection_state_change) +
+	       n_devices * n_connections * sizeof(struct drbd_peer_device_state_change);
+	state_change = kmalloc(size, gfp);
+	if (!state_change)
+		return NULL;
+	state_change->n_devices = n_devices;
+	state_change->n_connections = n_connections;
+	state_change->devices = (void *)(state_change + 1);
+	state_change->connections = (void *)&state_change->devices[n_devices];
+	state_change->peer_devices = (void *)&state_change->connections[n_connections];
+	state_change->resource->resource = NULL;
+	for (n = 0; n < n_devices; n++)
+		state_change->devices[n].device = NULL;
+	for (n = 0; n < n_connections; n++)
+		state_change->connections[n].connection = NULL;
+	return state_change;
+}
+
+struct drbd_state_change *remember_old_state(struct drbd_resource *resource, gfp_t gfp)
+{
+	struct drbd_state_change *state_change;
+	struct drbd_device *device;
+	unsigned int n_devices;
+	struct drbd_connection *connection;
+	unsigned int n_connections;
+	int vnr;
+
+	struct drbd_device_state_change *device_state_change;
+	struct drbd_peer_device_state_change *peer_device_state_change;
+	struct drbd_connection_state_change *connection_state_change;
+
+retry:
+	rcu_read_lock();
+	count_objects(resource, &n_devices, &n_connections);
+	rcu_read_unlock();
+	state_change = alloc_state_change(n_devices, n_connections, gfp);
+	if (!state_change)
+		return NULL;
+
+	rcu_read_lock();
+	count_objects(resource, &n_devices, &n_connections);
+	if (n_devices != state_change->n_devices ||
+	    n_connections != state_change->n_connections) {
+		kfree(state_change);
+		rcu_read_unlock();
+		goto retry;
+	}
+
+	kref_get(&resource->kref);
+	state_change->resource->resource = resource;
+	state_change->resource->role[OLD] =
+		conn_highest_role(first_connection(resource));
+	state_change->resource->susp[OLD] = resource->susp;
+	state_change->resource->susp_nod[OLD] = resource->susp_nod;
+	state_change->resource->susp_fen[OLD] = resource->susp_fen;
+
+	device_state_change = state_change->devices;
+	peer_device_state_change = state_change->peer_devices;
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		kref_get(&device->kref);
+		device_state_change->device = device;
+		device_state_change->disk_state[OLD] = device->state.disk;
+
+		/* The peer_devices for each device have to be enumerated in
+		   the order of the connections. We may not use for_each_peer_device() here. */
+		for_each_connection(connection, resource) {
+			struct drbd_peer_device *peer_device;
+
+			if (!has_net_conf(connection))
+				continue;
+			peer_device = conn_peer_device(connection, device->vnr);
+			peer_device_state_change->peer_device = peer_device;
+			peer_device_state_change->disk_state[OLD] =
+				device->state.pdsk;
+			peer_device_state_change->repl_state[OLD] =
+				max_t(enum drbd_conns,
+				      C_WF_REPORT_PARAMS, device->state.conn);
+			peer_device_state_change->resync_susp_user[OLD] =
+				device->state.user_isp;
+			peer_device_state_change->resync_susp_peer[OLD] =
+				device->state.peer_isp;
+			peer_device_state_change->resync_susp_dependency[OLD] =
+				device->state.aftr_isp;
+			peer_device_state_change++;
+		}
+		device_state_change++;
+	}
+
+	connection_state_change = state_change->connections;
+	for_each_connection(connection, resource) {
+		if (!has_net_conf(connection))
+			continue;
+		kref_get(&connection->kref);
+		connection_state_change->connection = connection;
+		connection_state_change->cstate[OLD] =
+			connection->cstate;
+		connection_state_change->peer_role[OLD] =
+			conn_highest_peer(connection);
+		connection_state_change++;
+	}
+	rcu_read_unlock();
+
+	return state_change;
+}
+
+static void remember_new_state(struct drbd_state_change *state_change)
+{
+	struct drbd_resource_state_change *resource_state_change;
+	struct drbd_resource *resource;
+	unsigned int n;
+
+	if (!state_change)
+		return;
+
+	resource_state_change = &state_change->resource[0];
+	resource = resource_state_change->resource;
+
+	resource_state_change->role[NEW] =
+		conn_highest_role(first_connection(resource));
+	resource_state_change->susp[NEW] = resource->susp;
+	resource_state_change->susp_nod[NEW] = resource->susp_nod;
+	resource_state_change->susp_fen[NEW] = resource->susp_fen;
+
+	for (n = 0; n < state_change->n_devices; n++) {
+		struct drbd_device_state_change *device_state_change =
+			&state_change->devices[n];
+		struct drbd_device *device = device_state_change->device;
+
+		device_state_change->disk_state[NEW] = device->state.disk;
+	}
+
+	for (n = 0; n < state_change->n_connections; n++) {
+		struct drbd_connection_state_change *connection_state_change =
+			&state_change->connections[n];
+		struct drbd_connection *connection =
+			connection_state_change->connection;
+
+		connection_state_change->cstate[NEW] = connection->cstate;
+		connection_state_change->peer_role[NEW] =
+			conn_highest_peer(connection);
+	}
+
+	for (n = 0; n < state_change->n_devices * state_change->n_connections; n++) {
+		struct drbd_peer_device_state_change *peer_device_state_change =
+			&state_change->peer_devices[n];
+		struct drbd_device *device =
+			peer_device_state_change->peer_device->device;
+		union drbd_dev_state state = device->state;
+
+		peer_device_state_change->disk_state[NEW] = state.pdsk;
+		peer_device_state_change->repl_state[NEW] =
+			max_t(enum drbd_conns, C_WF_REPORT_PARAMS, state.conn);
+		peer_device_state_change->resync_susp_user[NEW] =
+			state.user_isp;
+		peer_device_state_change->resync_susp_peer[NEW] =
+			state.peer_isp;
+		peer_device_state_change->resync_susp_dependency[NEW] =
+			state.aftr_isp;
+	}
+}
+
+void copy_old_to_new_state_change(struct drbd_state_change *state_change)
+{
+	struct drbd_resource_state_change *resource_state_change = &state_change->resource[0];
+	unsigned int n_device, n_connection, n_peer_device, n_peer_devices;
+
+#define OLD_TO_NEW(x) \
+	(x[NEW] = x[OLD])
+
+	OLD_TO_NEW(resource_state_change->role);
+	OLD_TO_NEW(resource_state_change->susp);
+	OLD_TO_NEW(resource_state_change->susp_nod);
+	OLD_TO_NEW(resource_state_change->susp_fen);
+
+	for (n_connection = 0; n_connection < state_change->n_connections; n_connection++) {
+		struct drbd_connection_state_change *connection_state_change =
+				&state_change->connections[n_connection];
+
+		OLD_TO_NEW(connection_state_change->peer_role);
+		OLD_TO_NEW(connection_state_change->cstate);
+	}
+
+	for (n_device = 0; n_device < state_change->n_devices; n_device++) {
+		struct drbd_device_state_change *device_state_change =
+			&state_change->devices[n_device];
+
+		OLD_TO_NEW(device_state_change->disk_state);
+	}
+
+	n_peer_devices = state_change->n_devices * state_change->n_connections;
+	for (n_peer_device = 0; n_peer_device < n_peer_devices; n_peer_device++) {
+		struct drbd_peer_device_state_change *p =
+			&state_change->peer_devices[n_peer_device];
+
+		OLD_TO_NEW(p->disk_state);
+		OLD_TO_NEW(p->repl_state);
+		OLD_TO_NEW(p->resync_susp_user);
+		OLD_TO_NEW(p->resync_susp_peer);
+		OLD_TO_NEW(p->resync_susp_dependency);
+	}
+
+#undef OLD_TO_NEW
+}
+
+void forget_state_change(struct drbd_state_change *state_change)
+{
+	unsigned int n;
+
+	if (!state_change)
+		return;
+
+	if (state_change->resource->resource)
+		kref_put(&state_change->resource->resource->kref, drbd_destroy_resource);
+	for (n = 0; n < state_change->n_devices; n++) {
+		struct drbd_device *device = state_change->devices[n].device;
+
+		if (device)
+			kref_put(&device->kref, drbd_destroy_device);
+	}
+	for (n = 0; n < state_change->n_connections; n++) {
+		struct drbd_connection *connection =
+			state_change->connections[n].connection;
+
+		if (connection)
+			kref_put(&connection->kref, drbd_destroy_connection);
+	}
+	kfree(state_change);
+}
+
 static int w_after_state_ch(struct drbd_work *w, int unused);
 static void after_state_ch(struct drbd_device *device, union drbd_state os,
-			   union drbd_state ns, enum chg_state_flags flags);
+			   union drbd_state ns, enum chg_state_flags flags,
+			   struct drbd_state_change *);
 static enum drbd_state_rv is_valid_state(struct drbd_device *, union drbd_state);
 static enum drbd_state_rv is_valid_soft_transition(union drbd_state, union drbd_state, struct drbd_connection *);
 static enum drbd_state_rv is_valid_transition(union drbd_state os, union drbd_state ns);
@@ -93,6 +352,7 @@ static enum drbd_role max_role(enum drbd_role role1, enum drbd_role role2)
 		return R_SECONDARY;
 	return R_UNKNOWN;
 }
+
 static enum drbd_role min_role(enum drbd_role role1, enum drbd_role role2)
 {
 	if (role1 == R_UNKNOWN || role2 == R_UNKNOWN)
@@ -983,6 +1243,7 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
 	enum drbd_state_rv rv = SS_SUCCESS;
 	enum sanitize_state_warnings ssw;
 	struct after_state_chg_work *ascw;
+	struct drbd_state_change *state_change;
 
 	os = drbd_read_state(device);
 
@@ -1037,6 +1298,9 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
 	if (!is_sync_state(os.conn) && is_sync_state(ns.conn))
 		clear_bit(RS_DONE, &device->flags);
 
+	/* FIXME: Have any flags been set earlier in this function already? */
+	state_change = remember_old_state(device->resource, GFP_ATOMIC);
+
 	/* changes to local_cnt and device flags should be visible before
 	 * changes to state, which again should be visible before anything else
 	 * depending on that change happens. */
@@ -1047,6 +1311,8 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
 	device->resource->susp_fen = ns.susp_fen;
 	smp_wmb();
 
+	remember_new_state(state_change);
+
 	/* put replicated vs not-replicated requests in seperate epochs */
 	if (drbd_should_do_remote((union drbd_dev_state)os.i) !=
 	    drbd_should_do_remote((union drbd_dev_state)ns.i))
@@ -1184,6 +1450,7 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
 		ascw->w.cb = w_after_state_ch;
 		ascw->device = device;
 		ascw->done = done;
+		ascw->state_change = state_change;
 		drbd_queue_work(&connection->sender_work,
 				&ascw->w);
 	} else {
@@ -1199,7 +1466,8 @@ static int w_after_state_ch(struct drbd_work *w, int unused)
 		container_of(w, struct after_state_chg_work, w);
 	struct drbd_device *device = ascw->device;
 
-	after_state_ch(device, ascw->os, ascw->ns, ascw->flags);
+	after_state_ch(device, ascw->os, ascw->ns, ascw->flags, ascw->state_change);
+	forget_state_change(ascw->state_change);
 	if (ascw->flags & CS_WAIT_COMPLETE)
 		complete(ascw->done);
 	kfree(ascw);
@@ -1245,6 +1513,139 @@ int drbd_bitmap_io_from_worker(struct drbd_device *device,
 	return rv;
 }
 
+void notify_resource_state_change(struct sk_buff *skb,
+				  unsigned int seq,
+				  struct drbd_resource_state_change *resource_state_change,
+				  enum drbd_notification_type type)
+{
+	struct drbd_resource *resource = resource_state_change->resource;
+	struct resource_info resource_info = {
+		.res_role = resource_state_change->role[NEW],
+		.res_susp = resource_state_change->susp[NEW],
+		.res_susp_nod = resource_state_change->susp_nod[NEW],
+		.res_susp_fen = resource_state_change->susp_fen[NEW],
+	};
+
+	notify_resource_state(skb, seq, resource, &resource_info, type);
+}
+
+void notify_connection_state_change(struct sk_buff *skb,
+				    unsigned int seq,
+				    struct drbd_connection_state_change *connection_state_change,
+				    enum drbd_notification_type type)
+{
+	struct drbd_connection *connection = connection_state_change->connection;
+	struct connection_info connection_info = {
+		.conn_connection_state = connection_state_change->cstate[NEW],
+		.conn_role = connection_state_change->peer_role[NEW],
+	};
+
+	notify_connection_state(skb, seq, connection, &connection_info, type);
+}
+
+void notify_device_state_change(struct sk_buff *skb,
+				unsigned int seq,
+				struct drbd_device_state_change *device_state_change,
+				enum drbd_notification_type type)
+{
+	struct drbd_device *device = device_state_change->device;
+	struct device_info device_info = {
+		.dev_disk_state = device_state_change->disk_state[NEW],
+	};
+
+	notify_device_state(skb, seq, device, &device_info, type);
+}
+
+void notify_peer_device_state_change(struct sk_buff *skb,
+				     unsigned int seq,
+				     struct drbd_peer_device_state_change *p,
+				     enum drbd_notification_type type)
+{
+	struct drbd_peer_device *peer_device = p->peer_device;
+	struct peer_device_info peer_device_info = {
+		.peer_repl_state = p->repl_state[NEW],
+		.peer_disk_state = p->disk_state[NEW],
+		.peer_resync_susp_user = p->resync_susp_user[NEW],
+		.peer_resync_susp_peer = p->resync_susp_peer[NEW],
+		.peer_resync_susp_dependency = p->resync_susp_dependency[NEW],
+	};
+
+	notify_peer_device_state(skb, seq, peer_device, &peer_device_info, type);
+}
+
+static void broadcast_state_change(struct drbd_state_change *state_change)
+{
+	struct drbd_resource_state_change *resource_state_change = &state_change->resource[0];
+	bool resource_state_has_changed;
+	unsigned int n_device, n_connection, n_peer_device, n_peer_devices;
+	void (*last_func)(struct sk_buff *, unsigned int, void *,
+			  enum drbd_notification_type) = NULL;
+	void *uninitialized_var(last_arg);
+
+#define HAS_CHANGED(state) ((state)[OLD] != (state)[NEW])
+#define FINAL_STATE_CHANGE(type) \
+	({ if (last_func) \
+		last_func(NULL, 0, last_arg, type); \
+	})
+#define REMEMBER_STATE_CHANGE(func, arg, type) \
+	({ FINAL_STATE_CHANGE(type | NOTIFY_CONTINUES); \
+	   last_func = (typeof(last_func))func; \
+	   last_arg = arg; \
+	 })
+
+	mutex_lock(&notification_mutex);
+
+	resource_state_has_changed =
+	    HAS_CHANGED(resource_state_change->role) ||
+	    HAS_CHANGED(resource_state_change->susp) ||
+	    HAS_CHANGED(resource_state_change->susp_nod) ||
+	    HAS_CHANGED(resource_state_change->susp_fen);
+
+	if (resource_state_has_changed)
+		REMEMBER_STATE_CHANGE(notify_resource_state_change,
+				      resource_state_change, NOTIFY_CHANGE);
+
+	for (n_connection = 0; n_connection < state_change->n_connections; n_connection++) {
+		struct drbd_connection_state_change *connection_state_change =
+				&state_change->connections[n_connection];
+
+		if (HAS_CHANGED(connection_state_change->peer_role) ||
+		    HAS_CHANGED(connection_state_change->cstate))
+			REMEMBER_STATE_CHANGE(notify_connection_state_change,
+					      connection_state_change, NOTIFY_CHANGE);
+	}
+
+	for (n_device = 0; n_device < state_change->n_devices; n_device++) {
+		struct drbd_device_state_change *device_state_change =
+			&state_change->devices[n_device];
+
+		if (HAS_CHANGED(device_state_change->disk_state))
+			REMEMBER_STATE_CHANGE(notify_device_state_change,
+					      device_state_change, NOTIFY_CHANGE);
+	}
+
+	n_peer_devices = state_change->n_devices * state_change->n_connections;
+	for (n_peer_device = 0; n_peer_device < n_peer_devices; n_peer_device++) {
+		struct drbd_peer_device_state_change *p =
+			&state_change->peer_devices[n_peer_device];
+
+		if (HAS_CHANGED(p->disk_state) ||
+		    HAS_CHANGED(p->repl_state) ||
+		    HAS_CHANGED(p->resync_susp_user) ||
+		    HAS_CHANGED(p->resync_susp_peer) ||
+		    HAS_CHANGED(p->resync_susp_dependency))
+			REMEMBER_STATE_CHANGE(notify_peer_device_state_change,
+					      p, NOTIFY_CHANGE);
+	}
+
+	FINAL_STATE_CHANGE(NOTIFY_CHANGE);
+	mutex_unlock(&notification_mutex);
+
+#undef HAS_CHANGED
+#undef FINAL_STATE_CHANGE
+#undef REMEMBER_STATE_CHANGE
+}
+
 /**
  * after_state_ch() - Perform after state change actions that may sleep
  * @device:	DRBD device.
@@ -1253,13 +1654,16 @@ int drbd_bitmap_io_from_worker(struct drbd_device *device,
  * @flags:	Flags
  */
 static void after_state_ch(struct drbd_device *device, union drbd_state os,
-			   union drbd_state ns, enum chg_state_flags flags)
+			   union drbd_state ns, enum chg_state_flags flags,
+			   struct drbd_state_change *state_change)
 {
 	struct drbd_resource *resource = device->resource;
 	struct drbd_peer_device *peer_device = first_peer_device(device);
 	struct drbd_connection *connection = peer_device ? peer_device->connection : NULL;
 	struct sib_info sib;
 
+	broadcast_state_change(state_change);
+
 	sib.sib_reason = SIB_STATE_CHANGE;
 	sib.os = os;
 	sib.ns = ns;
@@ -1572,6 +1976,7 @@ struct after_conn_state_chg_work {
 	union drbd_state ns_max; /* new, max state, over all devices */
 	enum chg_state_flags flags;
 	struct drbd_connection *connection;
+	struct drbd_state_change *state_change;
 };
 
 static int w_after_conn_state_ch(struct drbd_work *w, int unused)
@@ -1584,6 +1989,8 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 	struct drbd_peer_device *peer_device;
 	int vnr;
 
+	broadcast_state_change(acscw->state_change);
+	forget_state_change(acscw->state_change);
 	kfree(acscw);
 
 	/* Upon network configuration, we need to start the receiver */
@@ -1593,6 +2000,13 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 	if (oc == C_DISCONNECTING && ns_max.conn == C_STANDALONE) {
 		struct net_conf *old_conf;
 
+		mutex_lock(&notification_mutex);
+		idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+			notify_peer_device_state(NULL, 0, peer_device, NULL,
+						 NOTIFY_DESTROY | NOTIFY_CONTINUES);
+		notify_connection_state(NULL, 0, connection, NULL, NOTIFY_DESTROY);
+		mutex_unlock(&notification_mutex);
+
 		mutex_lock(&connection->resource->conf_update);
 		old_conf = connection->net_conf;
 		connection->my_addr_len = 0;
@@ -1823,6 +2237,7 @@ _conn_request_state(struct drbd_connection *connection, union drbd_state mask, u
 	enum drbd_conns oc = connection->cstate;
 	union drbd_state ns_max, ns_min, os;
 	bool have_mutex = false;
+	struct drbd_state_change *state_change;
 
 	if (mask.conn) {
 		rv = is_valid_conn_transition(oc, val.conn);
@@ -1868,10 +2283,12 @@ _conn_request_state(struct drbd_connection *connection, union drbd_state mask, u
 			goto abort;
 	}
 
+	state_change = remember_old_state(connection->resource, GFP_ATOMIC);
 	conn_old_common_state(connection, &os, &flags);
 	flags |= CS_DC_SUSP;
 	conn_set_state(connection, mask, val, &ns_min, &ns_max, flags);
 	conn_pr_state_change(connection, os, ns_max, flags);
+	remember_new_state(state_change);
 
 	acscw = kmalloc(sizeof(*acscw), GFP_ATOMIC);
 	if (acscw) {
@@ -1882,6 +2299,7 @@ _conn_request_state(struct drbd_connection *connection, union drbd_state mask, u
 		acscw->w.cb = w_after_conn_state_ch;
 		kref_get(&connection->kref);
 		acscw->connection = connection;
+		acscw->state_change = state_change;
 		drbd_queue_work(&connection->sender_work, &acscw->w);
 	} else {
 		drbd_err(connection, "Could not kmalloc an acscw\n");
diff --git a/drivers/block/drbd/drbd_state_change.h b/drivers/block/drbd/drbd_state_change.h
new file mode 100644
index 0000000..9e503a1
--- /dev/null
+++ b/drivers/block/drbd/drbd_state_change.h
@@ -0,0 +1,63 @@
+#ifndef DRBD_STATE_CHANGE_H
+#define DRBD_STATE_CHANGE_H
+
+struct drbd_resource_state_change {
+	struct drbd_resource *resource;
+	enum drbd_role role[2];
+	bool susp[2];
+	bool susp_nod[2];
+	bool susp_fen[2];
+};
+
+struct drbd_device_state_change {
+	struct drbd_device *device;
+	enum drbd_disk_state disk_state[2];
+};
+
+struct drbd_connection_state_change {
+	struct drbd_connection *connection;
+	enum drbd_conns cstate[2];  /* drbd9: enum drbd_conn_state */
+	enum drbd_role peer_role[2];
+};
+
+struct drbd_peer_device_state_change {
+	struct drbd_peer_device *peer_device;
+	enum drbd_disk_state disk_state[2];
+	enum drbd_conns repl_state[2];  /* drbd9: enum drbd_repl_state */
+	bool resync_susp_user[2];
+	bool resync_susp_peer[2];
+	bool resync_susp_dependency[2];
+};
+
+struct drbd_state_change {
+	struct list_head list;
+	unsigned int n_devices;
+	unsigned int n_connections;
+	struct drbd_resource_state_change resource[1];
+	struct drbd_device_state_change *devices;
+	struct drbd_connection_state_change *connections;
+	struct drbd_peer_device_state_change *peer_devices;
+};
+
+extern struct drbd_state_change *remember_old_state(struct drbd_resource *, gfp_t);
+extern void copy_old_to_new_state_change(struct drbd_state_change *);
+extern void forget_state_change(struct drbd_state_change *);
+
+extern void notify_resource_state_change(struct sk_buff *,
+					 unsigned int,
+					 struct drbd_resource_state_change *,
+					 enum drbd_notification_type type);
+extern void notify_connection_state_change(struct sk_buff *,
+					   unsigned int,
+					   struct drbd_connection_state_change *,
+					   enum drbd_notification_type type);
+extern void notify_device_state_change(struct sk_buff *,
+				       unsigned int,
+				       struct drbd_device_state_change *,
+				       enum drbd_notification_type type);
+extern void notify_peer_device_state_change(struct sk_buff *,
+					    unsigned int,
+					    struct drbd_peer_device_state_change *,
+					    enum drbd_notification_type type);
+
+#endif  /* DRBD_STATE_CHANGE_H */
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 15a1472..2c44d7e 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -339,6 +339,8 @@ enum drbd_state_rv {
 #define MDF_AL_CLEAN		(1 << 7)
 #define MDF_AL_DISABLED		(1 << 8)
 
+#define MAX_PEERS 32
+
 enum drbd_uuid_index {
 	UI_CURRENT,
 	UI_BITMAP,
@@ -349,12 +351,26 @@ enum drbd_uuid_index {
 	UI_EXTENDED_SIZE   /* Everything. */
 };
 
+#define HISTORY_UUIDS MAX_PEERS
+
 enum drbd_timeout_flag {
 	UT_DEFAULT      = 0,
 	UT_DEGRADED     = 1,
 	UT_PEER_OUTDATED = 2,
 };
 
+enum drbd_notification_type {
+	NOTIFY_EXISTS,
+	NOTIFY_CREATE,
+	NOTIFY_CHANGE,
+	NOTIFY_DESTROY,
+	NOTIFY_CALL,
+	NOTIFY_RESPONSE,
+
+	NOTIFY_CONTINUES = 0x8000,
+	NOTIFY_FLAGS = NOTIFY_CONTINUES,
+};
+
 #define UUID_JUST_CREATED ((__u64)4)
 
 enum write_ordering_e {
diff --git a/include/linux/drbd_genl.h b/include/linux/drbd_genl.h
index 7b131ed..90304f8 100644
--- a/include/linux/drbd_genl.h
+++ b/include/linux/drbd_genl.h
@@ -250,6 +250,76 @@ GENL_struct(DRBD_NLA_DETACH_PARMS, 13, detach_parms,
 	__flg_field(1, DRBD_GENLA_F_MANDATORY,	force_detach)
 )
 
+GENL_struct(DRBD_NLA_RESOURCE_INFO, 15, resource_info,
+	__u32_field(1, 0, res_role)
+	__flg_field(2, 0, res_susp)
+	__flg_field(3, 0, res_susp_nod)
+	__flg_field(4, 0, res_susp_fen)
+	/* __flg_field(5, 0, res_weak) */
+)
+
+GENL_struct(DRBD_NLA_DEVICE_INFO, 16, device_info,
+	__u32_field(1, 0, dev_disk_state)
+)
+
+GENL_struct(DRBD_NLA_CONNECTION_INFO, 17, connection_info,
+	__u32_field(1, 0, conn_connection_state)
+	__u32_field(2, 0, conn_role)
+)
+
+GENL_struct(DRBD_NLA_PEER_DEVICE_INFO, 18, peer_device_info,
+	__u32_field(1, 0, peer_repl_state)
+	__u32_field(2, 0, peer_disk_state)
+	__u32_field(3, 0, peer_resync_susp_user)
+	__u32_field(4, 0, peer_resync_susp_peer)
+	__u32_field(5, 0, peer_resync_susp_dependency)
+)
+
+GENL_struct(DRBD_NLA_RESOURCE_STATISTICS, 19, resource_statistics,
+	__u32_field(1, 0, res_stat_write_ordering)
+)
+
+GENL_struct(DRBD_NLA_DEVICE_STATISTICS, 20, device_statistics,
+	__u64_field(1, 0, dev_size)  /* (sectors) */
+	__u64_field(2, 0, dev_read)  /* (sectors) */
+	__u64_field(3, 0, dev_write)  /* (sectors) */
+	__u64_field(4, 0, dev_al_writes)  /* activity log writes (count) */
+	__u64_field(5, 0, dev_bm_writes)  /*  bitmap writes  (count) */
+	__u32_field(6, 0, dev_upper_pending)  /* application requests in progress */
+	__u32_field(7, 0, dev_lower_pending)  /* backing device requests in progress */
+	__flg_field(8, 0, dev_upper_blocked)
+	__flg_field(9, 0, dev_lower_blocked)
+	__flg_field(10, 0, dev_al_suspended)  /* activity log suspended */
+	__u64_field(11, 0, dev_exposed_data_uuid)
+	__u64_field(12, 0, dev_current_uuid)
+	__u32_field(13, 0, dev_disk_flags)
+	__bin_field(14, 0, history_uuids, HISTORY_UUIDS * sizeof(__u64))
+)
+
+GENL_struct(DRBD_NLA_CONNECTION_STATISTICS, 21, connection_statistics,
+	__flg_field(1, 0, conn_congested)
+)
+
+GENL_struct(DRBD_NLA_PEER_DEVICE_STATISTICS, 22, peer_device_statistics,
+	__u64_field(1, 0, peer_dev_received)  /* sectors */
+	__u64_field(2, 0, peer_dev_sent)  /* sectors */
+	__u32_field(3, 0, peer_dev_pending)  /* number of requests */
+	__u32_field(4, 0, peer_dev_unacked)  /* number of requests */
+	__u64_field(5, 0, peer_dev_out_of_sync)  /* sectors */
+	__u64_field(6, 0, peer_dev_resync_failed)  /* sectors */
+	__u64_field(7, 0, peer_dev_bitmap_uuid)
+	__u32_field(9, 0, peer_dev_flags)
+)
+
+GENL_struct(DRBD_NLA_NOTIFICATION_HEADER, 23, drbd_notification_header,
+	__u32_field(1, DRBD_GENLA_F_MANDATORY, nh_type)
+)
+
+GENL_struct(DRBD_NLA_HELPER, 24, drbd_helper_info,
+	__str_field(1, DRBD_GENLA_F_MANDATORY, helper_name, 32)
+	__u32_field(2, DRBD_GENLA_F_MANDATORY, helper_status)
+)
+
 /*
  * Notifications and commands (genlmsghdr->cmd)
  */
@@ -382,3 +452,47 @@ GENL_op(DRBD_ADM_GET_TIMEOUT_TYPE, 26, GENL_doit(drbd_adm_get_timeout_type),
 	GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_F_REQUIRED))
 GENL_op(DRBD_ADM_DOWN,		27, GENL_doit(drbd_adm_down),
 	GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_F_REQUIRED))
+
+GENL_notification(
+	DRBD_RESOURCE_STATE, 34, events,
+	GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_NOTIFICATION_HEADER, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_RESOURCE_INFO, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_RESOURCE_STATISTICS, DRBD_F_REQUIRED))
+
+GENL_notification(
+	DRBD_DEVICE_STATE, 35, events,
+	GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_NOTIFICATION_HEADER, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_DEVICE_INFO, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_DEVICE_STATISTICS, DRBD_F_REQUIRED))
+
+GENL_notification(
+	DRBD_CONNECTION_STATE, 36, events,
+	GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_NOTIFICATION_HEADER, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_CONNECTION_INFO, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_CONNECTION_STATISTICS, DRBD_F_REQUIRED))
+
+GENL_notification(
+	DRBD_PEER_DEVICE_STATE, 37, events,
+	GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_NOTIFICATION_HEADER, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_PEER_DEVICE_INFO, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_PEER_DEVICE_STATISTICS, DRBD_F_REQUIRED))
+
+GENL_op(
+	DRBD_ADM_GET_INITIAL_STATE, 38,
+	GENL_op_init(
+	        .dumpit = drbd_adm_get_initial_state,
+	),
+	GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_GENLA_F_MANDATORY))
+
+GENL_notification(
+	DRBD_HELPER, 40, events,
+	GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_F_REQUIRED)
+	GENL_tla_expected(DRBD_NLA_HELPER, DRBD_F_REQUIRED))
+
+GENL_notification(
+	DRBD_INITIAL_STATE_DONE, 41, events,
+	GENL_tla_expected(DRBD_NLA_NOTIFICATION_HEADER, DRBD_F_REQUIRED))
-- 
1.9.1

