Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
	[209.85.128.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BEF824252BE
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 14:43:19 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
	a11-20020a05600c2d4b00b003cf6f5fd9f1so11317706wmg.2
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 05:43:19 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 22 Nov 2022 14:43:01 +0100
Message-Id: <20221122134301.69258-5-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
References: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 4/4] drbd: use consistent license
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

DRBD currently has a mix of GPL-2.0 and GPL-2.0-or-later SPDX license
identifiers. We have decided to stick with GPL 2.0 only, so consistently
use that identifier.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig             | 2 +-
 drivers/block/drbd/Makefile            | 2 +-
 drivers/block/drbd/drbd_actlog.c       | 2 +-
 drivers/block/drbd/drbd_bitmap.c       | 2 +-
 drivers/block/drbd/drbd_debugfs.c      | 2 +-
 drivers/block/drbd/drbd_debugfs.h      | 2 +-
 drivers/block/drbd/drbd_int.h          | 2 +-
 drivers/block/drbd/drbd_interval.c     | 2 +-
 drivers/block/drbd/drbd_interval.h     | 2 +-
 drivers/block/drbd/drbd_main.c         | 2 +-
 drivers/block/drbd/drbd_nl.c           | 2 +-
 drivers/block/drbd/drbd_nla.c          | 2 +-
 drivers/block/drbd/drbd_nla.h          | 2 +-
 drivers/block/drbd/drbd_proc.c         | 2 +-
 drivers/block/drbd/drbd_protocol.h     | 2 +-
 drivers/block/drbd/drbd_receiver.c     | 2 +-
 drivers/block/drbd/drbd_req.c          | 2 +-
 drivers/block/drbd/drbd_req.h          | 2 +-
 drivers/block/drbd/drbd_state.c        | 2 +-
 drivers/block/drbd/drbd_state.h        | 2 +-
 drivers/block/drbd/drbd_state_change.h | 2 +-
 drivers/block/drbd/drbd_strings.c      | 2 +-
 drivers/block/drbd/drbd_strings.h      | 2 +-
 drivers/block/drbd/drbd_vli.h          | 2 +-
 drivers/block/drbd/drbd_worker.c       | 2 +-
 25 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index cbacddc55a1d..6fb4e38fca88 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 #
 # DRBD device driver configuration
 #
diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 8bd534697d1b..c93e462130ff 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 drbd-y := drbd_bitmap.o drbd_proc.o
 drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index e27478ae579c..5db147f3c02d 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
    drbd_actlog.c
 
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 7d9db33363de..b90a5c1003fc 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
    drbd_bitmap.c
 
diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index b3b9cd5628fd..a72c096aa5b1 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 #define pr_fmt(fmt) "drbd debugfs: " fmt
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/block/drbd/drbd_debugfs.h b/drivers/block/drbd/drbd_debugfs.h
index 58e31cef0844..ee3d66eb40c6 100644
--- a/drivers/block/drbd/drbd_debugfs.h
+++ b/drivers/block/drbd/drbd_debugfs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/debugfs.h>
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 4d661282ff41..470f4bf7264e 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
   drbd_int.h
 
diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index f07b4378388b..5024ffd6143d 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 #include <asm/bug.h>
 #include <linux/rbtree_augmented.h>
 #include "drbd_interval.h"
diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd_interval.h
index b8c2dee5edc8..366489b72fe9 100644
--- a/drivers/block/drbd/drbd_interval.h
+++ b/drivers/block/drbd/drbd_interval.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef __DRBD_INTERVAL_H
 #define __DRBD_INTERVAL_H
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 8532b839a343..ea53a9ca9a8b 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
    drbd.c
 
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 864c98e74875..7cd00aaf6eb1 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
    drbd_nl.c
 
diff --git a/drivers/block/drbd/drbd_nla.c b/drivers/block/drbd/drbd_nla.c
index 6a09b0b98018..df0d241d3f6a 100644
--- a/drivers/block/drbd/drbd_nla.c
+++ b/drivers/block/drbd/drbd_nla.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/kernel.h>
 #include <net/netlink.h>
 #include <linux/drbd_genl_api.h>
diff --git a/drivers/block/drbd/drbd_nla.h b/drivers/block/drbd/drbd_nla.h
index f5eaffb6474e..d3555df0d353 100644
--- a/drivers/block/drbd/drbd_nla.h
+++ b/drivers/block/drbd/drbd_nla.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef __DRBD_NLA_H
 #define __DRBD_NLA_H
 
diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 3c0193de2498..2227fb0db1ce 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
    drbd_proc.c
 
diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index a882b65ab5d2..56bbca9d7700 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef __DRBD_PROTOCOL_H
 #define __DRBD_PROTOCOL_H
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index ee69d50ba4fd..34aba9df7cb4 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
    drbd_receiver.c
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 7f9bcc82fc9c..ced15557197a 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
    drbd_req.c
 
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index 6237fa1dcb0e..b4017b5c3fbc 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
    drbd_req.h
 
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 3f7bf9f2d874..75d13ea0024f 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
    drbd_state.c
 
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index f87371e55e68..cbaeb8018dbf 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef DRBD_STATE_H
 #define DRBD_STATE_H
 
diff --git a/drivers/block/drbd/drbd_state_change.h b/drivers/block/drbd/drbd_state_change.h
index d5b0479bc9a6..9d78d8e3912e 100644
--- a/drivers/block/drbd/drbd_state_change.h
+++ b/drivers/block/drbd/drbd_state_change.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef DRBD_STATE_CHANGE_H
 #define DRBD_STATE_CHANGE_H
 
diff --git a/drivers/block/drbd/drbd_strings.c b/drivers/block/drbd/drbd_strings.c
index fc01307607ea..0a06f744b096 100644
--- a/drivers/block/drbd/drbd_strings.c
+++ b/drivers/block/drbd/drbd_strings.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
   drbd.h
 
diff --git a/drivers/block/drbd/drbd_strings.h b/drivers/block/drbd/drbd_strings.h
index 87b94a27358a..0201f6590f6a 100644
--- a/drivers/block/drbd/drbd_strings.h
+++ b/drivers/block/drbd/drbd_strings.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef __DRBD_STRINGS_H
 #define __DRBD_STRINGS_H
 
diff --git a/drivers/block/drbd/drbd_vli.h b/drivers/block/drbd/drbd_vli.h
index 01e3babc5277..1ee81e3c2152 100644
--- a/drivers/block/drbd/drbd_vli.h
+++ b/drivers/block/drbd/drbd_vli.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
 -*- linux-c -*-
    drbd_receiver.c
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 0bb1a900c2d5..e878fb5f5cc9 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
    drbd_worker.c
 
-- 
2.38.1

