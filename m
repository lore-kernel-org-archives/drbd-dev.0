Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A1F131056484
	for <drbd-dev@lists.linbit.com>; Tue,  7 Mar 2017 04:28:28 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Tue,  7 Mar 2017 11:27:53 +0800
Message-Id: <1488857279-29079-3-git-send-email-nwang@suse.com>
In-Reply-To: <1488857279-29079-1-git-send-email-nwang@suse.com>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [Patch v0 2/8] Adapt pointer backing_dev_info in struct
	request_queue
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

In dc3b17cc, struct request_queue use pointer to backing_dev_info,
so all related call should be converted.

This patch is for drbd-kernel-compat

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com 

---
 drbd_wrappers.h                       | 5 +++++
 tests/have_pointer_backing_dev_info.c | 7 +++++++
 2 files changed, 12 insertions(+)
 create mode 100644 tests/have_pointer_backing_dev_info.c

diff --git a/drbd_wrappers.h b/drbd_wrappers.h
index 0489e7f..778a6fd 100644
--- a/drbd_wrappers.h
+++ b/drbd_wrappers.h
@@ -888,6 +888,11 @@ static inline void blk_queue_write_cache(struct request_queue *q, bool enabled,
 #endif
 #endif
 
+#ifdef COMPAT_HAVE_POINTER_BACKING_DEV_INFO
+#define bdi_rw_congested(B) bdi_rw_congested(*(B))
+#define bdi_congested(B, C) bdi_congested(*(B), C)
+#endif
+
 #ifndef REQ_NOIDLE
 /* introduced in aeb6faf (2.6.30), relevant for CFQ */
 #define REQ_NOIDLE 0
diff --git a/tests/have_pointer_backing_dev_info.c b/tests/have_pointer_backing_dev_info.c
new file mode 100644
index 0000000..e9999ce
--- /dev/null
+++ b/tests/have_pointer_backing_dev_info.c
@@ -0,0 +1,7 @@
+#include <linux/blkdev.h>
+
+void test(void)
+{
+	struct request_queue q = {};
+	q.backing_dev_info = NULL;
+}
-- 
1.8.5.6

