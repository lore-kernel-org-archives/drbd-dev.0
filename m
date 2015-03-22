Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3EC481011B9B
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2015 15:59:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 19C592AB5B3
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2015 15:59:01 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0neb9P9D3KRp for <drbd-dev@lists.linbit.com>;
	Sun, 22 Mar 2015 15:59:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BEC042ABEB1
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2015 15:59:00 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0bJX4KdlQBfg for <drbd-dev@lists.linbit.com>;
	Sun, 22 Mar 2015 15:59:00 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 929592AB5B3
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2015 15:59:00 +0100 (CET)
Resent-Message-ID: <20150322145900.GK3556@soda.linbit>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
	[209.85.192.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C55A11011B9B
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2015 08:31:45 +0100 (CET)
Received: by pdbni2 with SMTP id ni2so153392279pdb.1
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2015 00:31:44 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 22 Mar 2015 16:31:29 +0900
Message-Id: <1427009489-4269-1-git-send-email-akinobu.mita@gmail.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
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
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
---
 drivers/block/drbd/drbd_bitmap.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 434c77d..1e62c49 100644
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
@@ -1637,8 +1635,7 @@ int drbd_bm_e_weight(struct drbd_device *device, unsigned long enr)
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

