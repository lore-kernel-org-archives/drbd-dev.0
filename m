Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C10F810556A0
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jul 2015 13:22:07 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2015 13:21:43 +0200
Message-Id: <1438255314-14877-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
References: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/19] drbd: Backport the "status" command
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

The status command originates the drbd9 code base. While for now we
keep the status information in /proc/drbd available, this commit
allows the user base to gracefully migrate their monitoring
infrastructure to the new status reporting interface.

In drbd9 no status information is exposed through /proc/drbd.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 566 +++++++++++++++++++++++++++++++++++++------
 include/linux/drbd_genl.h    |  35 +++
 include/linux/idr.h          |  14 ++
 3 files changed, 536 insertions(+), 79 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index e3218f7..6ed3876 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -76,6 +76,13 @@ int drbd_adm_get_status(struct sk_buff *skb, struct genl_info *info);
 int drbd_adm_get_timeout_type(struct sk_buff *skb, struct genl_info *info);
 /* .dumpit */
 int drbd_adm_get_status_all(struct sk_buff *skb, struct netlink_callback *cb);
+int drbd_adm_dump_resources(struct sk_buff *skb, struct netlink_callback *cb);
+int drbd_adm_dump_devices(struct sk_buff *skb, struct netlink_callback *cb);
+int drbd_adm_dump_devices_done(struct netlink_callback *cb);
+int drbd_adm_dump_connections(struct sk_buff *skb, struct netlink_callback *cb);
+int drbd_adm_dump_connections_done(struct netlink_callback *cb);
+int drbd_adm_dump_peer_devices(struct sk_buff *skb, struct netlink_callback *cb);
+int drbd_adm_dump_peer_devices_done(struct netlink_callback *cb);
 int drbd_adm_get_initial_state(struct sk_buff *skb, struct netlink_callback *cb);
 
 #include <linux/drbd_genl_api.h>
