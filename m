Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D3DC210518AC
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:08:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9D11244D329
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:08:35 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OrhCEfmTkhOb for <drbd-dev@lists.linbit.com>;
	Fri, 13 Mar 2015 00:08:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7D78D44D391
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:08:35 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HpXEl_lA9ceH for <drbd-dev@lists.linbit.com>;
	Fri, 13 Mar 2015 00:08:35 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 54A6A44D329
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:08:35 +0100 (CET)
Resent-Message-ID: <20150312230835.GS3961@soda.linbit>
From: Fabio Estevam <festevam@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Sat,  7 Mar 2015 15:14:26 -0300
Message-Id: <1425752066-25196-1-git-send-email-festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: drbd_bitmap: Avoid name collision
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

From: Fabio Estevam <fabio.estevam@freescale.com>

Building for ARM64 leads to the following build warnings:

  CC      drivers/block/drbd/drbd_bitmap.o
drivers/block/drbd/drbd_bitmap.c:483:0: warning: "BITS_PER_PAGE" redefined
 #define BITS_PER_PAGE  (1UL << (PAGE_SHIFT + 3))
 ^
In file included from include/linux/ptrace.h:8:0,
                 from ./arch/arm64/include/asm/compat.h:26,
                 from ./arch/arm64/include/asm/stat.h:23,
                 from include/linux/stat.h:5,
                 from include/linux/sysfs.h:21,
                 from include/linux/kobject.h:21,
                 from include/linux/device.h:17,
                 from include/linux/pm_qos.h:10,
                 from include/linux/netdevice.h:28,
                 from include/net/sock.h:51,
                 from include/linux/connector.h:30,
                 from include/linux/drbd.h:28,
                 from drivers/block/drbd/drbd_bitmap.c:30:
include/linux/pid_namespace.h:18:0: note: this is the location of the previous definition
 #define BITS_PER_PAGE  (PAGE_SIZE * 8)
 ^
drivers/block/drbd/drbd_bitmap.c:484:0: warning: "BITS_PER_PAGE_MASK" redefined
 #define BITS_PER_PAGE_MASK (BITS_PER_PAGE - 1)
 ^
In file included from include/linux/ptrace.h:8:0,
                 from ./arch/arm64/include/asm/compat.h:26,
                 from ./arch/arm64/include/asm/stat.h:23,
                 from include/linux/stat.h:5,
                 from include/linux/sysfs.h:21,
                 from include/linux/kobject.h:21,
                 from include/linux/device.h:17,
                 from include/linux/pm_qos.h:10,
                 from include/linux/netdevice.h:28,
                 from include/net/sock.h:51,
                 from include/linux/connector.h:30,
                 from include/linux/drbd.h:28,
                 from drivers/block/drbd/drbd_bitmap.c:30:
include/linux/pid_namespace.h:19:0: note: this is the location of the previous definition
 #define BITS_PER_PAGE_MASK (BITS_PER_PAGE-1)
 ^

Fix the warnings by using BITS_PER_PAGE_DRBD and BITS_PER_PAGE_MASK_DRBD 
definitions to avoid the name collision.

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/block/drbd/drbd_bitmap.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 434c77d..b8dc9fc 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -479,8 +479,8 @@ void drbd_bm_cleanup(struct drbd_device *device)
  * this masks out the remaining bits.
  * Returns the number of bits cleared.
  */
