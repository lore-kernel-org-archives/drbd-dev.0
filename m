Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EE532105800D
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:41:43 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:16 +1100
Message-Id: <1506897256-14072-18-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 17/17] lru_cache: move EXPORT_SYMBOL macro to
	follow function
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

checkpatch emits WARNING: EXPORT_SYMBOL(foo); should immediately follow
its function/variable.

Move EXPORT_SYMBOL macro call to immediately follow function definition.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 5acfbe0..9d20e24 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -84,6 +84,7 @@ int lc_try_lock(struct lru_cache *lc)
 	return old == val;
 #endif
 }
+EXPORT_SYMBOL(lc_try_lock);
 
 /**
  * lc_create - prepares to track objects in an active set
@@ -169,6 +170,7 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 	kfree(slot);
 	return NULL;
 }
+EXPORT_SYMBOL(lc_create);
 
 static void lc_free_by_index(struct lru_cache *lc, unsigned int i)
 {
@@ -197,6 +199,7 @@ void lc_destroy(struct lru_cache *lc)
 	kfree(lc->lc_slot);
 	kfree(lc);
 }
+EXPORT_SYMBOL(lc_destroy);
 
 /**
  * lc_reset - does a full reset for @lc and the hash table slots.
@@ -235,6 +238,7 @@ void lc_reset(struct lru_cache *lc)
 		list_add(&e->list, &lc->free);
 	}
 }
+EXPORT_SYMBOL(lc_reset);
 
 /**
  * lc_seq_printf_stats - print stats about @lc into @seq
@@ -254,6 +258,7 @@ void lc_seq_printf_stats(struct seq_file *seq, struct lru_cache *lc)
 		   lc->name, lc->used, lc->nr_elements,
 		   lc->hits, lc->misses, lc->starving, lc->locked, lc->changed);
 }
+EXPORT_SYMBOL(lc_seq_printf_stats);
 
 static struct hlist_head *lc_hash_slot(struct lru_cache *lc, unsigned int enr)
 {
@@ -296,6 +301,7 @@ struct lc_element *lc_find(struct lru_cache *lc, unsigned int enr)
 {
 	return __lc_find(lc, enr, 0);
 }
+EXPORT_SYMBOL(lc_find);
 
 /**
  * lc_is_used - find element by label
@@ -312,6 +318,7 @@ bool lc_is_used(struct lru_cache *lc, unsigned int enr)
 	struct lc_element *e = __lc_find(lc, enr, 1);
 	return e && e->refcnt;
 }
+EXPORT_SYMBOL(lc_is_used);
 
 /**
  * lc_del - removes an element from the cache
@@ -332,6 +339,7 @@ void lc_del(struct lru_cache *lc, struct lc_element *e)
 	list_move(&e->list, &lc->free);
 	RETURN();
 }
+EXPORT_SYMBOL(lc_del);
 
 static struct lc_element *lc_prepare_for_change(struct lru_cache *lc, unsigned int new_number)
 {
@@ -500,6 +508,7 @@ struct lc_element *lc_get(struct lru_cache *lc, unsigned int enr)
 {
 	return __lc_get(lc, enr, LC_GET_MAY_CHANGE);
 }
+EXPORT_SYMBOL(lc_get);
 
 /**
  * lc_get_cumulative - like lc_get; also finds to-be-changed elements
@@ -521,6 +530,7 @@ struct lc_element *lc_get_cumulative(struct lru_cache *lc, unsigned int enr)
 	return __lc_get(lc, enr,
 			LC_GET_MAY_CHANGE | LC_GET_MAY_USE_UNCOMMITTED);
 }
+EXPORT_SYMBOL(lc_get_cumulative);
 
 /**
  * lc_try_get - get element by label, if present; do not change the active set
@@ -542,6 +552,7 @@ struct lc_element *lc_try_get(struct lru_cache *lc, unsigned int enr)
 {
 	return __lc_get(lc, enr, 0);
 }
+EXPORT_SYMBOL(lc_try_get);
 
 /**
  * lc_committed - tell @lc that pending changes have been recorded
@@ -565,6 +576,7 @@ void lc_committed(struct lru_cache *lc)
 	lc->pending_changes = 0;
 	RETURN();
 }
+EXPORT_SYMBOL(lc_committed);
 
 /**
  * lc_put - give up refcnt of @e
@@ -589,6 +601,7 @@ unsigned int lc_put(struct lru_cache *lc, struct lc_element *e)
 	}
 	RETURN(e->refcnt);
 }
+EXPORT_SYMBOL(lc_put);
 
 /**
  * lc_element_by_index
@@ -602,6 +615,7 @@ struct lc_element *lc_element_by_index(struct lru_cache *lc, unsigned int i)
 	BUG_ON(lc->lc_element[i]->lc_index != i);
 	return lc->lc_element[i];
 }
+EXPORT_SYMBOL(lc_element_by_index);
 
 /**
  * lc_index_of
@@ -613,6 +627,7 @@ unsigned int lc_index_of(struct lru_cache *lc, struct lc_element *e)
 	PARANOIA_LC_ELEMENT(lc, e);
 	return e->lc_index;
 }
+EXPORT_SYMBOL(lc_index_of);
 
 /**
  * lc_set - associate index with label
@@ -644,6 +659,7 @@ void lc_set(struct lru_cache *lc, unsigned int enr, int index)
 	}
 	list_move(&e->list, lh);
 }
+EXPORT_SYMBOL(lc_set);
 
 /**
  * lc_dump - Dump a complete LRU cache to seq in textual form.
@@ -675,21 +691,4 @@ void lc_seq_dump_details(struct seq_file *seq, struct lru_cache *lc, char *utext
 		seq_putc(seq, '\n');
 	}
 }
-
-EXPORT_SYMBOL(lc_create);
-EXPORT_SYMBOL(lc_reset);
-EXPORT_SYMBOL(lc_destroy);
-EXPORT_SYMBOL(lc_set);
-EXPORT_SYMBOL(lc_del);
-EXPORT_SYMBOL(lc_try_get);
-EXPORT_SYMBOL(lc_find);
-EXPORT_SYMBOL(lc_get);
-EXPORT_SYMBOL(lc_put);
-EXPORT_SYMBOL(lc_committed);
-EXPORT_SYMBOL(lc_element_by_index);
-EXPORT_SYMBOL(lc_index_of);
-EXPORT_SYMBOL(lc_seq_printf_stats);
 EXPORT_SYMBOL(lc_seq_dump_details);
-EXPORT_SYMBOL(lc_try_lock);
-EXPORT_SYMBOL(lc_is_used);
-EXPORT_SYMBOL(lc_get_cumulative);
-- 
2.7.4

