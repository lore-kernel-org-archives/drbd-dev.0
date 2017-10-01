Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2C9151058011
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:41:44 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:07 +1100
Message-Id: <1506897256-14072-9-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/17] lru_cache: add blank line after
	declarations
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

checkpatch emits WARNING: Missing a blank line after declarations.
Clearing this warning for variables declared within code blocks
that are not function definitions is of questionable benefit. Let's
just clear the function level declarations.

Add blank line after declarations.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index c15df31..34af31e 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -64,6 +64,7 @@ MODULE_LICENSE("GPL");
 int lc_try_lock(struct lru_cache *lc)
 {
 	unsigned long val;
+
 	do {
 		val = cmpxchg(&lc->flags, 0, LC_LOCKED);
 	} while (unlikely (val == LC_PARANOIA));
@@ -74,6 +75,7 @@ int lc_try_lock(struct lru_cache *lc)
 	 * PARANOIA_ENTRY()/RETURN() section.
 	 */
 	unsigned long old, new, val;
+
 	do {
 		old = lc->flags & LC_PARANOIA;
 		new = old | LC_LOCKED;
@@ -171,6 +173,7 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 static void lc_free_by_index(struct lru_cache *lc, unsigned int i)
 {
 	void *p = lc->lc_element[i];
+
 	WARN_ON(!p);
 	if (p) {
 		p -= lc->element_off;
@@ -185,6 +188,7 @@ static void lc_free_by_index(struct lru_cache *lc, unsigned int i)
 void lc_destroy(struct lru_cache *lc)
 {
 	unsigned int i;
+
 	if (!lc)
 		return;
 	for (i = 0; i < lc->nr_elements; i++)
-- 
2.7.4

