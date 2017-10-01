Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 128D81058012
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:51:43 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:04 +1100
Message-Id: <1506897256-14072-6-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/17] lru_cache: use 'unsigned int' instead of
	'unsigned'
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

checkpatch emits WARNING: Prefer 'unsigned int' to bare use of
'unsigned'.

Use 'unsigned int' instead of 'unsigned'.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 0d3c3bb..0bdb858 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -47,7 +47,7 @@ MODULE_LICENSE("GPL");
 #define PARANOIA_LC_ELEMENT(lc, e) do {	\
 	struct lru_cache *lc_ = (lc);	\
 	struct lc_element *e_ = (e);	\
-	unsigned i = e_->lc_index;	\
+	unsigned int i = e_->lc_index;	\
 	BUG_ON(i >= lc_->nr_elements);	\
 	BUG_ON(lc_->lc_element[i] != e_); } while (0)
 
@@ -94,15 +94,15 @@ int lc_try_lock(struct lru_cache *lc)
  * or NULL on (allocation) failure.
  */
 struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
-		unsigned max_pending_changes,
-		unsigned e_count, size_t e_size, size_t e_off)
+		unsigned int max_pending_changes,
+		unsigned int e_count, size_t e_size, size_t e_off)
 {
 	struct hlist_head *slot = NULL;
 	struct lc_element **element = NULL;
 	struct lru_cache *lc;
 	struct lc_element *e;
-	unsigned cache_obj_size = kmem_cache_size(cache);
-	unsigned i;
+	unsigned int cache_obj_size = kmem_cache_size(cache);
+	unsigned int i;
 
 	WARN_ON(cache_obj_size < e_size);
 	if (cache_obj_size < e_size)
@@ -167,7 +167,7 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 	return NULL;
 }
 
-static void lc_free_by_index(struct lru_cache *lc, unsigned i)
+static void lc_free_by_index(struct lru_cache *lc, unsigned int i)
 {
 	void *p = lc->lc_element[i];
 	WARN_ON(!p);
@@ -183,7 +183,7 @@ static void lc_free_by_index(struct lru_cache *lc, unsigned i)
  */
 void lc_destroy(struct lru_cache *lc)
 {
-	unsigned i;
+	unsigned int i;
 	if (!lc)
 		return;
 	for (i = 0; i < lc->nr_elements; i++)
@@ -202,7 +202,7 @@ void lc_destroy(struct lru_cache *lc)
  */
 void lc_reset(struct lru_cache *lc)
 {
-	unsigned i;
+	unsigned int i;
 
 	INIT_LIST_HEAD(&lc->in_use);
 	INIT_LIST_HEAD(&lc->lru);
@@ -329,7 +329,7 @@ void lc_del(struct lru_cache *lc, struct lc_element *e)
 	RETURN();
 }
 
-static struct lc_element *lc_prepare_for_change(struct lru_cache *lc, unsigned new_number)
+static struct lc_element *lc_prepare_for_change(struct lru_cache *lc, unsigned int new_number)
 {
 	struct list_head *n;
 	struct lc_element *e;
@@ -591,7 +591,7 @@ unsigned int lc_put(struct lru_cache *lc, struct lc_element *e)
  * @lc: the lru cache to operate on
  * @i: the index of the element to return
  */
-struct lc_element *lc_element_by_index(struct lru_cache *lc, unsigned i)
+struct lc_element *lc_element_by_index(struct lru_cache *lc, unsigned int i)
 {
 	BUG_ON(i >= lc->nr_elements);
 	BUG_ON(lc->lc_element[i] == NULL);
-- 
2.7.4

