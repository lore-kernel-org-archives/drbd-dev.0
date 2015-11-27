Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C12EB10561AD
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BC0BF2A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:27 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id V7Bt9ASxqOi2 for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A19602ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:27 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qcuYgRx9bd3k for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:27 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E0EFB2A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:26 +0100 (CET)
Resent-Message-ID: <20151130193026.GA22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 899BE10561AD
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:30:04 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:29:34 +0100
Message-Id: <1448659775-13596-10-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659775-13596-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
	<1448659775-13596-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 19/21] drbd: remove bm_vk_free()
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

Commit 51fa48018a12
("tree wide: use kvfree() than conditional kfree()/vfree()")
simplified bm_vk_free() to one single call.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_bitmap.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 17e5e60..36c180f 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -364,11 +364,6 @@ static void bm_free_pages(struct page **pages, unsigned long number)
 	}
 }
 
-static inline void bm_vk_free(void *ptr)
-{
-	kvfree(ptr);
-}
-
 /*
  * "have" and "want" are NUMBER OF PAGES.
  */
@@ -407,7 +402,7 @@ static struct page **bm_realloc_pages(struct drbd_bitmap *b, unsigned long want)
 			page = alloc_page(GFP_NOIO | __GFP_HIGHMEM);
 			if (!page) {
 				bm_free_pages(new_pages + have, i - have);
-				bm_vk_free(new_pages);
+				kvfree(new_pages);
 				return NULL;
 			}
 			/* we want to know which page it is
@@ -459,7 +454,7 @@ void drbd_bm_cleanup(struct drbd_device *device)
 	if (!expect(device->bitmap))
 		return;
 	bm_free_pages(device->bitmap->bm_pages, device->bitmap->bm_number_of_pages);
-	bm_vk_free(device->bitmap->bm_pages);
+	kvfree(device->bitmap->bm_pages);
 	kfree(device->bitmap);
 	device->bitmap = NULL;
 }
@@ -659,7 +654,7 @@ int drbd_bm_resize(struct drbd_device *device, sector_t capacity, int set_new_bi
 		b->bm_dev_capacity = 0;
 		spin_unlock_irq(&b->bm_lock);
 		bm_free_pages(opages, onpages);
-		bm_vk_free(opages);
+		kvfree(opages);
 		goto out;
 	}
 	bits  = BM_SECT_TO_BIT(ALIGN(capacity, BM_SECT_PER_BIT));
@@ -732,7 +727,7 @@ int drbd_bm_resize(struct drbd_device *device, sector_t capacity, int set_new_bi
 
 	spin_unlock_irq(&b->bm_lock);
 	if (opages != npages)
-		bm_vk_free(opages);
+		kvfree(opages);
 	if (!growing)
 		b->bm_set = bm_count_bits(b);
 	drbd_info(device, "resync bitmap: bits=%lu words=%lu pages=%lu\n", bits, words, want);
-- 
2.1.4

