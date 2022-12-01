Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
	[209.85.218.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7D08C42177A
	for <drbd-dev@lists.linbit.com>; Thu,  1 Dec 2022 12:04:44 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id ha10so3345431ejb.3
	for <drbd-dev@lists.linbit.com>; Thu, 01 Dec 2022 03:04:44 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  1 Dec 2022 12:03:48 +0100
Message-Id: <20221201110349.1282687-4-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
References: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/5] drbd: introduce dynamic debug
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Incorporate as many out-of-tree changes as possible without changing the
genl API.

Over the years, we restructured this several times, and also changed the
log format.

One breaking change is that DRBD 9 gained "implicit options", like a
connection name. This cannot be replayed here without changing the API,
so save it for later.

Originally-from: Andreas Gruenbacher <agruen@linbit.com>
Originally-from: Philipp Reisner <philipp.reisner@linbit.com>
Originally-from: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_polymorph_printk.h | 133 +++++++++++++++------
 1 file changed, 97 insertions(+), 36 deletions(-)

diff --git a/drivers/block/drbd/drbd_polymorph_printk.h b/drivers/block/drbd/drbd_polymorph_printk.h
index 13cc1b311e16..46cda9dd9af8 100644
--- a/drivers/block/drbd/drbd_polymorph_printk.h
+++ b/drivers/block/drbd/drbd_polymorph_printk.h
@@ -2,52 +2,113 @@
 #ifndef DRBD_POLYMORPH_PRINTK_H
 #define DRBD_POLYMORPH_PRINTK_H
 
