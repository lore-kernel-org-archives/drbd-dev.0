Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
	[209.85.208.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1386442096B
	for <drbd-dev@lists.linbit.com>; Fri,  9 Dec 2022 15:55:07 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id z92so3431855ede.1
	for <drbd-dev@lists.linbit.com>; Fri, 09 Dec 2022 06:55:07 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri,  9 Dec 2022 15:55:02 +0100
Message-Id: <20221209145504.2273072-2-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
References: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/3] drbd: split off drbd_buildtag into separate
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
 drivers/block/drbd/Makefile        |  2 +-
 drivers/block/drbd/drbd_buildtag.c | 22 ++++++++++++++++++++++
 drivers/block/drbd/drbd_main.c     | 18 ------------------
 3 files changed, 23 insertions(+), 19 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_buildtag.c

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index c93e462130ff..67a8b352a1d5 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-drbd-y := drbd_bitmap.o drbd_proc.o
+drbd-y := drbd_buildtag.o drbd_bitmap.o drbd_proc.o
 drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
diff --git a/drivers/block/drbd/drbd_buildtag.c b/drivers/block/drbd/drbd_buildtag.c
new file mode 100644
index 000000000000..956a4d5c339b
--- /dev/null
+++ b/drivers/block/drbd/drbd_buildtag.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/drbd.h>
+#include <linux/module.h>
+
+const char *drbd_buildtag(void)
+{
+	/* DRBD built from external sources has here a reference to the
+	 * git hash of the source code.
+	 */
+
+	static char buildtag[38] = "\0uilt-in";
+
+	if (buildtag[0] == 0) {
+#ifdef MODULE
+		sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
+#else
+		buildtag[0] = 'b';
+#endif
+	}
+
+	return buildtag;
+}
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 7213ffd69a16..345bfac441da 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3776,24 +3776,6 @@ _drbd_insert_fault(struct drbd_device *device, unsigned int type)
 }
 #endif
 
-const char *drbd_buildtag(void)
-{
-	/* DRBD built from external sources has here a reference to the
-	   git hash of the source code. */
-
-	static char buildtag[38] = "\0uilt-in";
-
-	if (buildtag[0] == 0) {
-#ifdef MODULE
-		sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
-#else
-		buildtag[0] = 'b';
-#endif
-	}
-
-	return buildtag;
-}
-
 module_init(drbd_init)
 module_exit(drbd_cleanup)
 
-- 
2.38.1

