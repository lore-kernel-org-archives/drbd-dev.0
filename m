Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7846A1058015
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:41:44 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:02 +1100
Message-Id: <1506897256-14072-4-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/17] lru_cache: move trailing */ to a separate
	line
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

checkpatch emits WARNING: Block comments use a trailing */ on a
separate line.

Move trailing */ to a separate line.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 273af4b..898feb9 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -30,8 +30,9 @@ MODULE_AUTHOR("Philipp Reisner <phil@linbit.com>, "
 MODULE_DESCRIPTION("lru_cache - Track sets of hot objects");
 MODULE_LICENSE("GPL");
 
-/* this is developers aid only.
- * it catches concurrent access (lack of locking on the users part) */
+/* This is developers aid only.
+ * it catches concurrent access (lack of locking on the users part)
+ */
 #define PARANOIA_ENTRY() do {		\
 	BUG_ON(!lc);			\
 	BUG_ON(!lc->nr_elements);	\
@@ -69,7 +70,8 @@ int lc_try_lock(struct lru_cache *lc)
 	return 0 == val;
 #if 0
 	/* Alternative approach, spin in case someone enters or leaves a
-	 * PARANOIA_ENTRY()/RETURN() section. */
+	 * PARANOIA_ENTRY()/RETURN() section.
+	 */
 	unsigned long old, new, val;
 	do {
 		old = lc->flags & LC_PARANOIA;
@@ -107,7 +109,8 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 		return NULL;
 
 	/* e_count too big; would probably fail the allocation below anyways.
-	 * for typical use cases, e_count should be few thousand at most. */
+	 * for typical use cases, e_count should be few thousand at most.
+	 */
 	if (e_count > LC_MAX_ACTIVE)
 		return NULL;
 
@@ -263,7 +266,8 @@ static struct lc_element *__lc_find(struct lru_cache *lc, unsigned int enr,
 	hlist_for_each_entry(e, lc_hash_slot(lc, enr), colision) {
 		/* "about to be changed" elements, pending transaction commit,
 		 * are hashed by their "new number". "Normal" elements have
-		 * lc_number == lc_new_number. */
+		 * lc_number == lc_new_number.
+		 */
 		if (e->lc_new_number != enr)
 			continue;
 		if (e->lc_new_number == e->lc_number || include_changing)
@@ -379,7 +383,8 @@ static struct lc_element *__lc_get(struct lru_cache *lc, unsigned int enr, unsig
 	/* if lc_new_number != lc_number,
 	 * this enr is currently being pulled in already,
 	 * and will be available once the pending transaction
-	 * has been committed. */
+	 * has been committed.
+	 */
 	if (e) {
 		if (e->lc_new_number != e->lc_number) {
 			/* It has been found above, but on the "to_be_changed"
@@ -389,7 +394,8 @@ static struct lc_element *__lc_get(struct lru_cache *lc, unsigned int enr, unsig
 			if (!(flags & LC_GET_MAY_USE_UNCOMMITTED))
 				RETURN(NULL);
 			/* ... unless the caller is aware of the implications,
-			 * probably preparing a cumulative transaction. */
+			 * probably preparing a cumulative transaction.
+			 */
 			++e->refcnt;
 			++lc->hits;
 			RETURN(e);
@@ -408,7 +414,8 @@ static struct lc_element *__lc_get(struct lru_cache *lc, unsigned int enr, unsig
 		RETURN(NULL);
 
 	/* To avoid races with lc_try_lock(), first, mark us dirty
-	 * (using test_and_set_bit, as it implies memory barriers), ... */
+	 * (using test_and_set_bit, as it implies memory barriers), ...
+	 */
 	test_and_set_bit(__LC_DIRTY, &lc->flags);
 
 	/* ... only then check if it is locked anyways. If lc_unlock clears
@@ -429,7 +436,8 @@ static struct lc_element *__lc_get(struct lru_cache *lc, unsigned int enr, unsig
 
 	/* It was not present in the active set.  We are going to recycle an
 	 * unused (or even "free") element, but we won't accumulate more than
-	 * max_pending_changes changes.  */
+	 * max_pending_changes changes.
+	 */
 	if (lc->pending_changes >= lc->max_pending_changes)
 		RETURN(NULL);
 
-- 
2.7.4

