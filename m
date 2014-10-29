Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A688D101AC7E
	for <drbd-dev@lists.linbit.com>; Wed, 29 Oct 2014 17:37:57 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 29 Oct 2014 17:37:50 +0100
Message-Id: <1414600676-11203-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1414600676-11203-1-git-send-email-philipp.reisner@linbit.com>
References: <1414600676-11203-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/7] drbd: Minor cleanups
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

 . Update comments
 . drbd_set_{in,out_of}_sync(): Remove unused parameters
 . Move common code into adm_del_resource()
 . Redefine ERR_MINOR_EXISTS -> ERR_MINOR_OR_VOLUME_EXISTS

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c |  3 +-
 drivers/block/drbd/drbd_int.h    |  9 +++---
 drivers/block/drbd/drbd_main.c   |  6 ++--
 drivers/block/drbd/drbd_nl.c     | 60 +++++++++++++++++-----------------------
 include/linux/drbd.h             |  2 +-
 5 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index a2dfa16..1318e32 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -827,8 +827,7 @@ static int update_sync_bits(struct drbd_device *device,
  *
  */
 int __drbd_change_sync(struct drbd_device *device, sector_t sector, int size,
-		enum update_sync_bits_mode mode,
-		const char *file, const unsigned int line)
+		enum update_sync_bits_mode mode)
 {
 	/* Is called from worker and receiver context _only_ */
 	unsigned long sbnr, ebnr, lbnr;
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 9b22f8f..c14b718 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1662,14 +1662,13 @@ extern void drbd_advance_rs_marks(struct drbd_device *device, unsigned long stil
 
 enum update_sync_bits_mode { RECORD_RS_FAILED, SET_OUT_OF_SYNC, SET_IN_SYNC };
 extern int __drbd_change_sync(struct drbd_device *device, sector_t sector, int size,
-		enum update_sync_bits_mode mode,
-		const char *file, const unsigned int line);
+		enum update_sync_bits_mode mode);
 #define drbd_set_in_sync(device, sector, size) \
-	__drbd_change_sync(device, sector, size, SET_IN_SYNC, __FILE__, __LINE__)
+	__drbd_change_sync(device, sector, size, SET_IN_SYNC)
 #define drbd_set_out_of_sync(device, sector, size) \
-	__drbd_change_sync(device, sector, size, SET_OUT_OF_SYNC, __FILE__, __LINE__)
+	__drbd_change_sync(device, sector, size, SET_OUT_OF_SYNC)
 #define drbd_rs_failed_io(device, sector, size) \
-	__drbd_change_sync(device, sector, size, RECORD_RS_FAILED, __FILE__, __LINE__)
+	__drbd_change_sync(device, sector, size, RECORD_RS_FAILED)
 extern void drbd_al_shrink(struct drbd_device *device);
 extern int drbd_initialize_al(struct drbd_device *, void *);
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 973c185..cce25a5 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2731,7 +2731,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	device = minor_to_device(minor);
 	if (device)
-		return ERR_MINOR_EXISTS;
+		return ERR_MINOR_OR_VOLUME_EXISTS;
 
 	/* GFP_KERNEL, we are outside of all write-out paths */
 	device = kzalloc(sizeof(struct drbd_device), GFP_KERNEL);
@@ -2794,7 +2794,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	id = idr_alloc(&drbd_devices, device, minor, minor + 1, GFP_KERNEL);
 	if (id < 0) {
 		if (id == -ENOSPC) {
-			err = ERR_MINOR_EXISTS;
+			err = ERR_MINOR_OR_VOLUME_EXISTS;
 			drbd_msg_put_info(adm_ctx->reply_skb, "requested minor exists already");
 		}
 		goto out_no_minor_idr;
@@ -2804,7 +2804,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	id = idr_alloc(&resource->devices, device, vnr, vnr + 1, GFP_KERNEL);
 	if (id < 0) {
 		if (id == -ENOSPC) {
-			err = ERR_MINOR_EXISTS;
+			err = ERR_MINOR_OR_VOLUME_EXISTS;
 			drbd_msg_put_info(adm_ctx->reply_skb, "requested minor exists already");
 		}
 		goto out_idr_remove_minor;
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 1cd47df..c145619 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2052,7 +2052,7 @@ check_net_options(struct drbd_connection *connection, struct net_conf *new_net_c
 	rv = _check_net_options(connection, rcu_dereference(connection->net_conf), new_net_conf);
 	rcu_read_unlock();
 
-	/* connection->volumes protected by genl_lock() here */
+	/* connection->peer_devices protected by genl_lock() here */
 	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
 		struct drbd_device *device = peer_device->device;
 		if (!device->bitmap) {
@@ -3483,7 +3483,7 @@ int drbd_adm_new_minor(struct sk_buff *skb, struct genl_info *info)
 	 * that first_peer_device(device)->connection and device->vnr match the request. */
 	if (adm_ctx.device) {
 		if (info->nlhdr->nlmsg_flags & NLM_F_EXCL)
-			retcode = ERR_MINOR_EXISTS;
+			retcode = ERR_MINOR_OR_VOLUME_EXISTS;
 		/* else: still NO_ERROR */
 		goto out;
 	}
@@ -3530,6 +3530,27 @@ out:
 	return 0;
 }
 
+static int adm_del_resource(struct drbd_resource *resource)
+{
+	struct drbd_connection *connection;
+
+	for_each_connection(connection, resource) {
+		if (connection->cstate > C_STANDALONE)
+			return ERR_NET_CONFIGURED;
+	}
+	if (!idr_is_empty(&resource->devices))
+		return ERR_RES_IN_USE;
+
+	list_del_rcu(&resource->resources);
+	/* Make sure all threads have actually stopped: state handling only
+	 * does drbd_thread_stop_nowait(). */
+	list_for_each_entry(connection, &resource->connections, connections)
+		drbd_thread_stop(&connection->worker);
+	synchronize_rcu();
+	drbd_free_resource(resource);
+	return NO_ERROR;
+}
+
 int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 {
 	struct drbd_config_context adm_ctx;
@@ -3575,14 +3596,6 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	/* If we reach this, all volumes (of this connection) are Secondary,
-	 * Disconnected, Diskless, aka Unconfigured. Make sure all threads have
-	 * actually stopped, state handling only does drbd_thread_stop_nowait(). */
-	for_each_connection(connection, resource)
-		drbd_thread_stop(&connection->worker);
-
-	/* Now, nothing can fail anymore */
-
 	/* delete volumes */
 	idr_for_each_entry(&resource->devices, device, i) {
 		retcode = adm_del_minor(device);
@@ -3593,10 +3606,7 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	list_del_rcu(&resource->resources);
-	synchronize_rcu();
-	drbd_free_resource(resource);
-	retcode = NO_ERROR;
+	retcode = adm_del_resource(resource);
 out:
 	mutex_unlock(&resource->adm_mutex);
 finish:
@@ -3608,7 +3618,6 @@ int drbd_adm_del_resource(struct sk_buff *skb, struct genl_info *info)
 {
 	struct drbd_config_context adm_ctx;
 	struct drbd_resource *resource;
-	struct drbd_connection *connection;
 	enum drbd_ret_code retcode;
 
 	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_RESOURCE);
@@ -3616,27 +3625,10 @@ int drbd_adm_del_resource(struct sk_buff *skb, struct genl_info *info)
 		return retcode;
 	if (retcode != NO_ERROR)
 		goto finish;
-
 	resource = adm_ctx.resource;
-	mutex_lock(&resource->adm_mutex);
-	for_each_connection(connection, resource) {
-		if (connection->cstate > C_STANDALONE) {
-			retcode = ERR_NET_CONFIGURED;
-			goto out;
-		}
-	}
-	if (!idr_is_empty(&resource->devices)) {
-		retcode = ERR_RES_IN_USE;
-		goto out;
-	}
 
-	list_del_rcu(&resource->resources);
-	for_each_connection(connection, resource)
-		drbd_thread_stop(&connection->worker);
-	synchronize_rcu();
-	drbd_free_resource(resource);
-	retcode = NO_ERROR;
-out:
+	mutex_lock(&resource->adm_mutex);
+	retcode = adm_del_resource(resource);
 	mutex_unlock(&resource->adm_mutex);
 finish:
 	drbd_adm_finish(&adm_ctx, info, retcode);
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index debb70d..8723f2a 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -172,7 +172,7 @@ enum drbd_ret_code {
 	ERR_RES_NOT_KNOWN	= 158,
 	ERR_RES_IN_USE		= 159,
 	ERR_MINOR_CONFIGURED    = 160,
-	ERR_MINOR_EXISTS	= 161,
+	ERR_MINOR_OR_VOLUME_EXISTS = 161,
 	ERR_INVALID_REQUEST	= 162,
 	ERR_NEED_APV_100	= 163,
 	ERR_NEED_ALLOW_TWO_PRI  = 164,
-- 
1.9.1