@@ -2965,6 +2972,486 @@ nla_put_failure:
 }
 
 /*
+ * The generic netlink dump callbacks are called outside the genl_lock(), so
+ * they cannot use the simple attribute parsing code which uses global
+ * attribute tables.
+ */
+static struct nlattr *find_cfg_context_attr(const struct nlmsghdr *nlh, int attr)
+{
+	const unsigned hdrlen = GENL_HDRLEN + GENL_MAGIC_FAMILY_HDRSZ;
+	const int maxtype = ARRAY_SIZE(drbd_cfg_context_nl_policy) - 1;
+	struct nlattr *nla;
+
+	nla = nla_find(nlmsg_attrdata(nlh, hdrlen), nlmsg_attrlen(nlh, hdrlen),
+		       DRBD_NLA_CFG_CONTEXT);
+	if (!nla)
+		return NULL;
+	return drbd_nla_find_nested(maxtype, nla, __nla_type(attr));
+}
+
+static void resource_to_info(struct resource_info *, struct drbd_resource *);
+
+int drbd_adm_dump_resources(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct drbd_genlmsghdr *dh;
+	struct drbd_resource *resource;
+	struct resource_info resource_info;
+	struct resource_statistics resource_statistics;
+	int err;
+
+	rcu_read_lock();
+	if (cb->args[0]) {
+		for_each_resource_rcu(resource, &drbd_resources)
+			if (resource == (struct drbd_resource *)cb->args[0])
+				goto found_resource;
+		err = 0;  /* resource was probably deleted */
+		goto out;
+	}
+	resource = list_entry(&drbd_resources,
+			      struct drbd_resource, resources);
+
+found_resource:
+	list_for_each_entry_continue_rcu(resource, &drbd_resources, resources) {
+		goto put_result;
+	}
+	err = 0;
+	goto out;
+
+put_result:
+	dh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+			cb->nlh->nlmsg_seq, &drbd_genl_family,
+			NLM_F_MULTI, DRBD_ADM_GET_RESOURCES);
+	err = -ENOMEM;
+	if (!dh)
+		goto out;
+	dh->minor = -1U;
+	dh->ret_code = NO_ERROR;
+	err = nla_put_drbd_cfg_context(skb, resource, NULL, NULL);
+	if (err)
+		goto out;
+	err = res_opts_to_skb(skb, &resource->res_opts, !capable(CAP_SYS_ADMIN));
+	if (err)
+		goto out;
+	resource_to_info(&resource_info, resource);
+	err = resource_info_to_skb(skb, &resource_info, !capable(CAP_SYS_ADMIN));
+	if (err)
+		goto out;
+	resource_statistics.res_stat_write_ordering = resource->write_ordering;
+	err = resource_statistics_to_skb(skb, &resource_statistics, !capable(CAP_SYS_ADMIN));
+	if (err)
+		goto out;
+	cb->args[0] = (long)resource;
+	genlmsg_end(skb, dh);
+	err = 0;
+
+out:
+	rcu_read_unlock();
+	if (err)
+		return err;
+	return skb->len;
+}
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
+static int put_resource_in_arg0(struct netlink_callback *cb, int holder_nr)
+{
+	if (cb->args[0]) {
+		struct drbd_resource *resource =
+			(struct drbd_resource *)cb->args[0];
+		kref_put(&resource->kref, drbd_destroy_resource);
+	}
+
+	return 0;
+}
+
+int drbd_adm_dump_devices_done(struct netlink_callback *cb) {
+	return put_resource_in_arg0(cb, 7);
+}
+
+static void device_to_info(struct device_info *, struct drbd_device *);
+
+int drbd_adm_dump_devices(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct nlattr *resource_filter;
+	struct drbd_resource *resource;
+	struct drbd_device *uninitialized_var(device);
+	int minor, err, retcode;
+	struct drbd_genlmsghdr *dh;
+	struct device_info device_info;
+	struct device_statistics device_statistics;
+	struct idr *idr_to_search;
+
+	resource = (struct drbd_resource *)cb->args[0];
+	if (!cb->args[0] && !cb->args[1]) {
+		resource_filter = find_cfg_context_attr(cb->nlh, T_ctx_resource_name);
+		if (resource_filter) {
+			retcode = ERR_RES_NOT_KNOWN;
+			resource = drbd_find_resource(nla_data(resource_filter));
+			if (!resource)
+				goto put_result;
+			cb->args[0] = (long)resource;
+		}
+	}
+
+	rcu_read_lock();
+	minor = cb->args[1];
+	idr_to_search = resource ? &resource->devices : &drbd_devices;
+	device = idr_get_next(idr_to_search, &minor);
+	if (!device) {
+		err = 0;
+		goto out;
+	}
+	idr_for_each_entry_continue(idr_to_search, device, minor) {
+		retcode = NO_ERROR;
+		goto put_result;  /* only one iteration */
+	}
+	err = 0;
+	goto out;  /* no more devices */
+
+put_result:
+	dh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+			cb->nlh->nlmsg_seq, &drbd_genl_family,
+			NLM_F_MULTI, DRBD_ADM_GET_DEVICES);
+	err = -ENOMEM;
+	if (!dh)
+		goto out;
+	dh->ret_code = retcode;
+	dh->minor = -1U;
+	if (retcode == NO_ERROR) {
+		dh->minor = device->minor;
+		err = nla_put_drbd_cfg_context(skb, device->resource, NULL, device);
+		if (err)
+			goto out;
+		if (get_ldev(device)) {
+			struct disk_conf *disk_conf =
+				rcu_dereference(device->ldev->disk_conf);
+
+			err = disk_conf_to_skb(skb, disk_conf, !capable(CAP_SYS_ADMIN));
+			put_ldev(device);
+			if (err)
+				goto out;
+		}
+		device_to_info(&device_info, device);
+		err = device_info_to_skb(skb, &device_info, !capable(CAP_SYS_ADMIN));
+		if (err)
+			goto out;
+
+		device_to_statistics(&device_statistics, device);
+		err = device_statistics_to_skb(skb, &device_statistics, !capable(CAP_SYS_ADMIN));
+		if (err)
+			goto out;
+		cb->args[1] = minor + 1;
+	}
+	genlmsg_end(skb, dh);
+	err = 0;
+
+out:
+	rcu_read_unlock();
+	if (err)
+		return err;
+	return skb->len;
+}
+
+int drbd_adm_dump_connections_done(struct netlink_callback *cb)
+{
+	return put_resource_in_arg0(cb, 6);
+}
+
+enum { SINGLE_RESOURCE, ITERATE_RESOURCES };
+
+int drbd_adm_dump_connections(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct nlattr *resource_filter;
+	struct drbd_resource *resource = NULL, *next_resource;
+	struct drbd_connection *uninitialized_var(connection);
+	int err = 0, retcode;
+	struct drbd_genlmsghdr *dh;
+	struct connection_info connection_info;
+	struct connection_statistics connection_statistics;
+
+	rcu_read_lock();
+	resource = (struct drbd_resource *)cb->args[0];
+	if (!cb->args[0]) {
+		resource_filter = find_cfg_context_attr(cb->nlh, T_ctx_resource_name);
+		if (resource_filter) {
+			retcode = ERR_RES_NOT_KNOWN;
+			resource = drbd_find_resource(nla_data(resource_filter));
+			if (!resource)
+				goto put_result;
+			cb->args[0] = (long)resource;
+			cb->args[1] = SINGLE_RESOURCE;
+		}
+	}
+	if (!resource) {
+		if (list_empty(&drbd_resources))
+			goto out;
+		resource = list_first_entry(&drbd_resources, struct drbd_resource, resources);
+		kref_get(&resource->kref);
+		cb->args[0] = (long)resource;
+		cb->args[1] = ITERATE_RESOURCES;
+	}
+
+    next_resource:
+	rcu_read_unlock();
+	mutex_lock(&resource->conf_update);
+	rcu_read_lock();
+	if (cb->args[2]) {
+		for_each_connection_rcu(connection, resource)
+			if (connection == (struct drbd_connection *)cb->args[2])
+				goto found_connection;
+		/* connection was probably deleted */
+		goto no_more_connections;
+	}
+	connection = list_entry(&resource->connections, struct drbd_connection, connections);
+
+found_connection:
+	list_for_each_entry_continue_rcu(connection, &resource->connections, connections) {
+		if (!has_net_conf(connection))
+			continue;
+		retcode = NO_ERROR;
+		goto put_result;  /* only one iteration */
+	}
+
+no_more_connections:
+	if (cb->args[1] == ITERATE_RESOURCES) {
+		for_each_resource_rcu(next_resource, &drbd_resources) {
+			if (next_resource == resource)
+				goto found_resource;
+		}
+		/* resource was probably deleted */
+	}
+	goto out;
+
+found_resource:
+	list_for_each_entry_continue_rcu(next_resource, &drbd_resources, resources) {
+		mutex_unlock(&resource->conf_update);
+		kref_put(&resource->kref, drbd_destroy_resource);
+		resource = next_resource;
+		kref_get(&resource->kref);
+		cb->args[0] = (long)resource;
+		cb->args[2] = 0;
+		goto next_resource;
+	}
+	goto out;  /* no more resources */
+
+put_result:
+	dh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+			cb->nlh->nlmsg_seq, &drbd_genl_family,
+			NLM_F_MULTI, DRBD_ADM_GET_CONNECTIONS);
+	err = -ENOMEM;
+	if (!dh)
+		goto out;
+	dh->ret_code = retcode;
+	dh->minor = -1U;
+	if (retcode == NO_ERROR) {
+		struct net_conf *net_conf;
+
+		err = nla_put_drbd_cfg_context(skb, resource, connection, NULL);
+		if (err)
+			goto out;
+		net_conf = rcu_dereference(connection->net_conf);
+		if (net_conf) {
+			err = net_conf_to_skb(skb, net_conf, !capable(CAP_SYS_ADMIN));
+			if (err)
+				goto out;
+		}
+		connection_to_info(&connection_info, connection);
+		err = connection_info_to_skb(skb, &connection_info, !capable(CAP_SYS_ADMIN));
+		if (err)
+			goto out;
+		connection_statistics.conn_congested = test_bit(NET_CONGESTED, &connection->flags);
+		err = connection_statistics_to_skb(skb, &connection_statistics, !capable(CAP_SYS_ADMIN));
+		if (err)
+			goto out;
+		cb->args[2] = (long)connection;
+	}
+	genlmsg_end(skb, dh);
+	err = 0;
+
+out:
+	rcu_read_unlock();
+	if (resource)
+		mutex_unlock(&resource->conf_update);
+	if (err)
+		return err;
+	return skb->len;
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
+int drbd_adm_dump_peer_devices_done(struct netlink_callback *cb)
+{
+	return put_resource_in_arg0(cb, 9);
+}
+
+int drbd_adm_dump_peer_devices(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct nlattr *resource_filter;
+	struct drbd_resource *resource;
+	struct drbd_device *uninitialized_var(device);
+	struct drbd_peer_device *peer_device = NULL;
+	int minor, err, retcode;
+	struct drbd_genlmsghdr *dh;
+	struct idr *idr_to_search;
+
+	resource = (struct drbd_resource *)cb->args[0];
+	if (!cb->args[0] && !cb->args[1]) {
+		resource_filter = find_cfg_context_attr(cb->nlh, T_ctx_resource_name);
+		if (resource_filter) {
+			retcode = ERR_RES_NOT_KNOWN;
+			resource = drbd_find_resource(nla_data(resource_filter));
+			if (!resource)
+				goto put_result;
+		}
+		cb->args[0] = (long)resource;
+	}
+
+	rcu_read_lock();
+	minor = cb->args[1];
+	idr_to_search = resource ? &resource->devices : &drbd_devices;
+	device = idr_find(idr_to_search, minor);
+	if (!device) {
+next_device:
+		minor++;
+		cb->args[2] = 0;
+		device = idr_get_next(idr_to_search, &minor);
+		if (!device) {
+			err = 0;
+			goto out;
+		}
+	}
+	if (cb->args[2]) {
+		for_each_peer_device(peer_device, device)
+			if (peer_device == (struct drbd_peer_device *)cb->args[2])
+				goto found_peer_device;
+		/* peer device was probably deleted */
+		goto next_device;
+	}
+	/* Make peer_device point to the list head (not the first entry). */
+	peer_device = list_entry(&device->peer_devices, struct drbd_peer_device, peer_devices);
+
+found_peer_device:
+	list_for_each_entry_continue_rcu(peer_device, &device->peer_devices, peer_devices) {
+		if (!has_net_conf(peer_device->connection))
+			continue;
+		retcode = NO_ERROR;
+		goto put_result;  /* only one iteration */
+	}
+	goto next_device;
+
+put_result:
+	dh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+			cb->nlh->nlmsg_seq, &drbd_genl_family,
+			NLM_F_MULTI, DRBD_ADM_GET_PEER_DEVICES);
+	err = -ENOMEM;
+	if (!dh)
+		goto out;
+	dh->ret_code = retcode;
+	dh->minor = -1U;
+	if (retcode == NO_ERROR) {
+		struct peer_device_info peer_device_info;
+		struct peer_device_statistics peer_device_statistics;
+
+		dh->minor = minor;
+		err = nla_put_drbd_cfg_context(skb, device->resource, peer_device->connection, device);
+		if (err)
+			goto out;
+		peer_device_to_info(&peer_device_info, peer_device);
+		err = peer_device_info_to_skb(skb, &peer_device_info, !capable(CAP_SYS_ADMIN));
+		if (err)
+			goto out;
+		peer_device_to_statistics(&peer_device_statistics, peer_device);
+		err = peer_device_statistics_to_skb(skb, &peer_device_statistics, !capable(CAP_SYS_ADMIN));
+		if (err)
+			goto out;
+		cb->args[1] = minor;
+		cb->args[2] = (long)peer_device;
+	}
+	genlmsg_end(skb, dh);
+	err = 0;
+
+out:
+	rcu_read_unlock();
+	if (err)
+		return err;
+	return skb->len;
+}
+/*
  * Return the connection of @resource if @resource has exactly one connection.
  */
 static struct drbd_connection *the_only_connection(struct drbd_resource *resource)
