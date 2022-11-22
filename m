Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
	[209.85.128.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1F65F4252BB
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 14:43:16 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
	a11-20020a05600c2d4b00b003cf6f5fd9f1so11317592wmg.2
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 05:43:16 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 22 Nov 2022 14:43:00 +0100
Message-Id: <20221122134301.69258-4-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
References: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/4] lru_cache: remove unused lc_private, lc_set,
	lc_index_of
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

From: Joel Colledge <joel.colledge@linbit.com>

Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 include/linux/lru_cache.h |  3 ---
 lib/lru_cache.c           | 44 ---------------------------------------
 2 files changed, 47 deletions(-)

diff --git a/include/linux/lru_cache.h b/include/linux/lru_cache.h
index 07add7882a5d..c9afcdd9324c 100644
--- a/include/linux/lru_cache.h
+++ b/include/linux/lru_cache.h
@@ -199,7 +199,6 @@ struct lru_cache {
 	unsigned long flags;
 
 
-	void  *lc_private;
 	const char *name;
 
 	/* nr_elements there */
@@ -241,7 +240,6 @@ extern struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 		unsigned e_count, size_t e_size, size_t e_off);
 extern void lc_reset(struct lru_cache *lc);
 extern void lc_destroy(struct lru_cache *lc);
-extern void lc_set(struct lru_cache *lc, unsigned int enr, int index);
 extern void lc_del(struct lru_cache *lc, struct lc_element *element);
 
 extern struct lc_element *lc_get_cumulative(struct lru_cache *lc, unsigned int enr);
@@ -297,6 +295,5 @@ extern bool lc_is_used(struct lru_cache *lc, unsigned int enr);
 	container_of(ptr, type, member)
 
 extern struct lc_element *lc_element_by_index(struct lru_cache *lc, unsigned i);
-extern unsigned int lc_index_of(struct lru_cache *lc, struct lc_element *e);
 
 #endif
diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 5dd5e4c00a23..b3d9187611de 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -574,48 +574,6 @@ struct lc_element *lc_element_by_index(struct lru_cache *lc, unsigned i)
 	return lc->lc_element[i];
 }
 
-/**
- * lc_index_of
- * @lc: the lru cache to operate on
- * @e: the element to query for its index position in lc->element
- */
-unsigned int lc_index_of(struct lru_cache *lc, struct lc_element *e)
-{
-	PARANOIA_LC_ELEMENT(lc, e);
-	return e->lc_index;
-}
-
-/**
- * lc_set - associate index with label
- * @lc: the lru cache to operate on
- * @enr: the label to set
- * @index: the element index to associate label with.
- *
- * Used to initialize the active set to some previously recorded state.
- */
-void lc_set(struct lru_cache *lc, unsigned int enr, int index)
-{
-	struct lc_element *e;
-	struct list_head *lh;
-
-	if (index < 0 || index >= lc->nr_elements)
-		return;
-
-	e = lc_element_by_index(lc, index);
-	BUG_ON(e->lc_number != e->lc_new_number);
-	BUG_ON(e->refcnt != 0);
-
-	e->lc_number = e->lc_new_number = enr;
-	hlist_del_init(&e->colision);
-	if (enr == LC_FREE)
-		lh = &lc->free;
-	else {
-		hlist_add_head(&e->colision, lc_hash_slot(lc, enr));
-		lh = &lc->lru;
-	}
-	list_move(&e->list, lh);
-}
-
 /**
  * lc_seq_dump_details - Dump a complete LRU cache to seq in textual form.
  * @lc: the lru cache to operate on
@@ -650,7 +608,6 @@ void lc_seq_dump_details(struct seq_file *seq, struct lru_cache *lc, char *utext
 EXPORT_SYMBOL(lc_create);
 EXPORT_SYMBOL(lc_reset);
 EXPORT_SYMBOL(lc_destroy);
-EXPORT_SYMBOL(lc_set);
 EXPORT_SYMBOL(lc_del);
 EXPORT_SYMBOL(lc_try_get);
 EXPORT_SYMBOL(lc_find);
@@ -658,7 +615,6 @@ EXPORT_SYMBOL(lc_get);
 EXPORT_SYMBOL(lc_put);
 EXPORT_SYMBOL(lc_committed);
 EXPORT_SYMBOL(lc_element_by_index);
-EXPORT_SYMBOL(lc_index_of);
 EXPORT_SYMBOL(lc_seq_printf_stats);
 EXPORT_SYMBOL(lc_seq_dump_details);
 EXPORT_SYMBOL(lc_try_lock);
-- 
2.38.1

