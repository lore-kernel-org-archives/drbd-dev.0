Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:21 +0200
Message-Id: <1398703415-17780-11-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/24] drbd: perpare for genetlink parallel_ops
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

Because all administrative requests via genetlink have been globally
serialized via genl_lock(), we used to have one static struct
drbd_config_context "admin context".

Move this on-stack to the respective callback functions.

This will allow us to selectively drop the genl_lock()
(or use genl_family->parallel_ops) in the future.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h  |  28 +++-
 drivers/block/drbd/drbd_main.c |  12 +-
 drivers/block/drbd/drbd_nl.c   | 333 ++++++++++++++++++++---------------------
 3 files changed, 198 insertions(+), 175 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f0cabea..20a1772 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -814,6 +814,28 @@ struct drbd_device {
 	struct submit_worker submit;
 };
 
+struct drbd_config_context {
+	/* assigned from drbd_genlmsghdr */
+	unsigned int minor;
+	/* assigned from request attributes, if present */
+	unsigned int volume;
+#define VOLUME_UNSPECIFIED		(-1U)
+	/* pointer into the request skb,
+	 * limited lifetime! */
+	char *resource_name;
+	struct nlattr *my_addr;
+	struct nlattr *peer_addr;
+
+	/* reply buffer */
+	struct sk_buff *reply_skb;
+	/* pointer into reply buffer */
+	struct drbd_genlmsghdr *reply_dh;
+	/* resolved from attributes, if possible */
+	struct drbd_device *device;
+	struct drbd_resource *resource;
+	struct drbd_connection *connection;
+};
+
 static inline struct drbd_device *minor_to_device(unsigned int minor)
 {
 	return (struct drbd_device *)idr_find(&drbd_devices, minor);
@@ -1229,9 +1251,9 @@ extern struct bio *bio_alloc_drbd(gfp_t gfp_mask);
 extern rwlock_t global_state_lock;
 
 extern int conn_lowest_minor(struct drbd_connection *connection);
-enum drbd_ret_code drbd_create_device(struct drbd_resource *resource, unsigned int minor, int vnr);
+extern enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsigned int minor);
 extern void drbd_destroy_device(struct kref *kref);
-extern void drbd_delete_device(struct drbd_device *mdev);
+extern void drbd_delete_device(struct drbd_device *device);
 
 extern struct drbd_resource *drbd_create_resource(const char *name);
 extern void drbd_free_resource(struct drbd_resource *resource);
@@ -1257,7 +1279,7 @@ extern int is_valid_ar_handle(struct drbd_request *, sector_t);
 
 
 /* drbd_nl.c */
-extern int drbd_msg_put_info(const char *info);
+extern int drbd_msg_put_info(struct sk_buff *skb, const char *info);
 extern void drbd_suspend_io(struct drbd_device *device);
 extern void drbd_resume_io(struct drbd_device *device);
 extern char *ppsize(char *buf, unsigned long long size);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 331e5cc..865fdb3 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2687,14 +2687,16 @@ static int init_submitter(struct drbd_device *device)
 	return 0;
 }
 
