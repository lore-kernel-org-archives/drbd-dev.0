Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9E96B1058013
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:51:44 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:09 +1100
Message-Id: <1506897256-14072-11-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/17] lru_cache: fix function argument alignment
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

checkpatch emits CHECK: Alignment should match open parenthesis

Fix alignment to match open parenthesis.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 8a5ef8c..dc34bbc 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -97,8 +97,8 @@ int lc_try_lock(struct lru_cache *lc)
  * or NULL on (allocation) failure.
  */
 struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
-		unsigned int max_pending_changes,
-		unsigned int e_count, size_t e_size, size_t e_off)
+			    unsigned int max_pending_changes,
+			    unsigned int e_count, size_t e_size, size_t e_off)
 {
 	struct hlist_head *slot = NULL;
 	struct lc_element **element = NULL;
@@ -262,7 +262,7 @@ static struct hlist_head *lc_hash_slot(struct lru_cache *lc, unsigned int enr)
 
 
 static struct lc_element *__lc_find(struct lru_cache *lc, unsigned int enr,
-		bool include_changing)
+				    bool include_changing)
 {
 	struct lc_element *e;
 
@@ -656,7 +656,7 @@ void lc_set(struct lru_cache *lc, unsigned int enr, int index)
  * Note: a leading space ' ' and trailing newline '\n' is implied.
  */
 void lc_seq_dump_details(struct seq_file *seq, struct lru_cache *lc, char *utext,
-	     void (*detail) (struct seq_file *, struct lc_element *))
+			 void (*detail) (struct seq_file *, struct lc_element *))
 {
 	unsigned int nr_elements = lc->nr_elements;
 	struct lc_element *e;
@@ -667,10 +667,10 @@ void lc_seq_dump_details(struct seq_file *seq, struct lru_cache *lc, char *utext
 		e = lc_element_by_index(lc, i);
 		if (e->lc_number != e->lc_new_number)
 			seq_printf(seq, "\t%5d: %6d %8d %6d ",
-				i, e->lc_number, e->lc_new_number, e->refcnt);
+				   i, e->lc_number, e->lc_new_number, e->refcnt);
 		else
 			seq_printf(seq, "\t%5d: %6d %-8s %6d ",
-				i, e->lc_number, "-\"-", e->refcnt);
+				   i, e->lc_number, "-\"-", e->refcnt);
 		if (detail)
 			detail(seq, e);
 		seq_putc(seq, '\n');
-- 
2.7.4

