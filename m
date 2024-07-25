Return-Path: <deshan@nfschina.com>
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by mail19.linbit.com (LINBIT Mail Daemon) with SMTP id A321E420312
	for <drbd-dev@lists.linbit.com>; Thu, 25 Jul 2024 11:37:38 +0200 (CEST)
From: Deshan Zhang <deshan@nfschina.com>
To: akpm@linux-foundation.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com
Subject: [PATCH] lib/lru_cache: fix spelling mistake "colision"->"collision"
Date: Thu, 25 Jul 2024 17:30:45 +0800
Message-Id: <20240725093044.1742842-1-deshan@nfschina.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Deshan Zhang <deshan@nfschina.com>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Deshan Zhang <deshan@nfschina.com>
---
 include/linux/lru_cache.h |  4 ++--
 lib/lru_cache.c           | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/lru_cache.h b/include/linux/lru_cache.h
index c9afcdd9324c..ff82ef85a084 100644
--- a/include/linux/lru_cache.h
+++ b/include/linux/lru_cache.h
@@ -119,7 +119,7 @@ write intent log information, three of which are mentioned here.
 */
 
 /* this defines an element in a tracked set
- * .colision is for hash table lookup.
+ * .collision is for hash table lookup.
  * When we process a new IO request, we know its sector, thus can deduce the
  * region number (label) easily.  To do the label -> object lookup without a
  * full list walk, we use a simple hash table.
@@ -145,7 +145,7 @@ write intent log information, three of which are mentioned here.
  * But it avoids high order page allocations in kmalloc.
  */
 struct lc_element {
-	struct hlist_node colision;
+	struct hlist_node collision;
 	struct list_head list;		 /* LRU list or free list */
 	unsigned refcnt;
 	/* back "pointer" into lc_cache->element[index],
diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index b3d9187611de..9e0d469c7658 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -243,7 +243,7 @@ static struct lc_element *__lc_find(struct lru_cache *lc, unsigned int enr,
 
 	BUG_ON(!lc);
 	BUG_ON(!lc->nr_elements);
-	hlist_for_each_entry(e, lc_hash_slot(lc, enr), colision) {
+	hlist_for_each_entry(e, lc_hash_slot(lc, enr), collision) {
 		/* "about to be changed" elements, pending transaction commit,
 		 * are hashed by their "new number". "Normal" elements have
 		 * lc_number == lc_new_number. */
@@ -303,7 +303,7 @@ void lc_del(struct lru_cache *lc, struct lc_element *e)
 	BUG_ON(e->refcnt);
 
 	e->lc_number = e->lc_new_number = LC_FREE;
-	hlist_del_init(&e->colision);
+	hlist_del_init(&e->collision);
 	list_move(&e->list, &lc->free);
 	RETURN();
 }
@@ -324,9 +324,9 @@ static struct lc_element *lc_prepare_for_change(struct lru_cache *lc, unsigned n
 	PARANOIA_LC_ELEMENT(lc, e);
 
 	e->lc_new_number = new_number;
-	if (!hlist_unhashed(&e->colision))
-		__hlist_del(&e->colision);
-	hlist_add_head(&e->colision, lc_hash_slot(lc, new_number));
+	if (!hlist_unhashed(&e->collision))
+		__hlist_del(&e->collision);
+	hlist_add_head(&e->collision, lc_hash_slot(lc, new_number));
 	list_move(&e->list, &lc->to_be_changed);
 
 	return e;
-- 
2.30.2

