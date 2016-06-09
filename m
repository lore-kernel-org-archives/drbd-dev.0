Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 093AE1056457
	for <drbd-dev@lists.linbit.com>; Thu,  9 Jun 2016 16:40:15 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Thu,  9 Jun 2016 22:39:48 +0800
Message-Id: <1465483189-22696-3-git-send-email-nwang@suse.com>
In-Reply-To: <1465483189-22696-1-git-send-email-nwang@suse.com>
References: <1465483189-22696-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [PATCH-drbd9 2/2] compat: nla_put_u64() is removed
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

In v4.7(50225243), nla_put_u64() is not used anymore,
should use nla_put_u64_64bit() instead.

Signed-off-by: Nick Wang <nwang@suse.com>

CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
---
 tests/have_aligned_nla_u64_pad.c | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 tests/have_aligned_nla_u64_pad.c

diff --git a/tests/have_aligned_nla_u64_pad.c b/tests/have_aligned_nla_u64_pad.c
new file mode 100644
index 0000000..c345969
--- /dev/null
+++ b/tests/have_aligned_nla_u64_pad.c
@@ -0,0 +1,6 @@
+#include <net/netlink.h>
+
+void foo(void)
+{
+	nla_put_u64(NULL, 0, 0);
+}
-- 
1.8.5.6

