Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9D8CC1057461
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2011 10:55:00 +0200 (CEST)
Resent-Message-ID: <20110329085457.GH16279@barkeeper1-xen.linbit>
Received: from na3sys010aog112.obsmtp.com (na3sys010aog112.obsmtp.com
	[74.125.245.92])
	by mail09.linbit.com (LINBIT Mail Daemon) with SMTP id EF19010572C8
	for <drbd-dev@lists.linbit.com>; Mon, 28 Mar 2011 18:30:24 +0200 (CEST)
Received: by mail-iw0-f181.google.com with SMTP id 2so4073748iwn.26
	for <drbd-dev@lists.linbit.com>; Mon, 28 Mar 2011 09:30:23 -0700 (PDT)
Sender: Roland Dreier <roland@purestorage.com>
From: Roland Dreier <roland@kernel.org>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Mar 2011 09:23:27 -0700
Message-Id: <1301329407-12493-1-git-send-email-roland@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] drbd: Fix build after bitop renames
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Roland Dreier <roland@purestorage.com>

From: Roland Dreier <roland@purestorage.com>

Commit c4945b9ed472 ("asm-generic: rename generic little-endian bitops
functions") got rid of the "generic_" prefix from various bitop
functions.  Fix drbd up so it matches (and compiles).

Signed-off-by: Roland Dreier <roland@purestorage.com>
---
 drivers/block/drbd/drbd_bitmap.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index f0ae63d..eb925fa 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1184,10 +1184,10 @@ static unsigned long __bm_find_next(struct drbd_conf *mdev, unsigned long bm_fo,
 			p_addr = __bm_map_pidx(b, bm_bit_to_page_idx(b, bm_fo), km);
 
 			if (find_zero_bit)
-				i = generic_find_next_zero_le_bit(p_addr,
+				i = find_next_zero_bit_le(p_addr,
 						PAGE_SIZE*8, bm_fo & BITS_PER_PAGE_MASK);
 			else
-				i = generic_find_next_le_bit(p_addr,
+				i = find_next_bit_le(p_addr,
 						PAGE_SIZE*8, bm_fo & BITS_PER_PAGE_MASK);
 
 			__bm_unmap(p_addr, km);
@@ -1287,9 +1287,9 @@ static int __bm_change_bits_to(struct drbd_conf *mdev, const unsigned long s,
 			last_page_nr = page_nr;
 		}
 		if (val)
-			c += (0 == generic___test_and_set_le_bit(bitnr & BITS_PER_PAGE_MASK, p_addr));
+			c += (0 == __test_and_set_bit_le(bitnr & BITS_PER_PAGE_MASK, p_addr));
 		else
-			c -= (0 != generic___test_and_clear_le_bit(bitnr & BITS_PER_PAGE_MASK, p_addr));
+			c -= (0 != __test_and_clear_bit_le(bitnr & BITS_PER_PAGE_MASK, p_addr));
 	}
 	if (p_addr)
 		__bm_unmap(p_addr, km);
@@ -1438,7 +1438,7 @@ int drbd_bm_test_bit(struct drbd_conf *mdev, const unsigned long bitnr)
 		bm_print_lock_info(mdev);
 	if (bitnr < b->bm_bits) {
 		p_addr = bm_map_pidx(b, bm_bit_to_page_idx(b, bitnr));
-		i = generic_test_le_bit(bitnr & BITS_PER_PAGE_MASK, p_addr) ? 1 : 0;
+		i = test_bit_le(bitnr & BITS_PER_PAGE_MASK, p_addr) ? 1 : 0;
 		bm_unmap(p_addr);
 	} else if (bitnr == b->bm_bits) {
 		i = -1;
@@ -1482,7 +1482,7 @@ int drbd_bm_count_bits(struct drbd_conf *mdev, const unsigned long s, const unsi
 		ERR_IF (bitnr >= b->bm_bits) {
 			dev_err(DEV, "bitnr=%lu bm_bits=%lu\n", bitnr, b->bm_bits);
 		} else {
-			c += (0 != generic_test_le_bit(bitnr - (page_nr << (PAGE_SHIFT+3)), p_addr));
+			c += (0 != test_bit_le(bitnr - (page_nr << (PAGE_SHIFT+3)), p_addr));
 		}
 	}
 	if (p_addr)
