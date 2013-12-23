Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 39B4D105B0D0
	for <drbd-dev@lists.linbit.com>; Mon, 23 Dec 2013 22:50:58 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 23 Dec 2013 22:50:44 +0100
Message-Id: <1387835456-29695-16-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
References: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 15/27] drbd: Move string function prototypes from
	linux/drbd.h to drbd_string.h
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

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_int.h     |    1 +
 drivers/block/drbd/drbd_strings.c |    1 +
 drivers/block/drbd/drbd_strings.h |    9 +++++++++
 include/linux/drbd.h              |    6 ------
 4 files changed, 11 insertions(+), 6 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_strings.h

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ef4c621..2b0fdfd 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -45,6 +45,7 @@
 #include <linux/prefetch.h>
 #include <linux/drbd_genl_api.h>
 #include <linux/drbd.h>
+#include "drbd_strings.h"
 #include "drbd_state.h"
 #include "drbd_protocol.h"
 
diff --git a/drivers/block/drbd/drbd_strings.c b/drivers/block/drbd/drbd_strings.c
index 58e08ff..80b0f63 100644
--- a/drivers/block/drbd/drbd_strings.c
+++ b/drivers/block/drbd/drbd_strings.c
@@ -24,6 +24,7 @@
 */
 
 #include <linux/drbd.h>
+#include "drbd_strings.h"
 
 static const char *drbd_conn_s_names[] = {
 	[C_STANDALONE]       = "StandAlone",
diff --git a/drivers/block/drbd/drbd_strings.h b/drivers/block/drbd/drbd_strings.h
new file mode 100644
index 0000000..f9923cc
--- /dev/null
+++ b/drivers/block/drbd/drbd_strings.h
@@ -0,0 +1,9 @@
+#ifndef __DRBD_STRINGS_H
+#define __DRBD_STRINGS_H
+
+extern const char *drbd_conn_str(enum drbd_conns);
+extern const char *drbd_role_str(enum drbd_role);
+extern const char *drbd_disk_str(enum drbd_disk_state);
+extern const char *drbd_set_st_err_str(enum drbd_state_rv);
+
+#endif  /* __DRBD_STRINGS_H */
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 6f60136..3dbe9bd 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -327,12 +327,6 @@ enum drbd_state_rv {
 	SS_AFTER_LAST_ERROR = -22,    /* Keep this at bottom */
 };
 
-/* from drbd_strings.c */
-extern const char *drbd_conn_str(enum drbd_conns);
-extern const char *drbd_role_str(enum drbd_role);
-extern const char *drbd_disk_str(enum drbd_disk_state);
-extern const char *drbd_set_st_err_str(enum drbd_state_rv);
-
 #define SHARED_SECRET_MAX 64
 
 #define MDF_CONSISTENT		(1 << 0)
-- 
1.7.9.5

