Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 97A871055F5F
	for <drbd-dev@lists.linbit.com>; Tue,  4 Aug 2015 14:57:00 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  4 Aug 2015 14:56:40 +0200
Message-Id: <1438693003-17554-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
References: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/19] drbd: separate out __al_write_transaction
	helper function
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

To be able to "force out" an activity log transaction,
even if there are no pending updates.

This will be used to relocate the on-disk activity log,
if the on-disk offsets have to be changed,
without the need to empty the activity log first.

While at it, move the definition,
so we can drop the forward declaration of a static helper.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c | 304 ++++++++++++++++++++-------------------
 1 file changed, 156 insertions(+), 148 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 1318e32..f83dcca 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -288,7 +288,162 @@ bool drbd_al_begin_io_prepare(struct drbd_device *device, struct drbd_interval *
 	return need_transaction;
 }
 
-static int al_write_transaction(struct drbd_device *device);
+#if (PAGE_SHIFT + 3) < (AL_EXTENT_SHIFT - BM_BLOCK_SHIFT)
+/* Currently BM_BLOCK_SHIFT, BM_EXT_SHIFT and AL_EXTENT_SHIFT
+ * are still coupled, or assume too much about their relation.
+ * Code below will not work if this is violated.
+ * Will be cleaned up with some followup patch.
+ */
+# error FIXME
+#endif
+
+static unsigned int al_extent_to_bm_page(unsigned int al_enr)
+{
+	return al_enr >>
+		/* bit to page */
+		((PAGE_SHIFT + 3) -
+		/* al extent number to bit */
+		 (AL_EXTENT_SHIFT - BM_BLOCK_SHIFT));
+}
+
+static sector_t al_tr_number_to_on_disk_sector(struct drbd_device *device)
+{
+	const unsigned int stripes = device->ldev->md.al_stripes;
+	const unsigned int stripe_size_4kB = device->ldev->md.al_stripe_size_4k;
+
+	/* transaction number, modulo on-disk ring buffer wrap around */
+	unsigned int t = device->al_tr_number % (device->ldev->md.al_size_4k);
+
+	/* ... to aligned 4k on disk block */
+	t = ((t % stripes) * stripe_size_4kB) + t/stripes;
+
+	/* ... to 512 byte sector in activity log */
+	t *= 8;
+
+	/* ... plus offset to the on disk position */
+	return device->ldev->md.md_offset + device->ldev->md.al_offset + t;
+}
+
+static int __al_write_transaction(struct drbd_device *device, struct al_transaction_on_disk *buffer)
+{
+	struct lc_element *e;
+	sector_t sector;
+	int i, mx;
+	unsigned extent_nr;
+	unsigned crc = 0;
+	int err = 0;
+
+	memset(buffer, 0, sizeof(*buffer));
+	buffer->magic = cpu_to_be32(DRBD_AL_MAGIC);
+	buffer->tr_number = cpu_to_be32(device->al_tr_number);
+
+	i = 0;
+
+	/* Even though no one can start to change this list
+	 * once we set the LC_LOCKED -- from drbd_al_begin_io(),
+	 * lc_try_lock_for_transaction() --, someone may still
+	 * be in the process of changing it. */
+	spin_lock_irq(&device->al_lock);
+	list_for_each_entry(e, &device->act_log->to_be_changed, list) {
+		if (i == AL_UPDATES_PER_TRANSACTION) {
+			i++;
+			break;
+		}
+		buffer->update_slot_nr[i] = cpu_to_be16(e->lc_index);
+		buffer->update_extent_nr[i] = cpu_to_be32(e->lc_new_number);
+		if (e->lc_number != LC_FREE)
+			drbd_bm_mark_for_writeout(device,
+					al_extent_to_bm_page(e->lc_number));
+		i++;
+	}
+	spin_unlock_irq(&device->al_lock);
+	BUG_ON(i > AL_UPDATES_PER_TRANSACTION);
+
+	buffer->n_updates = cpu_to_be16(i);
+	for ( ; i < AL_UPDATES_PER_TRANSACTION; i++) {
+		buffer->update_slot_nr[i] = cpu_to_be16(-1);
+		buffer->update_extent_nr[i] = cpu_to_be32(LC_FREE);
+	}
+
+	buffer->context_size = cpu_to_be16(device->act_log->nr_elements);
+	buffer->context_start_slot_nr = cpu_to_be16(device->al_tr_cycle);
+
+	mx = min_t(int, AL_CONTEXT_PER_TRANSACTION,
+		   device->act_log->nr_elements - device->al_tr_cycle);
+	for (i = 0; i < mx; i++) {
+		unsigned idx = device->al_tr_cycle + i;
+		extent_nr = lc_element_by_index(device->act_log, idx)->lc_number;
+		buffer->context[i] = cpu_to_be32(extent_nr);
+	}
+	for (; i < AL_CONTEXT_PER_TRANSACTION; i++)
+		buffer->context[i] = cpu_to_be32(LC_FREE);
+
+	device->al_tr_cycle += AL_CONTEXT_PER_TRANSACTION;
+	if (device->al_tr_cycle >= device->act_log->nr_elements)
+		device->al_tr_cycle = 0;
+
+	sector = al_tr_number_to_on_disk_sector(device);
+
+	crc = crc32c(0, buffer, 4096);
+	buffer->crc32c = cpu_to_be32(crc);
+
+	if (drbd_bm_write_hinted(device))
+		err = -EIO;
+	else {
+		bool write_al_updates;
+		rcu_read_lock();
+		write_al_updates = rcu_dereference(device->ldev->disk_conf)->al_updates;
+		rcu_read_unlock();
+		if (write_al_updates) {
+			if (drbd_md_sync_page_io(device, device->ldev, sector, WRITE)) {
+				err = -EIO;
+				drbd_chk_io_error(device, 1, DRBD_META_IO_ERROR);
+			} else {
+				device->al_tr_number++;
+				device->al_writ_cnt++;
+			}
+		}
+	}
+
+	return err;
+}
+
+static int al_write_transaction(struct drbd_device *device)
+{
+	struct al_transaction_on_disk *buffer;
+	int err;
+
+	if (!get_ldev(device)) {
+		drbd_err(device, "disk is %s, cannot start al transaction\n",
+			drbd_disk_str(device->state.disk));
+		return -EIO;
+	}
+
+	/* The bitmap write may have failed, causing a state change. */
+	if (device->state.disk < D_INCONSISTENT) {
+		drbd_err(device,
+			"disk is %s, cannot write al transaction\n",
+			drbd_disk_str(device->state.disk));
+		put_ldev(device);
+		return -EIO;
+	}
+
+	/* protects md_io_buffer, al_tr_cycle, ... */
+	buffer = drbd_md_get_buffer(device, __func__);
+	if (!buffer) {
+		drbd_err(device, "disk failed while waiting for md_io buffer\n");
+		put_ldev(device);
+		return -ENODEV;
+	}
+
+	err = __al_write_transaction(device, buffer);
+
+	drbd_md_put_buffer(device);
+	put_ldev(device);
+
+	return err;
+}
+
 
 void drbd_al_begin_io_commit(struct drbd_device *device)
 {
@@ -420,153 +575,6 @@ void drbd_al_complete_io(struct drbd_device *device, struct drbd_interval *i)
 	wake_up(&device->al_wait);
 }
 