-#define BITS_PER_PAGE		(1UL << (PAGE_SHIFT + 3))
-#define BITS_PER_PAGE_MASK	(BITS_PER_PAGE - 1)
+#define BITS_PER_PAGE_DRBD	(1UL << (PAGE_SHIFT + 3))
+#define BITS_PER_PAGE_MASK_DRBD	(BITS_PER_PAGE_DRBD - 1)
 #define BITS_PER_LONG_MASK	(BITS_PER_LONG - 1)
 static int bm_clear_surplus(struct drbd_bitmap *b)
 {
@@ -490,7 +490,7 @@ static int bm_clear_surplus(struct drbd_bitmap *b)
 	int cleared = 0;
 
 	/* number of bits modulo bits per page */
-	tmp = (b->bm_bits & BITS_PER_PAGE_MASK);
+	tmp = (b->bm_bits & BITS_PER_PAGE_MASK_DRBD);
 	/* mask the used bits of the word containing the last bit */
 	mask = (1UL << (tmp & BITS_PER_LONG_MASK)) -1;
 	/* bitmap is always stored little endian,
@@ -526,7 +526,7 @@ static void bm_set_surplus(struct drbd_bitmap *b)
 	int tmp;
 
 	/* number of bits modulo bits per page */
-	tmp = (b->bm_bits & BITS_PER_PAGE_MASK);
+	tmp = (b->bm_bits & BITS_PER_PAGE_MASK_DRBD);
 	/* mask the used bits of the word containing the last bit */
 	mask = (1UL << (tmp & BITS_PER_LONG_MASK)) -1;
 	/* bitmap is always stored little endian,
@@ -570,7 +570,7 @@ static unsigned long bm_count_bits(struct drbd_bitmap *b)
 		cond_resched();
 	}
 	/* last (or only) page */
-	last_word = ((b->bm_bits - 1) & BITS_PER_PAGE_MASK) >> LN2_BPL;
+	last_word = ((b->bm_bits - 1) & BITS_PER_PAGE_MASK_DRBD) >> LN2_BPL;
 	p_addr = __bm_map_pidx(b, idx);
 	for (i = 0; i < last_word; i++)
 		bits += hweight_long(p_addr[i]);
@@ -1257,15 +1257,15 @@ static unsigned long __bm_find_next(struct drbd_device *device, unsigned long bm
 	} else {
 		while (bm_fo < b->bm_bits) {
 			/* bit offset of the first bit in the page */
-			bit_offset = bm_fo & ~BITS_PER_PAGE_MASK;
+			bit_offset = bm_fo & ~BITS_PER_PAGE_MASK_DRBD;
 			p_addr = __bm_map_pidx(b, bm_bit_to_page_idx(b, bm_fo));
 
 			if (find_zero_bit)
 				i = find_next_zero_bit_le(p_addr,
-						PAGE_SIZE*8, bm_fo & BITS_PER_PAGE_MASK);
+						PAGE_SIZE*8, bm_fo & BITS_PER_PAGE_MASK_DRBD);
 			else
 				i = find_next_bit_le(p_addr,
-						PAGE_SIZE*8, bm_fo & BITS_PER_PAGE_MASK);
+						PAGE_SIZE*8, bm_fo & BITS_PER_PAGE_MASK_DRBD);
 
 			__bm_unmap(p_addr);
 			if (i < PAGE_SIZE*8) {
@@ -1366,9 +1366,9 @@ static int __bm_change_bits_to(struct drbd_device *device, const unsigned long s
 			last_page_nr = page_nr;
 		}
 		if (val)
-			c += (0 == __test_and_set_bit_le(bitnr & BITS_PER_PAGE_MASK, p_addr));
+			c += (0 == __test_and_set_bit_le(bitnr & BITS_PER_PAGE_MASK_DRBD, p_addr));
 		else
-			c -= (0 != __test_and_clear_bit_le(bitnr & BITS_PER_PAGE_MASK, p_addr));
+			c -= (0 != __test_and_clear_bit_le(bitnr & BITS_PER_PAGE_MASK_DRBD, p_addr));
 	}
 	if (p_addr)
 		__bm_unmap(p_addr);
@@ -1545,7 +1545,7 @@ int drbd_bm_test_bit(struct drbd_device *device, const unsigned long bitnr)
 		bm_print_lock_info(device);
 	if (bitnr < b->bm_bits) {
 		p_addr = bm_map_pidx(b, bm_bit_to_page_idx(b, bitnr));
-		i = test_bit_le(bitnr & BITS_PER_PAGE_MASK, p_addr) ? 1 : 0;
+		i = test_bit_le(bitnr & BITS_PER_PAGE_MASK_DRBD, p_addr) ? 1 : 0;
 		bm_unmap(p_addr);
 	} else if (bitnr == b->bm_bits) {
 		i = -1;
-- 
1.9.1

