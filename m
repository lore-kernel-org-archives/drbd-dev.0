Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (prv3-mh.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F1A151056497
	for <drbd-dev@lists.linbit.com>; Tue,  7 Mar 2017 04:29:01 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Tue,  7 Mar 2017 11:27:59 +0800
Message-Id: <1488857279-29079-9-git-send-email-nwang@suse.com>
In-Reply-To: <1488857279-29079-1-git-send-email-nwang@suse.com>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [Patch v0 8/8] Statically initialize families
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

This patch is for drbd-headers.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com 

---
 linux/genl_magic_func.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux/genl_magic_func.h b/linux/genl_magic_func.h
index d14a557..ae9b9de 100644
--- a/linux/genl_magic_func.h
+++ b/linux/genl_magic_func.h
@@ -251,7 +251,9 @@ static struct genl_ops ZZZ_genl_ops[] __read_mostly = {
  */
 #define ZZZ_genl_family		CONCAT_(GENL_MAGIC_FAMILY, _genl_family)
 static struct genl_family ZZZ_genl_family __read_mostly = {
+#ifdef HAVE_GENL_ID_GENERATE
 	.id = GENL_ID_GENERATE,
+#endif
 	.name = __stringify(GENL_MAGIC_FAMILY),
 	.version = GENL_MAGIC_VERSION,
 #ifdef GENL_MAGIC_FAMILY_HDRSZ
@@ -275,7 +277,8 @@ static struct genl_family ZZZ_genl_family __read_mostly = {
  * genetlink: only pass array to genl_register_family_with_ops()
  * which are commits c53ed742..2a94fe48
  */
-#ifdef genl_register_family_with_ops_groups
+#if defined(genl_register_family_with_ops_groups) || \
+    defined(COMPAT_HAVE_GENL_FAMILY_IN_GENLMSG_MULTICAST)
 #include <linux/genl_magic_func-genl_register_family_with_ops_groups.h>
 #else
 #include <linux/genl_magic_func-genl_register_mc_group.h>
-- 
1.8.5.6

