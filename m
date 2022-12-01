Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
	[209.85.218.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A18BB421788
	for <drbd-dev@lists.linbit.com>; Thu,  1 Dec 2022 12:04:50 +0100 (CET)
Received: by mail-ej1-f45.google.com with SMTP id b2so3309751eja.7
	for <drbd-dev@lists.linbit.com>; Thu, 01 Dec 2022 03:04:50 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  1 Dec 2022 12:03:50 +0100
Message-Id: <20221201110349.1282687-6-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
References: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 5/5] drbd: add context parameter to expect() macro
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Originally-from: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c           |  4 +-
 drivers/block/drbd/drbd_bitmap.c           | 54 +++++++++++-----------
 drivers/block/drbd/drbd_main.c             |  8 ++--
 drivers/block/drbd/drbd_nl.c               |  2 +-
 drivers/block/drbd/drbd_polymorph_printk.h |  4 +-
 drivers/block/drbd/drbd_receiver.c         | 12 ++---
 6 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 87d93012289f..429255876800 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -868,9 +868,9 @@ int __drbd_change_sync(struct drbd_device *device, sector_t sector, int size,
 	nr_sectors = get_capacity(device->vdisk);
 	esector = sector + (size >> 9) - 1;
 
-	if (!expect(sector < nr_sectors))
+	if (!expect(device, sector < nr_sectors))
 		goto out;
-	if (!expect(esector < nr_sectors))
+	if (!expect(device, esector < nr_sectors))
 		esector = nr_sectors - 1;
 
 	lbnr = BM_SECT_TO_BIT(nr_sectors-1);
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 8e6534a90e12..289876ffbc31 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -448,7 +448,7 @@ int drbd_bm_init(struct drbd_device *device)
 
 sector_t drbd_bm_capacity(struct drbd_device *device)
 {
-	if (!expect(device->bitmap))
+	if (!expect(device, device->bitmap))
 		return 0;
 	return device->bitmap->bm_dev_capacity;
 }
@@ -457,7 +457,7 @@ sector_t drbd_bm_capacity(struct drbd_device *device)
  */
 void drbd_bm_cleanup(struct drbd_device *device)
 {
-	if (!expect(device->bitmap))
+	if (!expect(device, device->bitmap))
 		return;
 	bm_free_pages(device->bitmap->bm_pages, device->bitmap->bm_number_of_pages);
 	bm_vk_free(device->bitmap->bm_pages);
@@ -636,7 +636,7 @@ int drbd_bm_resize(struct drbd_device *device, sector_t capacity, int set_new_bi
 	int err = 0;
 	bool growing;
 
-	if (!expect(b))
+	if (!expect(device, b))
 		return -ENOMEM;
 
 	drbd_bm_lock(device, "resize", BM_LOCKED_MASK);
@@ -757,9 +757,9 @@ unsigned long _drbd_bm_total_weight(struct drbd_device *device)
 	unsigned long s;
 	unsigned long flags;
 
-	if (!expect(b))
+	if (!expect(device, b))
 		return 0;
-	if (!expect(b->bm_pages))
+	if (!expect(device, b->bm_pages))
 		return 0;
 
 	spin_lock_irqsave(&b->bm_lock, flags);
@@ -783,9 +783,9 @@ unsigned long drbd_bm_total_weight(struct drbd_device *device)
 size_t drbd_bm_words(struct drbd_device *device)
 {
 	struct drbd_bitmap *b = device->bitmap;
-	if (!expect(b))
+	if (!expect(device, b))
 		return 0;
-	if (!expect(b->bm_pages))
+	if (!expect(device, b->bm_pages))
 		return 0;
 
 	return b->bm_words;
@@ -794,7 +794,7 @@ size_t drbd_bm_words(struct drbd_device *device)
 unsigned long drbd_bm_bits(struct drbd_device *device)
 {
 	struct drbd_bitmap *b = device->bitmap;
-	if (!expect(b))
+	if (!expect(device, b))
 		return 0;
 
 	return b->bm_bits;
@@ -816,9 +816,9 @@ void drbd_bm_merge_lel(struct drbd_device *device, size_t offset, size_t number,
 
 	end = offset + number;
 
-	if (!expect(b))
+	if (!expect(device, b))
 		return;
-	if (!expect(b->bm_pages))
+	if (!expect(device, b->bm_pages))
 		return;
 	if (number == 0)
 		return;
@@ -863,9 +863,9 @@ void drbd_bm_get_lel(struct drbd_device *device, size_t offset, size_t number,
 
 	end = offset + number;
 
-	if (!expect(b))
+	if (!expect(device, b))
 		return;
-	if (!expect(b->bm_pages))
+	if (!expect(device, b->bm_pages))
 		return;
 
 	spin_lock_irq(&b->bm_lock);
@@ -894,9 +894,9 @@ void drbd_bm_get_lel(struct drbd_device *device, size_t offset, size_t number,
 void drbd_bm_set_all(struct drbd_device *device)
 {
 	struct drbd_bitmap *b = device->bitmap;
-	if (!expect(b))
+	if (!expect(device, b))
 		return;
-	if (!expect(b->bm_pages))
+	if (!expect(device, b->bm_pages))
 		return;
 
 	spin_lock_irq(&b->bm_lock);
@@ -910,9 +910,9 @@ void drbd_bm_set_all(struct drbd_device *device)
 void drbd_bm_clear_all(struct drbd_device *device)
 {
 	struct drbd_bitmap *b = device->bitmap;
-	if (!expect(b))
+	if (!expect(device, b))
 		return;
-	if (!expect(b->bm_pages))
+	if (!expect(device, b->bm_pages))
 		return;
 
 	spin_lock_irq(&b->bm_lock);
@@ -1332,9 +1332,9 @@ static unsigned long bm_find_next(struct drbd_device *device,
 	struct drbd_bitmap *b = device->bitmap;
 	unsigned long i = DRBD_END_OF_BITMAP;
 
-	if (!expect(b))
+	if (!expect(device, b))
 		return i;
-	if (!expect(b->bm_pages))
+	if (!expect(device, b->bm_pages))
 		return i;
 
 	spin_lock_irq(&b->bm_lock);
@@ -1436,9 +1436,9 @@ static int bm_change_bits_to(struct drbd_device *device, const unsigned long s,
 	struct drbd_bitmap *b = device->bitmap;
 	int c = 0;
 
-	if (!expect(b))
+	if (!expect(device, b))
 		return 1;
-	if (!expect(b->bm_pages))
+	if (!expect(device, b->bm_pages))
 		return 0;
 
 	spin_lock_irqsave(&b->bm_lock, flags);
@@ -1582,9 +1582,9 @@ int drbd_bm_test_bit(struct drbd_device *device, const unsigned long bitnr)
 	unsigned long *p_addr;
 	int i;
 
-	if (!expect(b))
+	if (!expect(device, b))
 		return 0;
-	if (!expect(b->bm_pages))
+	if (!expect(device, b->bm_pages))
 		return 0;
 
 	spin_lock_irqsave(&b->bm_lock, flags);
@@ -1619,9 +1619,9 @@ int drbd_bm_count_bits(struct drbd_device *device, const unsigned long s, const
 	 * robust in case we screwed up elsewhere, in that case pretend there
 	 * was one dirty bit in the requested area, so we won't try to do a
 	 * local read there (no bitmap probably implies no disk) */
-	if (!expect(b))
+	if (!expect(device, b))
 		return 1;
-	if (!expect(b->bm_pages))
+	if (!expect(device, b->bm_pages))
 		return 1;
 
 	spin_lock_irqsave(&b->bm_lock, flags);
@@ -1635,7 +1635,7 @@ int drbd_bm_count_bits(struct drbd_device *device, const unsigned long s, const
 				bm_unmap(p_addr);
 			p_addr = bm_map_pidx(b, idx);
 		}
-		if (expect(bitnr < b->bm_bits))
+		if (expect(device, bitnr < b->bm_bits))
 			c += (0 != test_bit_le(bitnr - (page_nr << (PAGE_SHIFT+3)), p_addr));
 		else
 			drbd_err(device, "bitnr=%lu bm_bits=%lu\n", bitnr, b->bm_bits);
@@ -1668,9 +1668,9 @@ int drbd_bm_e_weight(struct drbd_device *device, unsigned long enr)
 	unsigned long flags;
 	unsigned long *p_addr, *bm;
 
-	if (!expect(b))
+	if (!expect(device, b))
 		return 0;
-	if (!expect(b->bm_pages))
+	if (!expect(device, b->bm_pages))
 		return 0;
 
 	spin_lock_irqsave(&b->bm_lock, flags);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index acfbba3c0f21..7213ffd69a16 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1259,7 +1259,7 @@ static int _drbd_send_bitmap(struct drbd_device *device)
 	struct bm_xfer_ctx c;
 	int err;
 
-	if (!expect(device->bitmap))
+	if (!expect(device, device->bitmap))
 		return false;
 
 	if (get_ldev(device)) {
@@ -2250,9 +2250,9 @@ static void do_retry(struct work_struct *ws)
 		bool expected;
 
 		expected =
-			expect(atomic_read(&req->completion_ref) == 0) &&
-			expect(req->rq_state & RQ_POSTPONED) &&
-			expect((req->rq_state & RQ_LOCAL_PENDING) == 0 ||
+			expect(device, atomic_read(&req->completion_ref) == 0) &&
+			expect(device, req->rq_state & RQ_POSTPONED) &&
+			expect(device, (req->rq_state & RQ_LOCAL_PENDING) == 0 ||
 				(req->rq_state & RQ_LOCAL_ABORTED) != 0);
 
 		if (!expected)
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index cb55b28fba78..60757ac31701 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1543,7 +1543,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 		goto fail_unlock;
 	}
 
-	if (!expect(new_disk_conf->resync_rate >= 1))
+	if (!expect(device, new_disk_conf->resync_rate >= 1))
 		new_disk_conf->resync_rate = 1;
 
 	sanitize_disk_conf(device, new_disk_conf, device->ldev);
diff --git a/drivers/block/drbd/drbd_polymorph_printk.h b/drivers/block/drbd/drbd_polymorph_printk.h
index 914f2a3c0e2e..8e0082d139ba 100644
--- a/drivers/block/drbd/drbd_polymorph_printk.h
+++ b/drivers/block/drbd/drbd_polymorph_printk.h
@@ -130,10 +130,10 @@ void drbd_dyn_dbg_with_wrong_object_type(void);
  *
  * Unlike the assert macro, this macro returns a boolean result.
  */
-#define expect(exp) ({								\
+#define expect(x, exp) ({							\
 		bool _bool = (exp);						\
 		if (!_bool && drbd_ratelimit())					\
-			drbd_err(device, "ASSERTION %s FAILED in %s\n",		\
+			drbd_err(x, "ASSERTION %s FAILED in %s\n",		\
 				#exp, __func__);				\
 		_bool;								\
 		})
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index afbe0df3ff75..24d0a2262982 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -413,7 +413,7 @@ void __drbd_free_peer_req(struct drbd_device *device, struct drbd_peer_request *
 	drbd_free_pages(device, peer_req->pages, is_net);
 	D_ASSERT(device, atomic_read(&peer_req->pending_bios) == 0);
 	D_ASSERT(device, drbd_interval_empty(&peer_req->i));
-	if (!expect(!(peer_req->flags & EE_CALL_AL_COMPLETE_IO))) {
+	if (!expect(device, !(peer_req->flags & EE_CALL_AL_COMPLETE_IO))) {
 		peer_req->flags &= ~EE_CALL_AL_COMPLETE_IO;
 		drbd_al_complete_io(device, &peer_req->i);
 	}
@@ -1873,21 +1873,21 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 	/* assume request_size == data_size, but special case trim. */
 	ds = data_size;
 	if (trim) {
-		if (!expect(data_size == 0))
+		if (!expect(peer_device, data_size == 0))
 			return NULL;
 		ds = be32_to_cpu(trim->size);
 	} else if (zeroes) {
-		if (!expect(data_size == 0))
+		if (!expect(peer_device, data_size == 0))
 			return NULL;
 		ds = be32_to_cpu(zeroes->size);
 	}
 
-	if (!expect(IS_ALIGNED(ds, 512)))
+	if (!expect(peer_device, IS_ALIGNED(ds, 512)))
 		return NULL;
 	if (trim || zeroes) {
-		if (!expect(ds <= (DRBD_MAX_BBIO_SECTORS << 9)))
+		if (!expect(peer_device, ds <= (DRBD_MAX_BBIO_SECTORS << 9)))
 			return NULL;
-	} else if (!expect(ds <= DRBD_MAX_BIO_SIZE))
+	} else if (!expect(peer_device, ds <= DRBD_MAX_BIO_SIZE))
 		return NULL;
 
 	/* even though we trust out peer,
-- 
2.38.1

