Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 11AF71058011
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:51:43 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:03 +1100
Message-Id: <1506897256-14072-5-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/17] lru_cache: remove quoted string across
	lines
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

checkpatch emits WARNING: quoted string split across lines. This is
caused by the MODULE_AUTHOR string for multiple authors. We can call
the MODULE_AUTHOR macro multiple times instead.

Remove quoted string across lines. Replace with second call to
MODULE_AUTHOR macro.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 898feb9..0d3c3bb 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -25,8 +25,8 @@
 #include <linux/seq_file.h> /* for seq_printf */
 #include <linux/lru_cache.h>
 
-MODULE_AUTHOR("Philipp Reisner <phil@linbit.com>, "
-	      "Lars Ellenberg <lars@linbit.com>");
+MODULE_AUTHOR("Philipp Reisner <phil@linbit.com>");
+MODULE_AUTHOR("Lars Ellenberg <lars@linbit.com>");
 MODULE_DESCRIPTION("lru_cache - Track sets of hot objects");
 MODULE_LICENSE("GPL");
 
-- 
2.7.4

