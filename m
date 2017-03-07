Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2CBAC105648D
	for <drbd-dev@lists.linbit.com>; Tue,  7 Mar 2017 04:28:44 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Tue,  7 Mar 2017 11:27:55 +0800
Message-Id: <1488857279-29079-5-git-send-email-nwang@suse.com>
In-Reply-To: <1488857279-29079-1-git-send-email-nwang@suse.com>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [Patch v0 4/8] Use refcount_t 'atomic' type to implement
	struct kref
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

In 10383aea, atomic type for refcount is obsoleted, instead 
using refcount_t. Also convert the related call.

This patch is for drbd-kernel-compat

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com 

---
 tests/have_refcount_inc.c | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 tests/have_refcount_inc.c

diff --git a/tests/have_refcount_inc.c b/tests/have_refcount_inc.c
new file mode 100644
index 0000000..38373e7
--- /dev/null
+++ b/tests/have_refcount_inc.c
@@ -0,0 +1,6 @@
+#include <linux/refcount.h>
+
+void test(refcount_t *r)
+{
+	refcount_inc(r);
+}
-- 
1.8.5.6

