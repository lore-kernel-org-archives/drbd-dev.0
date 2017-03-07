Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (prv3-mh.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 213DD1056493
	for <drbd-dev@lists.linbit.com>; Tue,  7 Mar 2017 04:28:45 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Tue,  7 Mar 2017 11:27:57 +0800
Message-Id: <1488857279-29079-7-git-send-email-nwang@suse.com>
In-Reply-To: <1488857279-29079-1-git-send-email-nwang@suse.com>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [Patch v0 6/6] Statically initialize families
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

In a07ea4d9, genetlink no longer use static family id.
GENL_ID_GENERATE is removed.
In 489111e5, statically initialize the families and remove
the inline functions.

This is for drbd-kernel-compat

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com 

---
 tests/have_genl_family_in_genlmsg_multicast.c | 9 +++++++++
 tests/have_genl_id_generate.c                 | 6 ++++++
 2 files changed, 15 insertions(+)
 create mode 100644 tests/have_genl_family_in_genlmsg_multicast.c
 create mode 100644 tests/have_genl_id_generate.c

diff --git a/tests/have_genl_family_in_genlmsg_multicast.c b/tests/have_genl_family_in_genlmsg_multicast.c
new file mode 100644
index 0000000..6d44faa
--- /dev/null
+++ b/tests/have_genl_family_in_genlmsg_multicast.c
@@ -0,0 +1,9 @@
+#include <net/genetlink.h>
+
+void test(void)
+{
+	struct genl_family family = { };
+	struct sk_buff *skb = NULL;
+
+	genlmsg_multicast(&family, skb, 0, 0, GFP_KERNEL);
+}
diff --git a/tests/have_genl_id_generate.c b/tests/have_genl_id_generate.c
new file mode 100644
index 0000000..4ef0e8e
--- /dev/null
+++ b/tests/have_genl_id_generate.c
@@ -0,0 +1,6 @@
+#include <linux/genetlink.h>
+
+void test(void)
+{
+	int i = GENL_ID_GENERATE;
+}
-- 
1.8.5.6