-enum drbd_ret_code drbd_create_device(struct drbd_resource *resource, unsigned int minor, int vnr)
+enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsigned int minor)
 {
+	struct drbd_resource *resource = adm_ctx->resource;
 	struct drbd_connection *connection;
 	struct drbd_device *device;
 	struct drbd_peer_device *peer_device, *tmp_peer_device;
 	struct gendisk *disk;
 	struct request_queue *q;
 	int id;
+	int vnr = adm_ctx->volume;
 	enum drbd_ret_code err = ERR_NOMEM;
 
 	device = minor_to_device(minor);
@@ -2763,7 +2765,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_resource *resource, unsigned i
 	if (id < 0) {
 		if (id == -ENOSPC) {
 			err = ERR_MINOR_EXISTS;
-			drbd_msg_put_info("requested minor exists already");
+			drbd_msg_put_info(adm_ctx->reply_skb, "requested minor exists already");
 		}
 		goto out_no_minor_idr;
 	}
@@ -2773,7 +2775,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_resource *resource, unsigned i
 	if (id < 0) {
 		if (id == -ENOSPC) {
 			err = ERR_MINOR_EXISTS;
-			drbd_msg_put_info("requested minor exists already");
+			drbd_msg_put_info(adm_ctx->reply_skb, "requested minor exists already");
 		}
 		goto out_idr_remove_minor;
 	}
@@ -2794,7 +2796,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_resource *resource, unsigned i
 		if (id < 0) {
 			if (id == -ENOSPC) {
 				err = ERR_INVALID_REQUEST;
-				drbd_msg_put_info("requested volume exists already");
+				drbd_msg_put_info(adm_ctx->reply_skb, "requested volume exists already");
 			}
 			goto out_idr_remove_from_resource;
 		}
@@ -2803,7 +2805,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_resource *resource, unsigned i
 
 	if (init_submitter(device)) {
 		err = ERR_NOMEM;
-		drbd_msg_put_info("unable to create submit workqueue");
+		drbd_msg_put_info(adm_ctx->reply_skb, "unable to create submit workqueue");
 		goto out_idr_remove_vol;
 	}
 
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d219210..118ac72 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -81,32 +81,6 @@ int drbd_adm_get_status_all(struct sk_buff *skb, struct netlink_callback *cb);
 /* used blkdev_get_by_path, to claim our meta data device(s) */
 static char *drbd_m_holder = "Hands off! this is DRBD's meta data device.";
 
-/* Configuration is strictly serialized, because generic netlink message
- * processing is strictly serialized by the genl_lock().
- * Which means we can use one static global drbd_config_context struct.
- */
-static struct drbd_config_context {
-	/* assigned from drbd_genlmsghdr */
-	unsigned int minor;
-	/* assigned from request attributes, if present */
-	unsigned int volume;
-#define VOLUME_UNSPECIFIED		(-1U)
-	/* pointer into the request skb,
-	 * limited lifetime! */
-	char *resource_name;
-	struct nlattr *my_addr;
-	struct nlattr *peer_addr;
-
-	/* reply buffer */
-	struct sk_buff *reply_skb;
-	/* pointer into reply buffer */
-	struct drbd_genlmsghdr *reply_dh;
-	/* resolved from attributes, if possible */
-	struct drbd_device *device;
-	struct drbd_resource *resource;
-	struct drbd_connection *connection;
-} adm_ctx;
-
 static void drbd_adm_send_reply(struct sk_buff *skb, struct genl_info *info)
 {
 	genlmsg_end(skb, genlmsg_data(nlmsg_data(nlmsg_hdr(skb))));
@@ -116,9 +90,8 @@ static void drbd_adm_send_reply(struct sk_buff *skb, struct genl_info *info)
 
 /* Used on a fresh "drbd_adm_prepare"d reply_skb, this cannot fail: The only
  * reason it could fail was no space in skb, and there are 4k available. */
-int drbd_msg_put_info(const char *info)
+int drbd_msg_put_info(struct sk_buff *skb, const char *info)
 {
-	struct sk_buff *skb = adm_ctx.reply_skb;
 	struct nlattr *nla;
 	int err = -EMSGSIZE;
 
@@ -146,38 +119,38 @@ int drbd_msg_put_info(const char *info)
 #define DRBD_ADM_NEED_MINOR	1
 #define DRBD_ADM_NEED_RESOURCE	2
 #define DRBD_ADM_NEED_CONNECTION 4
-static int drbd_adm_prepare(struct sk_buff *skb, struct genl_info *info,
-		unsigned flags)
+static int drbd_adm_prepare(struct drbd_config_context *adm_ctx,
+	struct sk_buff *skb, struct genl_info *info, unsigned flags)
 {
 	struct drbd_genlmsghdr *d_in = info->userhdr;
 	const u8 cmd = info->genlhdr->cmd;
 	int err;
 
-	memset(&adm_ctx, 0, sizeof(adm_ctx));
+	memset(adm_ctx, 0, sizeof(*adm_ctx));
 
 	/* genl_rcv_msg only checks for CAP_NET_ADMIN on "GENL_ADMIN_PERM" :( */
 	if (cmd != DRBD_ADM_GET_STATUS && !capable(CAP_NET_ADMIN))
 	       return -EPERM;
 
-	adm_ctx.reply_skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!adm_ctx.reply_skb) {
+	adm_ctx->reply_skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!adm_ctx->reply_skb) {
 		err = -ENOMEM;
 		goto fail;
 	}
 
-	adm_ctx.reply_dh = genlmsg_put_reply(adm_ctx.reply_skb,
+	adm_ctx->reply_dh = genlmsg_put_reply(adm_ctx->reply_skb,
 					info, &drbd_genl_family, 0, cmd);
 	/* put of a few bytes into a fresh skb of >= 4k will always succeed.
 	 * but anyways */
-	if (!adm_ctx.reply_dh) {
+	if (!adm_ctx->reply_dh) {
 		err = -ENOMEM;
 		goto fail;
 	}
 
-	adm_ctx.reply_dh->minor = d_in->minor;
-	adm_ctx.reply_dh->ret_code = NO_ERROR;
+	adm_ctx->reply_dh->minor = d_in->minor;
+	adm_ctx->reply_dh->ret_code = NO_ERROR;
 
-	adm_ctx.volume = VOLUME_UNSPECIFIED;
+	adm_ctx->volume = VOLUME_UNSPECIFIED;
 	if (info->attrs[DRBD_NLA_CFG_CONTEXT]) {
 		struct nlattr *nla;
 		/* parse and validate only */
@@ -187,7 +160,7 @@ static int drbd_adm_prepare(struct sk_buff *skb, struct genl_info *info,
 
 		/* It was present, and valid,
 		 * copy it over to the reply skb. */
-		err = nla_put_nohdr(adm_ctx.reply_skb,
+		err = nla_put_nohdr(adm_ctx->reply_skb,
 				info->attrs[DRBD_NLA_CFG_CONTEXT]->nla_len,
 				info->attrs[DRBD_NLA_CFG_CONTEXT]);
 		if (err)
@@ -196,102 +169,103 @@ static int drbd_adm_prepare(struct sk_buff *skb, struct genl_info *info,
 		/* and assign stuff to the global adm_ctx */
 		nla = nested_attr_tb[__nla_type(T_ctx_volume)];
 		if (nla)
-			adm_ctx.volume = nla_get_u32(nla);
+			adm_ctx->volume = nla_get_u32(nla);
 		nla = nested_attr_tb[__nla_type(T_ctx_resource_name)];
 		if (nla)
-			adm_ctx.resource_name = nla_data(nla);
-		adm_ctx.my_addr = nested_attr_tb[__nla_type(T_ctx_my_addr)];
-		adm_ctx.peer_addr = nested_attr_tb[__nla_type(T_ctx_peer_addr)];
-		if ((adm_ctx.my_addr &&
-		     nla_len(adm_ctx.my_addr) > sizeof(adm_ctx.connection->my_addr)) ||
-		    (adm_ctx.peer_addr &&
-		     nla_len(adm_ctx.peer_addr) > sizeof(adm_ctx.connection->peer_addr))) {
+			adm_ctx->resource_name = nla_data(nla);
+		adm_ctx->my_addr = nested_attr_tb[__nla_type(T_ctx_my_addr)];
+		adm_ctx->peer_addr = nested_attr_tb[__nla_type(T_ctx_peer_addr)];
+		if ((adm_ctx->my_addr &&
+		     nla_len(adm_ctx->my_addr) > sizeof(adm_ctx->connection->my_addr)) ||
+		    (adm_ctx->peer_addr &&
+		     nla_len(adm_ctx->peer_addr) > sizeof(adm_ctx->connection->peer_addr))) {
 			err = -EINVAL;
 			goto fail;
 		}
 	}
 
-	adm_ctx.minor = d_in->minor;
-	adm_ctx.device = minor_to_device(d_in->minor);
-	if (adm_ctx.resource_name) {
-		adm_ctx.resource = drbd_find_resource(adm_ctx.resource_name);
+	adm_ctx->minor = d_in->minor;
+	adm_ctx->device = minor_to_device(d_in->minor);
+	if (adm_ctx->resource_name) {
+		adm_ctx->resource = drbd_find_resource(adm_ctx->resource_name);
 	}
 
-	if (!adm_ctx.device && (flags & DRBD_ADM_NEED_MINOR)) {
-		drbd_msg_put_info("unknown minor");
+	if (!adm_ctx->device && (flags & DRBD_ADM_NEED_MINOR)) {
+		drbd_msg_put_info(adm_ctx->reply_skb, "unknown minor");
 		return ERR_MINOR_INVALID;
 	}
-	if (!adm_ctx.resource && (flags & DRBD_ADM_NEED_RESOURCE)) {
-		drbd_msg_put_info("unknown resource");
-		if (adm_ctx.resource_name)
+	if (!adm_ctx->resource && (flags & DRBD_ADM_NEED_RESOURCE)) {
+		drbd_msg_put_info(adm_ctx->reply_skb, "unknown resource");
+		if (adm_ctx->resource_name)
 			return ERR_RES_NOT_KNOWN;
 		return ERR_INVALID_REQUEST;
 	}
 
 	if (flags & DRBD_ADM_NEED_CONNECTION) {
-		if (adm_ctx.resource) {
-			drbd_msg_put_info("no resource name expected");
+		if (adm_ctx->resource) {
+			drbd_msg_put_info(adm_ctx->reply_skb, "no resource name expected");
 			return ERR_INVALID_REQUEST;
 		}
-		if (adm_ctx.device) {
-			drbd_msg_put_info("no minor number expected");
+		if (adm_ctx->device) {
+			drbd_msg_put_info(adm_ctx->reply_skb, "no minor number expected");
 			return ERR_INVALID_REQUEST;
 		}
-		if (adm_ctx.my_addr && adm_ctx.peer_addr)
-			adm_ctx.connection = conn_get_by_addrs(nla_data(adm_ctx.my_addr),
-							  nla_len(adm_ctx.my_addr),
-							  nla_data(adm_ctx.peer_addr),
-							  nla_len(adm_ctx.peer_addr));
-		if (!adm_ctx.connection) {
-			drbd_msg_put_info("unknown connection");
+		if (adm_ctx->my_addr && adm_ctx->peer_addr)
+			adm_ctx->connection = conn_get_by_addrs(nla_data(adm_ctx->my_addr),
+							  nla_len(adm_ctx->my_addr),
+							  nla_data(adm_ctx->peer_addr),
+							  nla_len(adm_ctx->peer_addr));
+		if (!adm_ctx->connection) {
+			drbd_msg_put_info(adm_ctx->reply_skb, "unknown connection");
 			return ERR_INVALID_REQUEST;
 		}
 	}
 
 	/* some more paranoia, if the request was over-determined */
-	if (adm_ctx.device && adm_ctx.resource &&
-	    adm_ctx.device->resource != adm_ctx.resource) {
+	if (adm_ctx->device && adm_ctx->resource &&
+	    adm_ctx->device->resource != adm_ctx->resource) {
 		pr_warning("request: minor=%u, resource=%s; but that minor belongs to resource %s\n",
-				adm_ctx.minor, adm_ctx.resource->name,
-				adm_ctx.device->resource->name);
-		drbd_msg_put_info("minor exists in different resource");
+				adm_ctx->minor, adm_ctx->resource->name,
+				adm_ctx->device->resource->name);
+		drbd_msg_put_info(adm_ctx->reply_skb, "minor exists in different resource");
 		return ERR_INVALID_REQUEST;
 	}
-	if (adm_ctx.device &&
-	    adm_ctx.volume != VOLUME_UNSPECIFIED &&
-	    adm_ctx.volume != adm_ctx.device->vnr) {
+	if (adm_ctx->device &&
+	    adm_ctx->volume != VOLUME_UNSPECIFIED &&
+	    adm_ctx->volume != adm_ctx->device->vnr) {
 		pr_warning("request: minor=%u, volume=%u; but that minor is volume %u in %s\n",
-				adm_ctx.minor, adm_ctx.volume,
-				adm_ctx.device->vnr,
-				adm_ctx.device->resource->name);
-		drbd_msg_put_info("minor exists as different volume");
+				adm_ctx->minor, adm_ctx->volume,
+				adm_ctx->device->vnr,
+				adm_ctx->device->resource->name);
+		drbd_msg_put_info(adm_ctx->reply_skb, "minor exists as different volume");
 		return ERR_INVALID_REQUEST;
 	}
 
 	return NO_ERROR;
 
 fail:
-	nlmsg_free(adm_ctx.reply_skb);
-	adm_ctx.reply_skb = NULL;
+	nlmsg_free(adm_ctx->reply_skb);
+	adm_ctx->reply_skb = NULL;
 	return err;
 }
 
-static int drbd_adm_finish(struct genl_info *info, int retcode)
+static int drbd_adm_finish(struct drbd_config_context *adm_ctx,
+	struct genl_info *info, int retcode)
 {
-	if (adm_ctx.connection) {
-		kref_put(&adm_ctx.connection->kref, drbd_destroy_connection);
-		adm_ctx.connection = NULL;
+	if (adm_ctx->connection) {
+		kref_put(&adm_ctx->connection->kref, &drbd_destroy_connection);
+		adm_ctx->connection = NULL;
 	}
-	if (adm_ctx.resource) {
-		kref_put(&adm_ctx.resource->kref, drbd_destroy_resource);
-		adm_ctx.resource = NULL;
+	if (adm_ctx->resource) {
+		kref_put(&adm_ctx->resource->kref, drbd_destroy_resource);
+		adm_ctx->resource = NULL;
 	}
 
-	if (!adm_ctx.reply_skb)
+	if (!adm_ctx->reply_skb)
 		return -ENOMEM;
 
-	adm_ctx.reply_dh->ret_code = retcode;
-	drbd_adm_send_reply(adm_ctx.reply_skb, info);
+	adm_ctx->reply_dh->ret_code = retcode;
+	drbd_adm_send_reply(adm_ctx->reply_skb, info);
 	return 0;
 }
 
@@ -707,11 +681,12 @@ static const char *from_attrs_err_to_txt(int err)
 
 int drbd_adm_set_role(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	struct set_role_parms parms;
 	int err;
 	enum drbd_ret_code retcode;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -722,7 +697,7 @@ int drbd_adm_set_role(struct sk_buff *skb, struct genl_info *info)
 		err = set_role_parms_from_attrs(&parms, info);
 		if (err) {
 			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(from_attrs_err_to_txt(err));
+			drbd_msg_put_info(adm_ctx.reply_skb, from_attrs_err_to_txt(err));
 			goto out;
 		}
 	}
@@ -732,7 +707,7 @@ int drbd_adm_set_role(struct sk_buff *skb, struct genl_info *info)
 	else
 		retcode = drbd_set_role(adm_ctx.device, R_SECONDARY, 0);
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
@@ -1265,13 +1240,14 @@ static unsigned int drbd_al_extents_max(struct drbd_backing_dev *bdev)
 
 int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	enum drbd_ret_code retcode;
 	struct drbd_device *device;
 	struct disk_conf *new_disk_conf, *old_disk_conf;
 	struct fifo_buffer *old_plan = NULL, *new_plan = NULL;
 	int err, fifo_size;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -1301,7 +1277,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 	err = disk_conf_from_attrs_for_change(new_disk_conf, info);
 	if (err && err != -ENOMSG) {
 		retcode = ERR_MANDATORY_TAG;
-		drbd_msg_put_info(from_attrs_err_to_txt(err));
+		drbd_msg_put_info(adm_ctx.reply_skb, from_attrs_err_to_txt(err));
 		goto fail_unlock;
 	}
 
@@ -1392,12 +1368,13 @@ fail_unlock:
 success:
 	put_ldev(device);
  out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
 int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	struct drbd_device *device;
 	int err;
 	enum drbd_ret_code retcode;
@@ -1413,7 +1390,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	enum drbd_state_rv rv;
 	struct net_conf *nc;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -1462,7 +1439,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	err = disk_conf_from_attrs(new_disk_conf, info);
 	if (err) {
 		retcode = ERR_MANDATORY_TAG;
-		drbd_msg_put_info(from_attrs_err_to_txt(err));
+		drbd_msg_put_info(adm_ctx.reply_skb, from_attrs_err_to_txt(err));
 		goto fail;
 	}
 
@@ -1804,7 +1781,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	kobject_uevent(&disk_to_dev(device->vdisk)->kobj, KOBJ_CHANGE);
 	put_ldev(device);
 	conn_reconfig_done(first_peer_device(device)->connection);
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 
  force_diskless_dec:
@@ -1828,7 +1805,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	kfree(new_plan);
 
  finish:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
@@ -1867,11 +1844,12 @@ out:
  * Only then we have finally detached. */
 int drbd_adm_detach(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	enum drbd_ret_code retcode;
 	struct detach_parms parms = { };
 	int err;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -1881,14 +1859,14 @@ int drbd_adm_detach(struct sk_buff *skb, struct genl_info *info)
 		err = detach_parms_from_attrs(&parms, info);
 		if (err) {
 			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(from_attrs_err_to_txt(err));
+			drbd_msg_put_info(adm_ctx.reply_skb, from_attrs_err_to_txt(err));
 			goto out;
 		}
 	}
 
 	retcode = adm_detach(adm_ctx.device, parms.force_detach);
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
@@ -2062,6 +2040,7 @@ static void free_crypto(struct crypto *crypto)
 
 int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	enum drbd_ret_code retcode;
 	struct drbd_connection *connection;
 	struct net_conf *old_net_conf, *new_net_conf = NULL;
@@ -2070,7 +2049,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 	int rsr; /* re-sync running */
 	struct crypto crypto = { };
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_CONNECTION);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_CONNECTION);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -2091,7 +2070,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 	old_net_conf = connection->net_conf;
 
 	if (!old_net_conf) {
-		drbd_msg_put_info("net conf missing, try connect");
+		drbd_msg_put_info(adm_ctx.reply_skb, "net conf missing, try connect");
 		retcode = ERR_INVALID_REQUEST;
 		goto fail;
 	}
@@ -2103,7 +2082,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 	err = net_conf_from_attrs_for_change(new_net_conf, info);
 	if (err && err != -ENOMSG) {
 		retcode = ERR_MANDATORY_TAG;
-		drbd_msg_put_info(from_attrs_err_to_txt(err));
+		drbd_msg_put_info(adm_ctx.reply_skb, from_attrs_err_to_txt(err));
 		goto fail;
 	}
 
@@ -2174,12 +2153,13 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
  done:
 	conn_reconfig_done(connection);
  out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
 int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	struct drbd_peer_device *peer_device;
 	struct net_conf *old_net_conf, *new_net_conf = NULL;
 	struct crypto crypto = { };
@@ -2189,14 +2169,14 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	int i;
 	int err;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_RESOURCE);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_RESOURCE);
 
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
 		goto out;
 	if (!(adm_ctx.my_addr && adm_ctx.peer_addr)) {
-		drbd_msg_put_info("connection endpoint(s) missing");
+		drbd_msg_put_info(adm_ctx.reply_skb, "connection endpoint(s) missing");
 		retcode = ERR_INVALID_REQUEST;
 		goto out;
 	}
@@ -2242,7 +2222,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	err = net_conf_from_attrs(new_net_conf, info);
 	if (err && err != -ENOMSG) {
 		retcode = ERR_MANDATORY_TAG;
-		drbd_msg_put_info(from_attrs_err_to_txt(err));
+		drbd_msg_put_info(adm_ctx.reply_skb, from_attrs_err_to_txt(err));
 		goto fail;
 	}
 
@@ -2291,7 +2271,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	retcode = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
 
 	conn_reconfig_done(connection);
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 
 fail:
@@ -2300,7 +2280,7 @@ fail:
 
 	conn_reconfig_done(connection);
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
@@ -2363,13 +2343,14 @@ static enum drbd_state_rv conn_try_disconnect(struct drbd_connection *connection
 
 int drbd_adm_disconnect(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	struct disconnect_parms parms;
 	struct drbd_connection *connection;
 	enum drbd_state_rv rv;
 	enum drbd_ret_code retcode;
 	int err;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_CONNECTION);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_CONNECTION);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -2381,7 +2362,7 @@ int drbd_adm_disconnect(struct sk_buff *skb, struct genl_info *info)
 		err = disconnect_parms_from_attrs(&parms, info);
 		if (err) {
 			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(from_attrs_err_to_txt(err));
+			drbd_msg_put_info(adm_ctx.reply_skb, from_attrs_err_to_txt(err));
 			goto fail;
 		}
 	}
@@ -2392,7 +2373,7 @@ int drbd_adm_disconnect(struct sk_buff *skb, struct genl_info *info)
 	else
 		retcode = NO_ERROR;
  fail:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
@@ -2414,6 +2395,7 @@ void resync_after_online_grow(struct drbd_device *device)
 
 int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	struct disk_conf *old_disk_conf, *new_disk_conf = NULL;
 	struct resize_parms rs;
 	struct drbd_device *device;
@@ -2424,7 +2406,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 	sector_t u_size;
 	int err;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -2443,7 +2425,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 		err = resize_parms_from_attrs(&rs, info);
 		if (err) {
 			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(from_attrs_err_to_txt(err));
+			drbd_msg_put_info(adm_ctx.reply_skb, from_attrs_err_to_txt(err));
 			goto fail_ldev;
 		}
 	}
@@ -2535,7 +2517,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 	}
 
  fail:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 
  fail_ldev:
@@ -2545,11 +2527,12 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 
 int drbd_adm_resource_opts(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	enum drbd_ret_code retcode;
 	struct res_opts res_opts;
 	int err;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_RESOURCE);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_RESOURCE);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -2562,7 +2545,7 @@ int drbd_adm_resource_opts(struct sk_buff *skb, struct genl_info *info)
 	err = res_opts_from_attrs(&res_opts, info);
 	if (err && err != -ENOMSG) {
 		retcode = ERR_MANDATORY_TAG;
-		drbd_msg_put_info(from_attrs_err_to_txt(err));
+		drbd_msg_put_info(adm_ctx.reply_skb, from_attrs_err_to_txt(err));
 		goto fail;
 	}
 
@@ -2574,16 +2557,17 @@ int drbd_adm_resource_opts(struct sk_buff *skb, struct genl_info *info)
 	}
 
 fail:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
 int drbd_adm_invalidate(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	struct drbd_device *device;
 	int retcode; /* enum drbd_ret_code rsp. enum drbd_state_rv */
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -2614,16 +2598,17 @@ int drbd_adm_invalidate(struct sk_buff *skb, struct genl_info *info)
 	drbd_resume_io(device);
 
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
 static int drbd_adm_simple_request_state(struct sk_buff *skb, struct genl_info *info,
 		union drbd_state mask, union drbd_state val)
 {
+	struct drbd_config_context adm_ctx;
 	enum drbd_ret_code retcode;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -2631,7 +2616,7 @@ static int drbd_adm_simple_request_state(struct sk_buff *skb, struct genl_info *
 
 	retcode = drbd_request_state(adm_ctx.device, mask, val);
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
@@ -2646,10 +2631,11 @@ static int drbd_bmio_set_susp_al(struct drbd_device *device)
 
 int drbd_adm_invalidate_peer(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	int retcode; /* drbd_ret_code, drbd_state_rv */
 	struct drbd_device *device;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -2683,15 +2669,16 @@ int drbd_adm_invalidate_peer(struct sk_buff *skb, struct genl_info *info)
 	drbd_resume_io(device);
 
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
 int drbd_adm_pause_sync(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	enum drbd_ret_code retcode;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -2700,16 +2687,17 @@ int drbd_adm_pause_sync(struct sk_buff *skb, struct genl_info *info)
 	if (drbd_request_state(adm_ctx.device, NS(user_isp, 1)) == SS_NOTHING_TO_DO)
 		retcode = ERR_PAUSE_IS_SET;
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
 int drbd_adm_resume_sync(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	union drbd_dev_state s;
 	enum drbd_ret_code retcode;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -2726,7 +2714,7 @@ int drbd_adm_resume_sync(struct sk_buff *skb, struct genl_info *info)
 	}
 
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
@@ -2737,10 +2725,11 @@ int drbd_adm_suspend_io(struct sk_buff *skb, struct genl_info *info)
 
 int drbd_adm_resume_io(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	struct drbd_device *device;
 	int retcode; /* enum drbd_ret_code rsp. enum drbd_state_rv */
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -2762,7 +2751,7 @@ int drbd_adm_resume_io(struct sk_buff *skb, struct genl_info *info)
 	drbd_resume_io(device);
 
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
@@ -2938,10 +2927,11 @@ nla_put_failure:
 
 int drbd_adm_get_status(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	enum drbd_ret_code retcode;
 	int err;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -2953,7 +2943,7 @@ int drbd_adm_get_status(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
@@ -3140,11 +3130,12 @@ dump:
 
 int drbd_adm_get_timeout_type(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	enum drbd_ret_code retcode;
 	struct timeout_parms tp;
 	int err;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -3161,17 +3152,18 @@ int drbd_adm_get_timeout_type(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
 int drbd_adm_start_ov(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	struct drbd_device *device;
 	enum drbd_ret_code retcode;
 	struct start_ov_parms parms;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -3186,7 +3178,7 @@ int drbd_adm_start_ov(struct sk_buff *skb, struct genl_info *info)
 		int err = start_ov_parms_from_attrs(&parms, info);
 		if (err) {
 			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(from_attrs_err_to_txt(err));
+			drbd_msg_put_info(adm_ctx.reply_skb, from_attrs_err_to_txt(err));
 			goto out;
 		}
 	}
@@ -3201,20 +3193,21 @@ int drbd_adm_start_ov(struct sk_buff *skb, struct genl_info *info)
 	retcode = drbd_request_state(device, NS(conn, C_VERIFY_S));
 	drbd_resume_io(device);
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
 
 int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	struct drbd_device *device;
 	enum drbd_ret_code retcode;
 	int skip_initial_sync = 0;
 	int err;
 	struct new_c_uuid_parms args;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -3226,7 +3219,7 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 		err = new_c_uuid_parms_from_attrs(&args, info);
 		if (err) {
 			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(from_attrs_err_to_txt(err));
+			drbd_msg_put_info(adm_ctx.reply_skb, from_attrs_err_to_txt(err));
 			goto out_nolock;
 		}
 	}
@@ -3276,21 +3269,22 @@ out_dec:
 out:
 	mutex_unlock(device->state_mutex);
 out_nolock:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
 static enum drbd_ret_code
-drbd_check_resource_name(const char *name)
+drbd_check_resource_name(struct drbd_config_context *adm_ctx)
 {
+	const char *name = adm_ctx->resource_name;
 	if (!name || !name[0]) {
-		drbd_msg_put_info("resource name missing");
+		drbd_msg_put_info(adm_ctx->reply_skb, "resource name missing");
 		return ERR_MANDATORY_TAG;
 	}
 	/* if we want to use these in sysfs/configfs/debugfs some day,
 	 * we must not allow slashes */
 	if (strchr(name, '/')) {
-		drbd_msg_put_info("invalid resource name");
+		drbd_msg_put_info(adm_ctx->reply_skb, "invalid resource name");
 		return ERR_INVALID_REQUEST;
 	}
 	return NO_ERROR;
@@ -3298,11 +3292,12 @@ drbd_check_resource_name(const char *name)
 
 int drbd_adm_new_resource(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	enum drbd_ret_code retcode;
 	struct res_opts res_opts;
 	int err;
 
-	retcode = drbd_adm_prepare(skb, info, 0);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, 0);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -3312,18 +3307,18 @@ int drbd_adm_new_resource(struct sk_buff *skb, struct genl_info *info)
 	err = res_opts_from_attrs(&res_opts, info);
 	if (err && err != -ENOMSG) {
 		retcode = ERR_MANDATORY_TAG;
-		drbd_msg_put_info(from_attrs_err_to_txt(err));
+		drbd_msg_put_info(adm_ctx.reply_skb, from_attrs_err_to_txt(err));
 		goto out;
 	}
 
-	retcode = drbd_check_resource_name(adm_ctx.resource_name);
+	retcode = drbd_check_resource_name(&adm_ctx);
 	if (retcode != NO_ERROR)
 		goto out;
 
 	if (adm_ctx.resource) {
 		if (info->nlhdr->nlmsg_flags & NLM_F_EXCL) {
 			retcode = ERR_INVALID_REQUEST;
-			drbd_msg_put_info("resource exists");
+			drbd_msg_put_info(adm_ctx.reply_skb, "resource exists");
 		}
 		/* else: still NO_ERROR */
 		goto out;
@@ -3332,28 +3327,29 @@ int drbd_adm_new_resource(struct sk_buff *skb, struct genl_info *info)
 	if (!conn_create(adm_ctx.resource_name, &res_opts))
 		retcode = ERR_NOMEM;
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
 int drbd_adm_new_minor(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	struct drbd_genlmsghdr *dh = info->userhdr;
 	enum drbd_ret_code retcode;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_RESOURCE);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_RESOURCE);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
 		goto out;
 
 	if (dh->minor > MINORMASK) {
-		drbd_msg_put_info("requested minor out of range");
+		drbd_msg_put_info(adm_ctx.reply_skb, "requested minor out of range");
 		retcode = ERR_INVALID_REQUEST;
 		goto out;
 	}
 	if (adm_ctx.volume > DRBD_VOLUME_MAX) {
-		drbd_msg_put_info("requested volume id out of range");
+		drbd_msg_put_info(adm_ctx.reply_skb, "requested volume id out of range");
 		retcode = ERR_INVALID_REQUEST;
 		goto out;
 	}
@@ -3367,9 +3363,9 @@ int drbd_adm_new_minor(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	retcode = drbd_create_device(adm_ctx.resource, dh->minor, adm_ctx.volume);
+	retcode = drbd_create_device(&adm_ctx, dh->minor);
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
@@ -3390,9 +3386,10 @@ static enum drbd_ret_code adm_del_minor(struct drbd_device *device)
 
 int drbd_adm_del_minor(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	enum drbd_ret_code retcode;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_MINOR);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -3400,19 +3397,20 @@ int drbd_adm_del_minor(struct sk_buff *skb, struct genl_info *info)
 
 	retcode = adm_del_minor(adm_ctx.device);
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
 int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	struct drbd_resource *resource;
 	struct drbd_connection *connection;
 	struct drbd_device *device;
 	int retcode; /* enum drbd_ret_code rsp. enum drbd_state_rv */
 	unsigned i;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_RESOURCE);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_RESOURCE);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -3426,14 +3424,14 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 		idr_for_each_entry(&connection->peer_devices, peer_device, i) {
 			retcode = drbd_set_role(peer_device->device, R_SECONDARY, 0);
 			if (retcode < SS_SUCCESS) {
-				drbd_msg_put_info("failed to demote");
+				drbd_msg_put_info(adm_ctx.reply_skb, "failed to demote");
 				goto out;
 			}
 		}
 
 		retcode = conn_try_disconnect(connection, 0);
 		if (retcode < SS_SUCCESS) {
-			drbd_msg_put_info("failed to disconnect");
+			drbd_msg_put_info(adm_ctx.reply_skb, "failed to disconnect");
 			goto out;
 		}
 	}
@@ -3442,7 +3440,7 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 	idr_for_each_entry(&resource->devices, device, i) {
 		retcode = adm_detach(device, 0);
 		if (retcode < SS_SUCCESS || retcode > NO_ERROR) {
-			drbd_msg_put_info("failed to detach");
+			drbd_msg_put_info(adm_ctx.reply_skb, "failed to detach");
 			goto out;
 		}
 	}
@@ -3460,7 +3458,7 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 		retcode = adm_del_minor(device);
 		if (retcode != NO_ERROR) {
 			/* "can not happen" */
-			drbd_msg_put_info("failed to delete volume");
+			drbd_msg_put_info(adm_ctx.reply_skb, "failed to delete volume");
 			goto out;
 		}
 	}
@@ -3471,17 +3469,18 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 	retcode = NO_ERROR;
 
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
 int drbd_adm_del_resource(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drbd_config_context adm_ctx;
 	struct drbd_resource *resource;
 	struct drbd_connection *connection;
 	enum drbd_ret_code retcode;
 
-	retcode = drbd_adm_prepare(skb, info, DRBD_ADM_NEED_RESOURCE);
+	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_RESOURCE);
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
@@ -3506,7 +3505,7 @@ int drbd_adm_del_resource(struct sk_buff *skb, struct genl_info *info)
 	drbd_free_resource(resource);
 	retcode = NO_ERROR;
 out:
-	drbd_adm_finish(info, retcode);
+	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
 }
 
-- 
1.9.1

