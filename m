Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
	[209.85.208.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0E0E44210CD
	for <drbd-dev@lists.linbit.com>; Fri,  9 Dec 2022 15:55:08 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id v8so3423349edi.3
	for <drbd-dev@lists.linbit.com>; Fri, 09 Dec 2022 06:55:08 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri,  9 Dec 2022 15:55:03 +0100
Message-Id: <20221209145504.2273072-3-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
References: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/3] drbd: drop API_VERSION define
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

Use the genetlink api version as defined in drbd_genl_api.h.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/drbd_debugfs.c | 2 +-
 drivers/block/drbd/drbd_main.c    | 2 +-
 drivers/block/drbd/drbd_proc.c    | 2 +-
 include/linux/drbd.h              | 1 -
 include/linux/drbd_genl_api.h     | 2 +-
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index a72c096aa5b1..12460b584bcb 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -844,7 +844,7 @@ static int drbd_version_show(struct seq_file *m, void *ignored)
 {
 	seq_printf(m, "# %s\n", drbd_buildtag());
 	seq_printf(m, "VERSION=%s\n", REL_VERSION);
-	seq_printf(m, "API_VERSION=%u\n", API_VERSION);
+	seq_printf(m, "API_VERSION=%u\n", GENL_MAGIC_VERSION);
 	seq_printf(m, "PRO_VERSION_MIN=%u\n", PRO_VERSION_MIN);
 	seq_printf(m, "PRO_VERSION_MAX=%u\n", PRO_VERSION_MAX);
 	return 0;
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 345bfac441da..5156d2fb2d76 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2899,7 +2899,7 @@ static int __init drbd_init(void)
 
 	pr_info("initialized. "
 	       "Version: " REL_VERSION " (api:%d/proto:%d-%d)\n",
-	       API_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX);
+	       GENL_MAGIC_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX);
 	pr_info("%s\n", drbd_buildtag());
 	pr_info("registered as block device major %d\n", DRBD_MAJOR);
 	return 0; /* Success! */
diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 2227fb0db1ce..1d0feafceadc 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -228,7 +228,7 @@ int drbd_seq_show(struct seq_file *seq, void *v)
 	};
 
 	seq_printf(seq, "version: " REL_VERSION " (api:%d/proto:%d-%d)\n%s\n",
-		   API_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX, drbd_buildtag());
+		   GENL_MAGIC_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX, drbd_buildtag());
 
 	/*
 	  cs .. connection state
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 5755537b51b1..df65a8f5228a 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -40,7 +40,6 @@
 
 extern const char *drbd_buildtag(void);
 #define REL_VERSION "8.4.11"
-#define API_VERSION 1
 #define PRO_VERSION_MIN 86
 #define PRO_VERSION_MAX 101
 
diff --git a/include/linux/drbd_genl_api.h b/include/linux/drbd_genl_api.h
index bd62efc29002..70682c058027 100644
--- a/include/linux/drbd_genl_api.h
+++ b/include/linux/drbd_genl_api.h
@@ -47,7 +47,7 @@ enum drbd_state_info_bcast_reason {
 #undef linux
 
 #include <linux/drbd.h>
-#define GENL_MAGIC_VERSION	API_VERSION
+#define GENL_MAGIC_VERSION	1
 #define GENL_MAGIC_FAMILY	drbd
 #define GENL_MAGIC_FAMILY_HDRSZ	sizeof(struct drbd_genlmsghdr)
 #define GENL_MAGIC_INCLUDE_FILE <linux/drbd_genl.h>
-- 
2.38.1

