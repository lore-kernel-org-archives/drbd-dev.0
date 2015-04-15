Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
	[140.211.169.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 15B8310003FC
	for <drbd-dev@lists.linbit.com>; Thu, 16 Apr 2015 01:21:02 +0200 (CEST)
Date: Wed, 15 Apr 2015 16:18:25 -0700
From: akpm@linux-foundation.org
To: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	joe@perches.com, drbd-dev@lists.linbit.com
Message-ID: <552ef1c1.NbdbnaMmebXElpGW%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] [patch 113/114] lru_cache: remove use of seq_printf
	return value
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

From: Joe Perches <joe@perches.com>
Subject: lru_cache: remove use of seq_printf return value

The seq_printf return value, because it's frequently misused,
will eventually be converted to void.

See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
     seq_has_overflowed() and make public")

Signed-off-by: Joe Perches <joe@perches.com>
Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/lru_cache.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff -puN lib/lru_cache.c~lru_cache-remove-use-of-seq_printf-return-value lib/lru_cache.c
--- a/lib/lru_cache.c~lru_cache-remove-use-of-seq_printf-return-value
+++ a/lib/lru_cache.c
@@ -247,10 +247,11 @@ size_t lc_seq_printf_stats(struct seq_fi
 	 * progress) and "changed", when this in fact lead to an successful
 	 * update of the cache.
 	 */
-	return seq_printf(seq, "\t%s: used:%u/%u "
-		"hits:%lu misses:%lu starving:%lu locked:%lu changed:%lu\n",
-		lc->name, lc->used, lc->nr_elements,
-		lc->hits, lc->misses, lc->starving, lc->locked, lc->changed);
+	seq_printf(seq, "\t%s: used:%u/%u hits:%lu misses:%lu starving:%lu locked:%lu changed:%lu\n",
+		   lc->name, lc->used, lc->nr_elements,
+		   lc->hits, lc->misses, lc->starving, lc->locked, lc->changed);
+
+	return 0;
 }
 
 static struct hlist_head *lc_hash_slot(struct lru_cache *lc, unsigned int enr)
_
