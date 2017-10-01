Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4F2491058013
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:41:44 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:08 +1100
Message-Id: <1506897256-14072-10-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/17] lru_cache: remove space after function name
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

checkpatch emits WARNING: space prohibited between function name and
open parenthesis '('.

Remove space between function name and open parenthesis.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 34af31e..8a5ef8c 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -67,7 +67,7 @@ int lc_try_lock(struct lru_cache *lc)
 
 	do {
 		val = cmpxchg(&lc->flags, 0, LC_LOCKED);
-	} while (unlikely (val == LC_PARANOIA));
+	} while (unlikely(val == LC_PARANOIA));
 	/* Spin until no-one is inside a PARANOIA_ENTRY()/RETURN() section. */
 	return 0 == val;
 #if 0
@@ -80,7 +80,7 @@ int lc_try_lock(struct lru_cache *lc)
 		old = lc->flags & LC_PARANOIA;
 		new = old | LC_LOCKED;
 		val = cmpxchg(&lc->flags, old, new);
-	} while (unlikely (val == (old ^ LC_PARANOIA)));
+	} while (unlikely(val == (old ^ LC_PARANOIA)));
 	return old == val;
 #endif
 }
-- 
2.7.4

