Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (prv3-mh.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 296411056459
	for <drbd-dev@lists.linbit.com>; Thu,  9 Jun 2016 16:40:15 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Thu,  9 Jun 2016 22:39:49 +0800
Message-Id: <1465483189-22696-4-git-send-email-nwang@suse.com>
In-Reply-To: <1465483189-22696-1-git-send-email-nwang@suse.com>
References: <1465483189-22696-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [PATCH-drbd9] compat: align nla_put_u64
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

In v4.7(1dee3f59), nla_put_u64 is removed, using
nla_put_u64_0pad for drbd instead.
Change header from linux/netlink.h to net/netlink.h
for nla_put_64bit.

Signed-off-by: Nick Wang <nwang@suse.com>

CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
---
 linux/genl_magic_struct.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/linux/genl_magic_struct.h b/linux/genl_magic_struct.h
index eb7140b..9586779 100644
--- a/linux/genl_magic_struct.h
+++ b/linux/genl_magic_struct.h
@@ -13,7 +13,7 @@
 # error "you need to define GENL_MAGIC_INCLUDE_FILE before inclusion"
 #endif
 
-#include <linux/netlink.h>
+#include <net/netlink.h>
 #include <linux/genetlink.h>
 #include <linux/types.h>
 #include "compat.h"
@@ -86,9 +86,21 @@ extern void CONCAT_(GENL_MAGIC_FAMILY, _genl_unregister)(void);
 	__field(attr_nr, attr_flag, name, NLA_U32, __s32, \
 			nla_get_u32, nla_put_u32, true)
 #endif
+#ifdef COMPAT_HAVE_ALIGNED_NLA_U64_PAD
 #define __u64_field(attr_nr, attr_flag, name)	\
 	__field(attr_nr, attr_flag, name, NLA_U64, __u64, \
 			nla_get_u64, nla_put_u64, false)
+#else
+
+static inline int nla_put_u64_0pad(struct sk_buff *skb, int attrtype, u64 value)
+{
+       return nla_put_64bit(skb, attrtype, sizeof(u64), &value, 0);
+}
+
+#define __u64_field(attr_nr, attr_flag, name)	\
+	__field(attr_nr, attr_flag, name, NLA_U64, __u64, \
+			nla_get_u64, nla_put_u64_0pad, false)
+#endif
 #define __str_field(attr_nr, attr_flag, name, maxlen) \
 	__array(attr_nr, attr_flag, name, NLA_NUL_STRING, char, maxlen, \
 			nla_strlcpy, nla_put, false)
-- 
1.8.5.6

