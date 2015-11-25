Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A2ACC10562BF
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:36 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:54:00 +0100
Message-Id: <1448448851-10343-28-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 27/38] drbd: use bitmap_weight() helper,
	don't open code
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Suggested by Akinobu Mita <akinobu.mita@gmail.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 8bdc34d..0dabc9b 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -24,7 +24,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
-#include <linux/bitops.h>
+#include <linux/bitmap.h>
 #include <linux/vmalloc.h>
 #include <linux/string.h>
 #include <linux/drbd.h>
@@ -565,21 +565,19 @@ static unsigned long bm_count_bits(struct drbd_bitmap *b)
 	unsigned long *p_addr;
 	unsigned long bits = 0;
 	unsigned long mask = (1UL << (b->bm_bits & BITS_PER_LONG_MASK)) -1;
-	int idx, i, last_word;
+	int idx, last_word;
 
 	/* all but last page */
 	for (idx = 0; idx < b->bm_number_of_pages - 1; idx++) {
 		p_addr = __bm_map_pidx(b, idx);
-		for (i = 0; i < LWPP; i++)
-			bits += hweight_long(p_addr[i]);
+		bits += bitmap_weight(p_addr, BITS_PER_PAGE);
 		__bm_unmap(p_addr);
 		cond_resched();
 	}
 	/* last (or only) page */
 	last_word = ((b->bm_bits - 1) & BITS_PER_PAGE_MASK) >> LN2_BPL;
 	p_addr = __bm_map_pidx(b, idx);
-	for (i = 0; i < last_word; i++)
-		bits += hweight_long(p_addr[i]);
+	bits += bitmap_weight(p_addr, last_word * BITS_PER_LONG);
 	p_addr[last_word] &= cpu_to_lel(mask);
 	bits += hweight_long(p_addr[last_word]);
 	/* 32bit arch, may have an unused padding long */
@@ -1425,6 +1423,9 @@ static inline void bm_set_full_words_within_one_page(struct drbd_bitmap *b,
 	int bits;
 	int changed = 0;
 	unsigned long *paddr = kmap_atomic(b->bm_pages[page_nr]);
+
+	/* I think it is more cache line friendly to hweight_long then set to ~0UL,
+	 * than to first bitmap_weight() all words, then bitmap_fill() all words */
 	for (i = first_word; i < last_word; i++) {
 		bits = hweight_long(paddr[i]);
 		paddr[i] = ~0UL;
@@ -1634,8 +1635,7 @@ int drbd_bm_e_weight(struct drbd_device *device, unsigned long enr)
 		int n = e-s;
 		p_addr = bm_map_pidx(b, bm_word_to_page_idx(b, s));
 		bm = p_addr + MLPP(s);
-		while (n--)
-			count += hweight_long(*bm++);
+		count += bitmap_weight(bm, n * BITS_PER_LONG);
 		bm_unmap(p_addr);
 	} else {
 		drbd_err(device, "start offset (%d) too large in drbd_bm_e_weight\n", s);
-- 
1.9.1

