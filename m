Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3EBC21019A36
	for <drbd-dev@lists.linbit.com>; Thu, 19 Mar 2015 21:08:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 323DF453CB7
	for <drbd-dev@lists.linbit.com>; Thu, 19 Mar 2015 21:08:45 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id CWWxiUPcqOKS for <drbd-dev@lists.linbit.com>;
	Thu, 19 Mar 2015 21:08:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 95966453CA0
	for <drbd-dev@lists.linbit.com>; Thu, 19 Mar 2015 21:08:43 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mbY0AnGCBzY1 for <drbd-dev@lists.linbit.com>;
	Thu, 19 Mar 2015 21:08:43 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D0BE3453C93
	for <drbd-dev@lists.linbit.com>; Thu, 19 Mar 2015 21:08:42 +0100 (CET)
Resent-Message-ID: <20150319200842.GD3556@soda.linbit>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
	[209.85.192.174]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D1C091028A59
	for <drbd-dev@lists.linbit.com>; Sat, 14 Mar 2015 02:35:52 +0100 (CET)
Received: by pdbcz9 with SMTP id cz9so1632252pdb.3
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 18:35:50 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Date: Sat, 14 Mar 2015 10:12:56 +0900
Message-Id: <1426295577-10836-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1426295577-10836-1-git-send-email-akinobu.mita@gmail.com>
References: <1426295577-10836-1-git-send-email-akinobu.mita@gmail.com>
Cc: Philipp Reisner <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Lars Ellenberg <philipp.reisner@linbit.com>
Subject: [Drbd-dev] [PATCH] drbd: use bitmap_weight()
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

Use bitmap_weight to count the total number of bits set in bitmap.
This change just simplifies the code a bit.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Philipp Reisner <lars.ellenberg@linbit.com>
Cc: Lars Ellenberg <philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
---
 drivers/block/drbd/drbd_bitmap.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 434c77d..39d31af 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -24,7 +24,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
-#include <linux/bitops.h>
+#include <linux/bitmap.h>
 #include <linux/vmalloc.h>
 #include <linux/string.h>
 #include <linux/drbd.h>
@@ -559,21 +559,19 @@ static unsigned long bm_count_bits(struct drbd_bitmap *b)
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
+		bits += bitmap_weight(p_addr, PAGE_SIZE * BITS_PER_BYTE);
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
@@ -1424,15 +1422,12 @@ int drbd_bm_clear_bits(struct drbd_device *device, const unsigned long s, const
 static inline void bm_set_full_words_within_one_page(struct drbd_bitmap *b,
 		int page_nr, int first_word, int last_word)
 {
-	int i;
-	int bits;
-	int changed = 0;
 	unsigned long *paddr = kmap_atomic(b->bm_pages[page_nr]);
-	for (i = first_word; i < last_word; i++) {
-		bits = hweight_long(paddr[i]);
-		paddr[i] = ~0UL;
-		changed += BITS_PER_LONG - bits;
-	}
+	int nbits = (last_word - first_word) * BITS_PER_LONG;
+	int changed;
+
+	changed = nbits - bitmap_weight(paddr + first_word, nbits);
+	bitmap_fill(paddr + first_word, nbits);
 	kunmap_atomic(paddr);
 	if (changed) {
 		/* We only need lazy writeout, the information is still in the
@@ -1637,8 +1632,7 @@ int drbd_bm_e_weight(struct drbd_device *device, unsigned long enr)
 		int n = e-s;
 		p_addr = bm_map_pidx(b, bm_word_to_page_idx(b, s));
 		bm = p_addr + MLPP(s);
-		while (n--)
-			count += hweight_long(*bm++);
+		count = bitmap_weight(bm, n * BITS_PER_LONG);
 		bm_unmap(p_addr);
 	} else {
 		drbd_err(device, "start offset (%d) too large in drbd_bm_e_weight\n", s);
-- 
1.9.1

