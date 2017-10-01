Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 13F391058010
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:41:44 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:13 +1100
Message-Id: <1506897256-14072-15-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/17] lru_cache: use braces on all arms of
	statement
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

checkpatch emits CHECK: braces {} should be used on all arms of this
statement. Also unbalanced braces warning is emitted for this same
snippet.

Use braces on all arms of statement, clearing two checkpatch warnings.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index a581b33..012c6b8 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -635,9 +635,9 @@ void lc_set(struct lru_cache *lc, unsigned int enr, int index)
 
 	e->lc_number = e->lc_new_number = enr;
 	hlist_del_init(&e->colision);
-	if (enr == LC_FREE)
+	if (enr == LC_FREE) {
 		lh = &lc->free;
-	else {
+	} else {
 		hlist_add_head(&e->colision, lc_hash_slot(lc, enr));
 		lh = &lc->lru;
 	}
-- 
2.7.4

