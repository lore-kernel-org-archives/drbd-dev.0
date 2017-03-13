Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 283491056487
	for <drbd-dev@lists.linbit.com>; Mon, 13 Mar 2017 08:24:14 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 13 Mar 2017 15:23:27 +0800
Message-Id: <1489389811-31234-5-git-send-email-nwang@suse.com>
In-Reply-To: <1489389811-31234-1-git-send-email-nwang@suse.com>
References: <1489389811-31234-1-git-send-email-nwang@suse.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: [Drbd-dev] [Patch v1 4/8] Use refcount_t 'atomic' type to implement
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

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: Roland Kammerer <roland.kammerer@linbit.com>
CC: drbd-dev@lists.linbit.com 
---
 drbd_wrappers.h           | 5 +++++
 tests/have_refcount_inc.c | 6 ++++++
 2 files changed, 11 insertions(+)
 create mode 100644 tests/have_refcount_inc.c

diff --git a/drbd_wrappers.h b/drbd_wrappers.h
index 1e35aec..cf17d84 100644
--- a/drbd_wrappers.h
+++ b/drbd_wrappers.h
@@ -893,6 +893,11 @@ static inline void blk_queue_write_cache(struct request_queue *q, bool enabled,
 #define REQ_NOIDLE 0
 #endif
 
+#ifndef COMPAT_HAVE_REFCOUNT_INC
+#define refcount_inc(R) atomic_inc(R)
+#define refcount_read(R) atomic_read(R)
+#define refcount_dec_and_test(R) atomic_dec_and_test(R)
+#endif
 
 #ifndef COMPAT_HAVE_BIO_SET_OP_ATTRS /*compat for Linux before 4.8 {{{2 */
 
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

