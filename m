Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 20 Dec 2013 13:29:12 +0100
Message-Id: <1387542563-6833-16-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387542563-6833-1-git-send-email-philipp.reisner@linbit.com>
References: <1387542563-6833-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 15/26] drbd: Replace conn_get_by_name() with
	drbd_find_resource()
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

So far, connections and resources always come in pairs, but in the future with
multiple connections per resource, the names will stick with the resources.

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_int.h  |    2 +-
 drivers/block/drbd/drbd_main.c |   10 ++++------
 drivers/block/drbd/drbd_nl.c   |   38 +++++++++++++++++++++++++-------------
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 8b57e0b..1a1dd41 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1206,9 +1206,9 @@ extern void drbd_free_resource(struct drbd_resource *resource);
 extern int set_resource_options(struct drbd_connection *connection, struct res_opts *res_opts);
 extern struct drbd_connection *conn_create(const char *name, struct res_opts *res_opts);
 extern void drbd_destroy_connection(struct kref *kref);
-struct drbd_connection *conn_get_by_name(const char *name);
 extern struct drbd_connection *conn_get_by_addrs(void *my_addr, int my_addr_len,
 					    void *peer_addr, int peer_addr_len);
+extern struct drbd_resource *drbd_find_resource(const char *name);
 extern void drbd_destroy_resource(struct kref *kref);
 extern void conn_free_crypto(struct drbd_connection *connection);
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index fe16e6d..dd9fe7a 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2407,9 +2407,8 @@ static void drbd_init_workqueue(struct drbd_work_queue* wq)
 	init_waitqueue_head(&wq->q_wait);
 }
 
-struct drbd_connection *conn_get_by_name(const char *name)
+struct drbd_resource *drbd_find_resource(const char *name)
 {
-	struct drbd_connection *connection;
 	struct drbd_resource *resource;
 
 	if (!name || !name[0])
@@ -2418,15 +2417,14 @@ struct drbd_connection *conn_get_by_name(const char *name)
 	rcu_read_lock();
 	for_each_resource_rcu(resource, &drbd_resources) {
 		if (!strcmp(resource->name, name)) {
-			connection = first_connection(resource);
-			kref_get(&connection->kref);
+			kref_get(&resource->kref);
 			goto found;
 		}
 	}
-	connection = NULL;
+	resource = NULL;
 found:
 	rcu_read_unlock();
-	return connection;
+	return resource;
 }
 
 struct drbd_connection *conn_get_by_addrs(void *my_addr, int my_addr_len,
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 6b0aa47..d7c7c24 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -104,6 +104,7 @@ static struct drbd_config_context {
 	struct drbd_genlmsghdr *reply_dh;
 	/* resolved from attributes, if possible */
 	struct drbd_device *device;
+	struct drbd_resource *resource;
 	struct drbd_connection *connection;
 } adm_ctx;
 
@@ -213,13 +214,19 @@ static int drbd_adm_prepare(struct sk_buff *skb, struct genl_info *info,
 
 	adm_ctx.minor = d_in->minor;
 	adm_ctx.device = minor_to_device(d_in->minor);
-	adm_ctx.connection = conn_get_by_name(adm_ctx.resource_name);
+	if (adm_ctx.resource_name) {
+		adm_ctx.resource = drbd_find_resource(adm_ctx.resource_name);
+		if (adm_ctx.resource) {
+			adm_ctx.connection = first_connection(adm_ctx.resource);
+			kref_get(&adm_ctx.connection->kref);
+		}
+	}
 
 	if (!adm_ctx.device && (flags & DRBD_ADM_NEED_MINOR)) {
 		drbd_msg_put_info("unknown minor");
 		return ERR_MINOR_INVALID;
 	}
-	if (!adm_ctx.connection && (flags & DRBD_ADM_NEED_RESOURCE)) {
+	if (!adm_ctx.resource && (flags & DRBD_ADM_NEED_RESOURCE)) {
 		drbd_msg_put_info("unknown resource");
 		if (adm_ctx.resource_name)
 			return ERR_RES_NOT_KNOWN;
@@ -247,10 +254,10 @@ static int drbd_adm_prepare(struct sk_buff *skb, struct genl_info *info,
 	}
 
 	/* some more paranoia, if the request was over-determined */
-	if (adm_ctx.device && adm_ctx.connection &&
-	    first_peer_device(adm_ctx.device)->connection != adm_ctx.connection) {
-		pr_warning("request: minor=%u, resource=%s; but that minor belongs to connection %s\n",
-				adm_ctx.minor, adm_ctx.resource_name,
+	if (adm_ctx.device && adm_ctx.resource &&
+	    adm_ctx.device->resource != adm_ctx.resource) {
+		pr_warning("request: minor=%u, resource=%s; but that minor belongs to resource %s\n",
+				adm_ctx.minor, adm_ctx.resource->name,
 				adm_ctx.device->resource->name);
 		drbd_msg_put_info("minor exists in different resource");
 		return ERR_INVALID_REQUEST;
@@ -280,6 +287,10 @@ static int drbd_adm_finish(struct genl_info *info, int retcode)
 		kref_put(&adm_ctx.connection->kref, drbd_destroy_connection);
 		adm_ctx.connection = NULL;
 	}
+	if (adm_ctx.resource) {
+		kref_put(&adm_ctx.resource->kref, drbd_destroy_resource);
+		adm_ctx.resource = NULL;
+	}
 
 	if (!adm_ctx.reply_skb)
 		return -ENOMEM;
@@ -3034,7 +3045,7 @@ int drbd_adm_get_status_all(struct sk_buff *skb, struct netlink_callback *cb)
 	const unsigned hdrlen = GENL_HDRLEN + GENL_MAGIC_FAMILY_HDRSZ;
 	struct nlattr *nla;
 	const char *resource_name;
-	struct drbd_connection *connection;
+	struct drbd_resource *resource;
 	int maxtype;
 
 	/* Is this a followup call? */
@@ -3063,18 +3074,19 @@ int drbd_adm_get_status_all(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!nla)
 		return -EINVAL;
 	resource_name = nla_data(nla);
-	connection = conn_get_by_name(resource_name);
-
-	if (!connection)
+	if (!*resource_name)
+		return -ENODEV;
+	resource = drbd_find_resource(resource_name);
+	if (!resource)
 		return -ENODEV;
 
-	kref_put(&connection->kref, drbd_destroy_connection); /* get_one_status() (re)validates connection by itself */
+	kref_put(&resource->kref, drbd_destroy_resource); /* get_one_status() revalidates the resource */
 
 	/* prime iterators, and set "filter" mode mark:
 	 * only dump this connection. */
-	cb->args[0] = (long)connection;
+	cb->args[0] = (long)resource;
 	/* cb->args[1] = 0; passed in this way. */
-	cb->args[2] = (long)connection;
+	cb->args[2] = (long)resource;
 
 dump:
 	return get_one_status(skb, cb);
-- 
1.7.9.5

