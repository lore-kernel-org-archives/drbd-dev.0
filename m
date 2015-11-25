Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8627310562D2
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:37 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:54:04 +0100
Message-Id: <1448448851-10343-32-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 31/38] lru_cache: Converted lc_seq_printf_status
	to return void
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

From: Roland Kammerer <roland.kammerer@linbit.com>

Fix the semantic of lc_seq_printf. Currently, it always returns 0 and
the return value is unused, therefore, convert the return type to void.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 include/linux/lru_cache.h | 2 +-
 lib/lru_cache.c           | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/lru_cache.h b/include/linux/lru_cache.h
index 4626228..04fc6e6 100644
--- a/include/linux/lru_cache.h
+++ b/include/linux/lru_cache.h
@@ -264,7 +264,7 @@ extern unsigned int lc_put(struct lru_cache *lc, struct lc_element *e);
 extern void lc_committed(struct lru_cache *lc);
 
 struct seq_file;
-extern size_t lc_seq_printf_stats(struct seq_file *seq, struct lru_cache *lc);
+extern void lc_seq_printf_stats(struct seq_file *seq, struct lru_cache *lc);
 
 extern void lc_seq_dump_details(struct seq_file *seq, struct lru_cache *lc, char *utext,
 				void (*detail) (struct seq_file *, struct lc_element *));
diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 028f5d9..28ba40b 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -238,7 +238,7 @@ void lc_reset(struct lru_cache *lc)
  * @seq: the seq_file to print into
  * @lc: the lru cache to print statistics of
  */
-size_t lc_seq_printf_stats(struct seq_file *seq, struct lru_cache *lc)
+void lc_seq_printf_stats(struct seq_file *seq, struct lru_cache *lc)
 {
 	/* NOTE:
 	 * total calls to lc_get are
@@ -250,8 +250,6 @@ size_t lc_seq_printf_stats(struct seq_file *seq, struct lru_cache *lc)
 	seq_printf(seq, "\t%s: used:%u/%u hits:%lu misses:%lu starving:%lu locked:%lu changed:%lu\n",
 		   lc->name, lc->used, lc->nr_elements,
 		   lc->hits, lc->misses, lc->starving, lc->locked, lc->changed);
-
-	return 0;
 }
 
 static struct hlist_head *lc_hash_slot(struct lru_cache *lc, unsigned int enr)
-- 
1.9.1