-#if (PAGE_SHIFT + 3) < (AL_EXTENT_SHIFT - BM_BLOCK_SHIFT)
-/* Currently BM_BLOCK_SHIFT, BM_EXT_SHIFT and AL_EXTENT_SHIFT
- * are still coupled, or assume too much about their relation.
- * Code below will not work if this is violated.
- * Will be cleaned up with some followup patch.
- */
-# error FIXME
-#endif
-
-static unsigned int al_extent_to_bm_page(unsigned int al_enr)
-{
-	return al_enr >>
-		/* bit to page */
-		((PAGE_SHIFT + 3) -
-		/* al extent number to bit */
-		 (AL_EXTENT_SHIFT - BM_BLOCK_SHIFT));
-}
-
-static sector_t al_tr_number_to_on_disk_sector(struct drbd_device *device)
-{
-	const unsigned int stripes = device->ldev->md.al_stripes;
-	const unsigned int stripe_size_4kB = device->ldev->md.al_stripe_size_4k;
-
-	/* transaction number, modulo on-disk ring buffer wrap around */
-	unsigned int t = device->al_tr_number % (device->ldev->md.al_size_4k);
-
-	/* ... to aligned 4k on disk block */
-	t = ((t % stripes) * stripe_size_4kB) + t/stripes;
-
-	/* ... to 512 byte sector in activity log */
-	t *= 8;
-
-	/* ... plus offset to the on disk position */
-	return device->ldev->md.md_offset + device->ldev->md.al_offset + t;
-}
-
-int al_write_transaction(struct drbd_device *device)
-{
-	struct al_transaction_on_disk *buffer;
-	struct lc_element *e;
-	sector_t sector;
-	int i, mx;
-	unsigned extent_nr;
-	unsigned crc = 0;
-	int err = 0;
-
-	if (!get_ldev(device)) {
-		drbd_err(device, "disk is %s, cannot start al transaction\n",
-			drbd_disk_str(device->state.disk));
-		return -EIO;
-	}
-
-	/* The bitmap write may have failed, causing a state change. */
-	if (device->state.disk < D_INCONSISTENT) {
-		drbd_err(device,
-			"disk is %s, cannot write al transaction\n",
-			drbd_disk_str(device->state.disk));
-		put_ldev(device);
-		return -EIO;
-	}
-
-	/* protects md_io_buffer, al_tr_cycle, ... */
-	buffer = drbd_md_get_buffer(device, __func__);
-	if (!buffer) {
-		drbd_err(device, "disk failed while waiting for md_io buffer\n");
-		put_ldev(device);
-		return -ENODEV;
-	}
-
-	memset(buffer, 0, sizeof(*buffer));
-	buffer->magic = cpu_to_be32(DRBD_AL_MAGIC);
-	buffer->tr_number = cpu_to_be32(device->al_tr_number);
-
-	i = 0;
-
-	/* Even though no one can start to change this list
-	 * once we set the LC_LOCKED -- from drbd_al_begin_io(),
-	 * lc_try_lock_for_transaction() --, someone may still
-	 * be in the process of changing it. */
-	spin_lock_irq(&device->al_lock);
-	list_for_each_entry(e, &device->act_log->to_be_changed, list) {
-		if (i == AL_UPDATES_PER_TRANSACTION) {
-			i++;
-			break;
-		}
-		buffer->update_slot_nr[i] = cpu_to_be16(e->lc_index);
-		buffer->update_extent_nr[i] = cpu_to_be32(e->lc_new_number);
-		if (e->lc_number != LC_FREE)
-			drbd_bm_mark_for_writeout(device,
-					al_extent_to_bm_page(e->lc_number));
-		i++;
-	}
-	spin_unlock_irq(&device->al_lock);
-	BUG_ON(i > AL_UPDATES_PER_TRANSACTION);
-
-	buffer->n_updates = cpu_to_be16(i);
-	for ( ; i < AL_UPDATES_PER_TRANSACTION; i++) {
-		buffer->update_slot_nr[i] = cpu_to_be16(-1);
-		buffer->update_extent_nr[i] = cpu_to_be32(LC_FREE);
-	}
-
-	buffer->context_size = cpu_to_be16(device->act_log->nr_elements);
-	buffer->context_start_slot_nr = cpu_to_be16(device->al_tr_cycle);
-
-	mx = min_t(int, AL_CONTEXT_PER_TRANSACTION,
-		   device->act_log->nr_elements - device->al_tr_cycle);
-	for (i = 0; i < mx; i++) {
-		unsigned idx = device->al_tr_cycle + i;
-		extent_nr = lc_element_by_index(device->act_log, idx)->lc_number;
-		buffer->context[i] = cpu_to_be32(extent_nr);
-	}
-	for (; i < AL_CONTEXT_PER_TRANSACTION; i++)
-		buffer->context[i] = cpu_to_be32(LC_FREE);
-
-	device->al_tr_cycle += AL_CONTEXT_PER_TRANSACTION;
-	if (device->al_tr_cycle >= device->act_log->nr_elements)
-		device->al_tr_cycle = 0;
-
-	sector = al_tr_number_to_on_disk_sector(device);
-
-	crc = crc32c(0, buffer, 4096);
-	buffer->crc32c = cpu_to_be32(crc);
-
-	if (drbd_bm_write_hinted(device))
-		err = -EIO;
-	else {
-		bool write_al_updates;
-		rcu_read_lock();
-		write_al_updates = rcu_dereference(device->ldev->disk_conf)->al_updates;
-		rcu_read_unlock();
-		if (write_al_updates) {
-			if (drbd_md_sync_page_io(device, device->ldev, sector, WRITE)) {
-				err = -EIO;
-				drbd_chk_io_error(device, 1, DRBD_META_IO_ERROR);
-			} else {
-				device->al_tr_number++;
-				device->al_writ_cnt++;
-			}
-		}
-	}
-
-	drbd_md_put_buffer(device);
-	put_ldev(device);
-
-	return err;
-}
-
 static int _try_lc_del(struct drbd_device *device, struct lc_element *al_ext)
 {
 	int rv;
-- 
1.9.1

