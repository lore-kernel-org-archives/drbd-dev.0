Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
	[209.85.218.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E761C421740
	for <drbd-dev@lists.linbit.com>; Thu,  1 Dec 2022 12:04:37 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id n21so3289217ejb.9
	for <drbd-dev@lists.linbit.com>; Thu, 01 Dec 2022 03:04:37 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  1 Dec 2022 12:03:47 +0100
Message-Id: <20221201110349.1282687-3-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
References: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/5] drbd: split polymorph printk to its own file
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

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h              | 68 +-------------------
 drivers/block/drbd/drbd_polymorph_printk.h | 72 ++++++++++++++++++++++
 2 files changed, 73 insertions(+), 67 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_polymorph_printk.h

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ea92df778c66..1734a7f8a096 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -37,6 +37,7 @@
 #include "drbd_strings.h"
 #include "drbd_state.h"
 #include "drbd_protocol.h"
+#include "drbd_polymorph_printk.h"
 
 #ifdef __CHECKER__
 # define __protected_by(x)       __attribute__((require_context(x,1,999,"rdwr")))
@@ -75,73 +76,6 @@ extern int drbd_proc_details;
 struct drbd_device;
 struct drbd_connection;
 
-#define __drbd_printk_device(level, device, fmt, args...) \
-	dev_printk(level, disk_to_dev((device)->vdisk), fmt, ## args)
-#define __drbd_printk_peer_device(level, peer_device, fmt, args...) \
-	dev_printk(level, disk_to_dev((peer_device)->device->vdisk), fmt, ## args)
-#define __drbd_printk_resource(level, resource, fmt, args...) \
-	printk(level "drbd %s: " fmt, (resource)->name, ## args)
-#define __drbd_printk_connection(level, connection, fmt, args...) \
-	printk(level "drbd %s: " fmt, (connection)->resource->name, ## args)
-
-void drbd_printk_with_wrong_object_type(void);
-
-#define __drbd_printk_if_same_type(obj, type, func, level, fmt, args...) \
-	(__builtin_types_compatible_p(typeof(obj), type) || \
-	 __builtin_types_compatible_p(typeof(obj), const type)), \
-	func(level, (const type)(obj), fmt, ## args)
-
-#define drbd_printk(level, obj, fmt, args...) \
-	__builtin_choose_expr( \
-	  __drbd_printk_if_same_type(obj, struct drbd_device *, \
-			     __drbd_printk_device, level, fmt, ## args), \
-	  __builtin_choose_expr( \
-	    __drbd_printk_if_same_type(obj, struct drbd_resource *, \
-			       __drbd_printk_resource, level, fmt, ## args), \
-	    __builtin_choose_expr( \
-	      __drbd_printk_if_same_type(obj, struct drbd_connection *, \
-				 __drbd_printk_connection, level, fmt, ## args), \
-	      __builtin_choose_expr( \
-		__drbd_printk_if_same_type(obj, struct drbd_peer_device *, \
-				 __drbd_printk_peer_device, level, fmt, ## args), \
-		drbd_printk_with_wrong_object_type()))))
-
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
-
-#define D_ASSERT(x, exp)							\
-	do {									\
-		if (!(exp))							\
-			drbd_err(x, "ASSERTION %s FAILED in %s\n",		\
-				 #exp, __func__);				\
-	} while (0)
-
-/**
- * expect  -  Make an assertion
- *
- * Unlike the assert macro, this macro returns a boolean result.
- */
-#define expect(exp) ({								\
-		bool _bool = (exp);						\
-		if (!_bool)							\
-			drbd_err(device, "ASSERTION %s FAILED in %s\n",		\
-			        #exp, __func__);				\
-		_bool;								\
-		})
-
 /* Defines to control fault insertion */
 enum {
 	DRBD_FAULT_MD_WR = 0,	/* meta data write */
diff --git a/drivers/block/drbd/drbd_polymorph_printk.h b/drivers/block/drbd/drbd_polymorph_printk.h
new file mode 100644
index 000000000000..13cc1b311e16
--- /dev/null
+++ b/drivers/block/drbd/drbd_polymorph_printk.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DRBD_POLYMORPH_PRINTK_H
+#define DRBD_POLYMORPH_PRINTK_H
+
+#define __drbd_printk_device(level, device, fmt, args...) \
+	dev_printk(level, disk_to_dev((device)->vdisk), fmt, ## args)
+#define __drbd_printk_peer_device(level, peer_device, fmt, args...) \
+	dev_printk(level, disk_to_dev((peer_device)->device->vdisk), fmt, ## args)
+#define __drbd_printk_resource(level, resource, fmt, args...) \
+	printk(level "drbd %s: " fmt, (resource)->name, ## args)
+#define __drbd_printk_connection(level, connection, fmt, args...) \
+	printk(level "drbd %s: " fmt, (connection)->resource->name, ## args)
+
+void drbd_printk_with_wrong_object_type(void);
+
+#define __drbd_printk_if_same_type(obj, type, func, level, fmt, args...) \
+	(__builtin_types_compatible_p(typeof(obj), type) || \
+	 __builtin_types_compatible_p(typeof(obj), const type)), \
+	func(level, (const type)(obj), fmt, ## args)
+
+#define drbd_printk(level, obj, fmt, args...) \
+	__builtin_choose_expr( \
+	  __drbd_printk_if_same_type(obj, struct drbd_device *, \
+			     __drbd_printk_device, level, fmt, ## args), \
+	  __builtin_choose_expr( \
+	    __drbd_printk_if_same_type(obj, struct drbd_resource *, \
+			       __drbd_printk_resource, level, fmt, ## args), \
+	    __builtin_choose_expr( \
+	      __drbd_printk_if_same_type(obj, struct drbd_connection *, \
+				 __drbd_printk_connection, level, fmt, ## args), \
+	      __builtin_choose_expr( \
+		__drbd_printk_if_same_type(obj, struct drbd_peer_device *, \
+				 __drbd_printk_peer_device, level, fmt, ## args), \
+		drbd_printk_with_wrong_object_type()))))
+
+#define drbd_dbg(obj, fmt, args...) \
+	drbd_printk(KERN_DEBUG, obj, fmt, ## args)
+#define drbd_alert(obj, fmt, args...) \
+	drbd_printk(KERN_ALERT, obj, fmt, ## args)
+#define drbd_err(obj, fmt, args...) \
+	drbd_printk(KERN_ERR, obj, fmt, ## args)
+#define drbd_warn(obj, fmt, args...) \
+	drbd_printk(KERN_WARNING, obj, fmt, ## args)
+#define drbd_info(obj, fmt, args...) \
+	drbd_printk(KERN_INFO, obj, fmt, ## args)
+#define drbd_emerg(obj, fmt, args...) \
+	drbd_printk(KERN_EMERG, obj, fmt, ## args)
+
+#define dynamic_drbd_dbg(device, fmt, args...) \
+	dynamic_dev_dbg(disk_to_dev(device->vdisk), fmt, ## args)
+
+#define D_ASSERT(x, exp)							\
+	do {									\
+		if (!(exp))							\
+			drbd_err(x, "ASSERTION %s FAILED in %s\n",		\
+				#exp, __func__);				\
+	} while (0)
+
+/**
+ * expect  -  Make an assertion
+ *
+ * Unlike the assert macro, this macro returns a boolean result.
+ */
+#define expect(exp) ({								\
+		bool _bool = (exp);						\
+		if (!_bool)							\
+			drbd_err(device, "ASSERTION %s FAILED in %s\n",		\
+			        #exp, __func__);				\
+		_bool;								\
+		})
+
+#endif
-- 
2.38.1

