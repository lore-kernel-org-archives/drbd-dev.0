Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 241F01019A36
	for <drbd-dev@lists.linbit.com>; Fri, 27 Feb 2015 12:38:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 171043EF03E
	for <drbd-dev@lists.linbit.com>; Fri, 27 Feb 2015 12:38:36 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id VcC8YBZzE_zY for <drbd-dev@lists.linbit.com>;
	Fri, 27 Feb 2015 12:38:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id ECAEF3EF3A8
	for <drbd-dev@lists.linbit.com>; Fri, 27 Feb 2015 12:38:35 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QNfWUCOwBB-B for <drbd-dev@lists.linbit.com>;
	Fri, 27 Feb 2015 12:38:35 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 7F8A33EF03E
	for <drbd-dev@lists.linbit.com>; Fri, 27 Feb 2015 12:38:35 +0100 (CET)
Resent-Message-ID: <20150227113835.GM19088@soda.linbit>
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Date: Sat, 21 Feb 2015 18:53:52 -0800
Message-Id: <71e9974045e2d3728e3f8dd21e5882986b1402a6.1424573328.git.joe@perches.com>
In-Reply-To: <cover.1424573328.git.joe@perches.com>
References: <cover.1424573328.git.joe@perches.com>
Cc: linux-kernel@vger.kernel.org, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH 25/27] lru_cache: Remove use of seq_printf return
	value
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

The seq_printf return value, because it's frequently misused,
will eventually be converted to void.

See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
     seq_has_overflowed() and make public")

Signed-off-by: Joe Perches <joe@perches.com>
---
 lib/lru_cache.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 852c81e..028f5d9 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -247,10 +247,11 @@ size_t lc_seq_printf_stats(struct seq_file *seq, struct lru_cache *lc)
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
-- 
2.1.2

