Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0E10B105800A
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:51:43 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:11 +1100
Message-Id: <1506897256-14072-13-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/17] lru_cache: remove space before tabs
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

checkpatch emits WARNING: please, no space before tabs

Remove space before tabs.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index b9cc261..9eed675 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -511,7 +511,7 @@ struct lc_element *lc_get(struct lru_cache *lc, unsigned int enr)
  * plus:
  *
  * pointer to an element already on the "to_be_changed" list.
- * 	In this case, the cache was already marked %LC_DIRTY.
+ * In this case, the cache was already marked %LC_DIRTY.
  *
  * Caller needs to make sure that the pending transaction is completed,
  * before proceeding to actually use this element.
-- 
2.7.4