@@ -3818,85 +4305,6 @@ failed:
 			err, seq, sib->sib_reason);
 }
 
-static void device_to_statistics(struct device_statistics *s,
-				 struct drbd_device *device)
-{
-	memset(s, 0, sizeof(*s));
-	s->dev_upper_blocked = !may_inc_ap_bio(device);
-	if (get_ldev(device)) {
-		struct drbd_md *md = &device->ldev->md;
-		u64 *history_uuids = (u64 *)s->history_uuids;
-		struct request_queue *q;
-		int n;
-
-		spin_lock_irq(&md->uuid_lock);
-		s->dev_current_uuid = md->uuid[UI_CURRENT];
-		BUILD_BUG_ON(sizeof(s->history_uuids) < UI_HISTORY_END - UI_HISTORY_START + 1);
-		for (n = 0; n < UI_HISTORY_END - UI_HISTORY_START + 1; n++)
-			history_uuids[n] = md->uuid[UI_HISTORY_START + n];
-		for (; n < HISTORY_UUIDS; n++)
-			history_uuids[n] = 0;
-		s->history_uuids_len = HISTORY_UUIDS;
-		spin_unlock_irq(&md->uuid_lock);
-
-		s->dev_disk_flags = md->flags;
-		q = bdev_get_queue(device->ldev->backing_bdev);
-		s->dev_lower_blocked =
-			bdi_congested(&q->backing_dev_info,
-				      (1 << WB_async_congested) |
-				      (1 << WB_sync_congested));
-		put_ldev(device);
-	}
-	s->dev_size = drbd_get_capacity(device->this_bdev);
-	s->dev_read = device->read_cnt;
-	s->dev_write = device->writ_cnt;
-	s->dev_al_writes = device->al_writ_cnt;
-	s->dev_bm_writes = device->bm_writ_cnt;
-	s->dev_upper_pending = atomic_read(&device->ap_bio_cnt);
-	s->dev_lower_pending = atomic_read(&device->local_cnt);
-	s->dev_al_suspended = test_bit(AL_SUSPENDED, &device->flags);
-	s->dev_exposed_data_uuid = device->ed_uuid;
-}
-
-enum mdf_peer_flag {
-	MDF_PEER_CONNECTED =	1 << 0,
-	MDF_PEER_OUTDATED =	1 << 1,
-	MDF_PEER_FENCING =	1 << 2,
-	MDF_PEER_FULL_SYNC =	1 << 3,
-};
-
-static void peer_device_to_statistics(struct peer_device_statistics *s,
-				      struct drbd_peer_device *peer_device)
-{
-	struct drbd_device *device = peer_device->device;
-
-	memset(s, 0, sizeof(*s));
-	s->peer_dev_received = device->recv_cnt;
-	s->peer_dev_sent = device->send_cnt;
-	s->peer_dev_pending = atomic_read(&device->ap_pending_cnt) +
-			      atomic_read(&device->rs_pending_cnt);
-	s->peer_dev_unacked = atomic_read(&device->unacked_cnt);
-	s->peer_dev_out_of_sync = drbd_bm_total_weight(device) << (BM_BLOCK_SHIFT - 9);
-	s->peer_dev_resync_failed = device->rs_failed << (BM_BLOCK_SHIFT - 9);
-	if (get_ldev(device)) {
-		struct drbd_md *md = &device->ldev->md;
-
-		spin_lock_irq(&md->uuid_lock);
-		s->peer_dev_bitmap_uuid = md->uuid[UI_BITMAP];
-		spin_unlock_irq(&md->uuid_lock);
-		s->peer_dev_flags =
-			(drbd_md_test_flag(device->ldev, MDF_CONNECTED_IND) ?
-				MDF_PEER_CONNECTED : 0) +
-			(drbd_md_test_flag(device->ldev, MDF_CONSISTENT) &&
-			 !drbd_md_test_flag(device->ldev, MDF_WAS_UP_TO_DATE) ?
-				MDF_PEER_OUTDATED : 0) +
-			/* FIXME: MDF_PEER_FENCING? */
-			(drbd_md_test_flag(device->ldev, MDF_FULL_SYNC) ?
-				MDF_PEER_FULL_SYNC : 0);
-		put_ldev(device);
-	}
-}
-
 static int nla_put_notification_header(struct sk_buff *msg,
 				       enum drbd_notification_type type)
 {
diff --git a/include/linux/drbd_genl.h b/include/linux/drbd_genl.h
index 90304f8..2d0e5ad 100644
--- a/include/linux/drbd_genl.h
+++ b/include/linux/drbd_genl.h
@@ -453,6 +453,41 @@ GENL_op(DRBD_ADM_GET_TIMEOUT_TYPE, 26, GENL_doit(drbd_adm_get_timeout_type),
 GENL_op(DRBD_ADM_DOWN,		27, GENL_doit(drbd_adm_down),
 	GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_F_REQUIRED))
 
+GENL_op(DRBD_ADM_GET_RESOURCES, 30,
+	 GENL_op_init(
+		 .dumpit = drbd_adm_dump_resources,
+	 ),
+	 GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_GENLA_F_MANDATORY)
+	 GENL_tla_expected(DRBD_NLA_RESOURCE_INFO, DRBD_GENLA_F_MANDATORY)
+	 GENL_tla_expected(DRBD_NLA_RESOURCE_STATISTICS, DRBD_GENLA_F_MANDATORY))
+
+GENL_op(DRBD_ADM_GET_DEVICES, 31,
+	 GENL_op_init(
+		 .dumpit = drbd_adm_dump_devices,
+		 .done = drbd_adm_dump_devices_done,
+	 ),
+	 GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_GENLA_F_MANDATORY)
+	 GENL_tla_expected(DRBD_NLA_DEVICE_INFO, DRBD_GENLA_F_MANDATORY)
+	 GENL_tla_expected(DRBD_NLA_DEVICE_STATISTICS, DRBD_GENLA_F_MANDATORY))
+
+GENL_op(DRBD_ADM_GET_CONNECTIONS, 32,
+	 GENL_op_init(
+		 .dumpit = drbd_adm_dump_connections,
+		 .done = drbd_adm_dump_connections_done,
+	 ),
+	 GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_GENLA_F_MANDATORY)
+	 GENL_tla_expected(DRBD_NLA_CONNECTION_INFO, DRBD_GENLA_F_MANDATORY)
+	 GENL_tla_expected(DRBD_NLA_CONNECTION_STATISTICS, DRBD_GENLA_F_MANDATORY))
+
+GENL_op(DRBD_ADM_GET_PEER_DEVICES, 33,
+	 GENL_op_init(
+		 .dumpit = drbd_adm_dump_peer_devices,
+		 .done = drbd_adm_dump_peer_devices_done,
+	 ),
+	 GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_GENLA_F_MANDATORY)
+	 GENL_tla_expected(DRBD_NLA_PEER_DEVICE_INFO, DRBD_GENLA_F_MANDATORY)
+	 GENL_tla_expected(DRBD_NLA_PEER_DEVICE_STATISTICS, DRBD_GENLA_F_MANDATORY))
+
 GENL_notification(
 	DRBD_RESOURCE_STATE, 34, events,
 	GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_F_REQUIRED)
diff --git a/include/linux/idr.h b/include/linux/idr.h
index 013fd9b..083d61e 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -135,6 +135,20 @@ static inline void *idr_find(struct idr *idr, int id)
 #define idr_for_each_entry(idp, entry, id)			\
 	for (id = 0; ((entry) = idr_get_next(idp, &(id))) != NULL; ++id)
 
+/**
+ * idr_for_each_entry - continue iteration over an idr's elements of a given type
+ * @idp:     idr handle
+ * @entry:   the type * to use as cursor
+ * @id:      id entry's key
+ *
+ * Continue to iterate over list of given type, continuing after
+ * the current position.
+ */
+#define idr_for_each_entry_continue(idp, entry, id)			\
+	for ((entry) = idr_get_next((idp), &(id));			\
+	     entry;							\
+	     ++id, (entry) = idr_get_next((idp), &(id)))
+
 /*
  * IDA - IDR based id allocator, use when translation from id to
  * pointer isn't necessary.
-- 
1.9.1

