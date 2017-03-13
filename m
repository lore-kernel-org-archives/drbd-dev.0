Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D0C001056486
	for <drbd-dev@lists.linbit.com>; Mon, 13 Mar 2017 08:23:58 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 13 Mar 2017 15:23:25 +0800
Message-Id: <1489389811-31234-3-git-send-email-nwang@suse.com>
In-Reply-To: <1489389811-31234-1-git-send-email-nwang@suse.com>
References: <1489389811-31234-1-git-send-email-nwang@suse.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: [Drbd-dev] [Patch v1 2/8] Adapt pointer backing_dev_info in struct
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

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: Roland Kammerer <roland.kammerer@linbit.com>
CC: drbd-dev@lists.linbit.com 
---
 tests/have_pointer_backing_dev_info.c | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 tests/have_pointer_backing_dev_info.c

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

