Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3341E1056494
	for <drbd-dev@lists.linbit.com>; Tue,  7 Mar 2017 04:28:45 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Tue,  7 Mar 2017 11:27:58 +0800
Message-Id: <1488857279-29079-8-git-send-email-nwang@suse.com>
In-Reply-To: <1488857279-29079-1-git-send-email-nwang@suse.com>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [Patch v0 7/8] Statically initialize families
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

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com 

---
 drbd/linux/genl_magic_func-genl_register_family_with_ops_groups.h | 4 ++++
 1 files changed, 4 insertions(+)

diff --git a/drbd/linux/genl_magic_func-genl_register_family_with_ops_groups.h b/drbd/linux/genl_magic_func-genl_register_family_with_ops_groups.h
index 27d8f73..cbd776e 100644
--- a/drbd/linux/genl_magic_func-genl_register_family_with_ops_groups.h
+++ b/drbd/linux/genl_magic_func-genl_register_family_with_ops_groups.h
@@ -29,9 +29,13 @@ static int CONCAT_(GENL_MAGIC_FAMILY, _genl_multicast_ ## group)(	\
 
 int CONCAT_(GENL_MAGIC_FAMILY, _genl_register)(void)
 {
+#ifdef genl_register_family_with_ops_groups
 	return genl_register_family_with_ops_groups(&ZZZ_genl_family,	\
 						    ZZZ_genl_ops,	\
 						    ZZZ_genl_mcgrps);
+#else
+	return genl_register_family(&ZZZ_genl_family);
+#endif
 }
 
 void CONCAT_(GENL_MAGIC_FAMILY, _genl_unregister)(void)
-- 
1.8.5.6

