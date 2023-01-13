Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
	[209.85.218.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 803694205B8
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 13:35:21 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id fy8so51881229ejc.13
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 04:35:21 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri, 13 Jan 2023 13:35:06 +0100
Message-Id: <20230113123506.144082-4-christoph.boehmwalder@linbit.com>
In-Reply-To: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
References: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/3] drbd: split off drbd_config into separate
	file
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

To be more similar to what we do in the out-of-tree module and ease the
upstreaming process.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/drbd_buildtag.c |  2 +-
 drivers/block/drbd/drbd_int.h      |  1 +
 include/linux/drbd.h               |  6 ------
 include/linux/drbd_config.h        | 16 ++++++++++++++++
 4 files changed, 18 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/drbd_config.h

diff --git a/drivers/block/drbd/drbd_buildtag.c b/drivers/block/drbd/drbd_buildtag.c
index 956a4d5c339b..cb1aa66d7d5d 100644
--- a/drivers/block/drbd/drbd_buildtag.c
+++ b/drivers/block/drbd/drbd_buildtag.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/drbd.h>
+#include <linux/drbd_config.h>
 #include <linux/module.h>
 
 const char *drbd_buildtag(void)
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index edce1f7ac2da..d89b7d03d4c8 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -34,6 +34,7 @@
 #include <linux/prefetch.h>
 #include <linux/drbd_genl_api.h>
 #include <linux/drbd.h>
+#include <linux/drbd_config.h>
 #include "drbd_strings.h"
 #include "drbd_state.h"
 #include "drbd_protocol.h"
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index df65a8f5228a..5468a2399d48 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -38,12 +38,6 @@
 
 #endif
 
-extern const char *drbd_buildtag(void);
-#define REL_VERSION "8.4.11"
-#define PRO_VERSION_MIN 86
-#define PRO_VERSION_MAX 101
-
-
 enum drbd_io_error_p {
 	EP_PASS_ON, /* FIXME should the better be named "Ignore"? */
 	EP_CALL_HELPER,
diff --git a/include/linux/drbd_config.h b/include/linux/drbd_config.h
new file mode 100644
index 000000000000..d215365c6bb1
--- /dev/null
+++ b/include/linux/drbd_config.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * drbd_config.h
+ * DRBD's compile time configuration.
+ */
+
+#ifndef DRBD_CONFIG_H
+#define DRBD_CONFIG_H
+
+extern const char *drbd_buildtag(void);
+
+#define REL_VERSION "8.4.11"
+#define PRO_VERSION_MIN 86
+#define PRO_VERSION_MAX 101
+
+#endif
-- 
2.38.1