-#define __drbd_printk_device(level, device, fmt, args...) \
-	dev_printk(level, disk_to_dev((device)->vdisk), fmt, ## args)
-#define __drbd_printk_peer_device(level, peer_device, fmt, args...) \
-	dev_printk(level, disk_to_dev((peer_device)->device->vdisk), fmt, ## args)
-#define __drbd_printk_resource(level, resource, fmt, args...) \
-	printk(level "drbd %s: " fmt, (resource)->name, ## args)
-#define __drbd_printk_connection(level, connection, fmt, args...) \
-	printk(level "drbd %s: " fmt, (connection)->resource->name, ## args)
+#if !defined(CONFIG_DYNAMIC_DEBUG)
+#undef DEFINE_DYNAMIC_DEBUG_METADATA
+#undef __dynamic_pr_debug
+#undef DYNAMIC_DEBUG_BRANCH
+#define DEFINE_DYNAMIC_DEBUG_METADATA(D, F) const char *D = F; ((void)D)
+#define __dynamic_pr_debug(D, F, args...) do { (void)(D); if (0) printk(F, ## args); } while (0)
+#define DYNAMIC_DEBUG_BRANCH(D) false
+#endif
+
+
+#define __drbd_printk_drbd_device_prep(device)			\
+	const struct drbd_device *__d = (device);		\
+	const struct drbd_resource *__r = __d->resource
+#define __drbd_printk_drbd_device_fmt(fmt)	"drbd %s/%u drbd%u: " fmt
+#define __drbd_printk_drbd_device_args()	__r->name, __d->vnr, __d->minor
+#define __drbd_printk_drbd_device_unprep()
+
+#define __drbd_printk_drbd_peer_device_prep(peer_device)	\
+	const struct drbd_device *__d;				\
+	const struct drbd_resource *__r;			\
+	__d = (peer_device)->device;				\
+	__r = __d->resource
+#define __drbd_printk_drbd_peer_device_fmt(fmt) \
+	"drbd %s/%u drbd%u: " fmt
+#define __drbd_printk_drbd_peer_device_args() \
+	__r->name, __d->vnr, __d->minor
+#define __drbd_printk_drbd_peer_device_unprep()
+
+#define __drbd_printk_drbd_resource_prep(resource) \
+	const struct drbd_resource *__r = resource
+#define __drbd_printk_drbd_resource_fmt(fmt) "drbd %s: " fmt
+#define __drbd_printk_drbd_resource_args()	__r->name
+#define __drbd_printk_drbd_resource_unprep(resource)
+
+#define __drbd_printk_drbd_connection_prep(connection)		\
+	const struct drbd_connection *__c = (connection);	\
+	const struct drbd_resource *__r = __c->resource
+#define __drbd_printk_drbd_connection_fmt(fmt)			\
+	"drbd %s: " fmt
+#define __drbd_printk_drbd_connection_args()			\
+	__r->name
+#define __drbd_printk_drbd_connection_unprep()
 
 void drbd_printk_with_wrong_object_type(void);
+void drbd_dyn_dbg_with_wrong_object_type(void);
 
-#define __drbd_printk_if_same_type(obj, type, func, level, fmt, args...) \
-	(__builtin_types_compatible_p(typeof(obj), type) || \
-	 __builtin_types_compatible_p(typeof(obj), const type)), \
-	func(level, (const type)(obj), fmt, ## args)
+#define __drbd_printk_choose_cond(obj, struct_name) \
+	(__builtin_types_compatible_p(typeof(obj), struct struct_name *) || \
+	 __builtin_types_compatible_p(typeof(obj), const struct struct_name *))
+#define __drbd_printk_if_same_type(obj, struct_name, level, fmt, args...) \
+	__drbd_printk_choose_cond(obj, struct_name), \
+({ \
+	__drbd_printk_ ## struct_name ## _prep((const struct struct_name *)(obj)); \
+	printk(level __drbd_printk_ ## struct_name ## _fmt(fmt), \
+		__drbd_printk_ ## struct_name ## _args(), ## args); \
+	__drbd_printk_ ## struct_name ## _unprep(); \
+})
 
 #define drbd_printk(level, obj, fmt, args...) \
 	__builtin_choose_expr( \
-	  __drbd_printk_if_same_type(obj, struct drbd_device *, \
-			     __drbd_printk_device, level, fmt, ## args), \
+	  __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
 	  __builtin_choose_expr( \
-	    __drbd_printk_if_same_type(obj, struct drbd_resource *, \
-			       __drbd_printk_resource, level, fmt, ## args), \
+	    __drbd_printk_if_same_type(obj, drbd_resource, level, fmt, ## args), \
 	    __builtin_choose_expr( \
-	      __drbd_printk_if_same_type(obj, struct drbd_connection *, \
-				 __drbd_printk_connection, level, fmt, ## args), \
+	      __drbd_printk_if_same_type(obj, drbd_connection, level, fmt, ## args), \
 	      __builtin_choose_expr( \
-		__drbd_printk_if_same_type(obj, struct drbd_peer_device *, \
-				 __drbd_printk_peer_device, level, fmt, ## args), \
+		__drbd_printk_if_same_type(obj, drbd_peer_device, level, fmt, ## args), \
 		drbd_printk_with_wrong_object_type()))))
 
-#define drbd_dbg(obj, fmt, args...) \
-	drbd_printk(KERN_DEBUG, obj, fmt, ## args)
-#define drbd_alert(obj, fmt, args...) \
-	drbd_printk(KERN_ALERT, obj, fmt, ## args)
-#define drbd_err(obj, fmt, args...) \
-	drbd_printk(KERN_ERR, obj, fmt, ## args)
-#define drbd_warn(obj, fmt, args...) \
-	drbd_printk(KERN_WARNING, obj, fmt, ## args)
-#define drbd_info(obj, fmt, args...) \
-	drbd_printk(KERN_INFO, obj, fmt, ## args)
-#define drbd_emerg(obj, fmt, args...) \
-	drbd_printk(KERN_EMERG, obj, fmt, ## args)
-
-#define dynamic_drbd_dbg(device, fmt, args...) \
-	dynamic_dev_dbg(disk_to_dev(device->vdisk), fmt, ## args)
+#define __drbd_dyn_dbg_if_same_type(obj, struct_name, fmt, args...) \
+	__drbd_printk_choose_cond(obj, struct_name), \
+({ \
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {			\
+		__drbd_printk_ ## struct_name ## _prep((const struct struct_name *)(obj)); \
+		__dynamic_pr_debug(&descriptor, __drbd_printk_ ## struct_name ## _fmt(fmt), \
+			__drbd_printk_ ## struct_name ## _args(), ## args); \
+		__drbd_printk_ ## struct_name ## _unprep();	\
+	}							\
+})
+
+#define dynamic_drbd_dbg(obj, fmt, args...) \
+	__builtin_choose_expr( \
+	  __drbd_dyn_dbg_if_same_type(obj, drbd_device, fmt, ## args), \
+	  __builtin_choose_expr( \
+	    __drbd_dyn_dbg_if_same_type(obj, drbd_resource, fmt, ## args), \
+	    __builtin_choose_expr( \
+	      __drbd_dyn_dbg_if_same_type(obj, drbd_connection, fmt, ## args), \
+	      __builtin_choose_expr( \
+		__drbd_dyn_dbg_if_same_type(obj, drbd_peer_device, fmt, ## args), \
+		drbd_dyn_dbg_with_wrong_object_type()))))
+
+#define drbd_emerg(device, fmt, args...) \
+	drbd_printk(KERN_EMERG, device, fmt, ## args)
+#define drbd_alert(device, fmt, args...) \
+	drbd_printk(KERN_ALERT, device, fmt, ## args)
+#define drbd_crit(device, fmt, args...) \
+	drbd_printk(KERN_CRIT, device, fmt, ## args)
+#define drbd_err(device, fmt, args...) \
+	drbd_printk(KERN_ERR, device, fmt, ## args)
+#define drbd_warn(device, fmt, args...) \
+	drbd_printk(KERN_WARNING, device, fmt, ## args)
+#define drbd_notice(device, fmt, args...) \
+	drbd_printk(KERN_NOTICE, device, fmt, ## args)
+#define drbd_info(device, fmt, args...) \
+	drbd_printk(KERN_INFO, device, fmt, ## args)
+
 
 #define D_ASSERT(x, exp)							\
 	do {									\
@@ -65,7 +126,7 @@ void drbd_printk_with_wrong_object_type(void);
 		bool _bool = (exp);						\
 		if (!_bool)							\
 			drbd_err(device, "ASSERTION %s FAILED in %s\n",		\
-			        #exp, __func__);				\
+				#exp, __func__);				\
 		_bool;								\
 		})
 
-- 
2.38.1

