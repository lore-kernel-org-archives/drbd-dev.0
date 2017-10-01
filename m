Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0F7E6105800D
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:51:43 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:05 +1100
Message-Id: <1506897256-14072-7-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/17] lru_cache: use kcalloc instead of kzalloc
	with multiply
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

checkpatch emits WARNING: Prefer kcalloc over kzalloc with multiply.

Use kcalloc instead of kzalloc with multiply.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 0bdb858..18043b9 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -117,7 +117,7 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 	slot = kcalloc(e_count, sizeof(struct hlist_head), GFP_KERNEL);
 	if (!slot)
 		goto out_fail;
-	element = kzalloc(e_count * sizeof(struct lc_element *), GFP_KERNEL);
+	element = kcalloc(e_count, sizeof(struct lc_element *), GFP_KERNEL);
 	if (!element)
 		goto out_fail;
 
-- 
2.7.4

