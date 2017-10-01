Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B0A18105800A
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:41:43 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:12 +1100
Message-Id: <1506897256-14072-14-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/17] lru_cache: move constant to the right side
	of test
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

checkpatch emits WARNING: Comparisons should place the constant on the
right side of the test.

Move constant to the right hand side of the test.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 9eed675..a581b33 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -69,7 +69,7 @@ int lc_try_lock(struct lru_cache *lc)
 		val = cmpxchg(&lc->flags, 0, LC_LOCKED);
 	} while (unlikely(val == LC_PARANOIA));
 	/* Spin until no-one is inside a PARANOIA_ENTRY()/RETURN() section. */
-	return 0 == val;
+	return val == 0;
 #if 0
 	/* Alternative approach, spin in case someone enters or leaves a
 	 * PARANOIA_ENTRY()/RETURN() section.
-- 
2.7.4

