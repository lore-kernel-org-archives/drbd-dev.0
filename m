Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B5283101AC75
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 10:43:16 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  3 Jul 2014 10:43:08 +0200
Message-Id: <1404376995-4877-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404376995-4877-1-git-send-email-philipp.reisner@linbit.com>
References: <1404376995-4877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/23] drbd: debugfs: add per volume
	oldest_requests
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

Show oldest requests
 * pending master bio completion and,
 * if different, local disk bio completion.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_debugfs.c | 153 ++++++++++++++++++++++++++++++++++++--
 lib/lru_cache.c                   |  21 +++---
 2 files changed, 160 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 230d9e1..45b5205 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -434,12 +434,10 @@ static int drbd_single_open(struct file *file, int (*show)(struct seq_file *, vo
 		goto out;
 	/* serialize with d_delete() */
 	mutex_lock(&parent->d_inode->i_mutex);
-	if (!debugfs_positive(file->f_dentry))
-		goto out_unlock;
 	/* Make sure the object is still alive */
-	if (kref_get_unless_zero(kref))
+	if (debugfs_positive(file->f_dentry)
+	&& kref_get_unless_zero(kref))
 		ret = 0;
-out_unlock:
 	mutex_unlock(&parent->d_inode->i_mutex);
 	if (!ret) {
 		ret = single_open(file, show, data);
@@ -592,6 +590,53 @@ static const struct file_operations connection_callback_history_fops = {
 	.release	= callback_history_release,
 };
 
+static int connection_oldest_requests_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_connection *connection = m->private;
+	unsigned long now = jiffies;
+	struct drbd_request *r1, *r2;
+
+	/* BUMP me if you change the file format/content/presentation */
+	seq_printf(m, "v: %u\n\n", 0);
+
+	spin_lock_irq(&connection->resource->req_lock);
+	r1 = connection->req_next;
+	if (r1)
+		seq_print_minor_vnr_req(m, r1, now);
+	r2 = connection->req_ack_pending;
+	if (r2 && r2 != r1) {
+		r1 = r2;
+		seq_print_minor_vnr_req(m, r1, now);
+	}
+	r2 = connection->req_not_net_done;
+	if (r2 && r2 != r1)
+		seq_print_minor_vnr_req(m, r2, now);
+	spin_unlock_irq(&connection->resource->req_lock);
+	return 0;
+}
+
+static int connection_oldest_requests_open(struct inode *inode, struct file *file)
+{
+	struct drbd_connection *connection = inode->i_private;
+	return drbd_single_open(file, connection_oldest_requests_show, connection,
+				&connection->kref, drbd_destroy_connection);
+}
+
+static int connection_oldest_requests_release(struct inode *inode, struct file *file)
+{
+	struct drbd_connection *connection = inode->i_private;
+	kref_put(&connection->kref, drbd_destroy_connection);
+	return single_release(inode, file);
+}
+
+static const struct file_operations connection_oldest_requests_fops = {
+	.owner		= THIS_MODULE,
+	.open		= connection_oldest_requests_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= connection_oldest_requests_release,
+};
+
 void drbd_debugfs_connection_add(struct drbd_connection *connection)
 {
 	struct dentry *conns_dir = connection->resource->debugfs_res_connections;
@@ -627,6 +672,89 @@ void drbd_debugfs_connection_cleanup(struct drbd_connection *connection)
 	drbd_debugfs_remove(&connection->debugfs_conn);
 }
 
+static void resync_dump_detail(struct seq_file *m, struct lc_element *e)
+{
+       struct bm_extent *bme = lc_entry(e, struct bm_extent, lce);
+
+       seq_printf(m, "%5d %s %s %s\n", bme->rs_left,
+		  test_bit(BME_NO_WRITES, &bme->flags) ? "NO_WRITES" : "---------",
+		  test_bit(BME_LOCKED, &bme->flags) ? "LOCKED" : "------",
+		  test_bit(BME_PRIORITY, &bme->flags) ? "PRIORITY" : "--------"
+		  );
+}
+
+static int device_resync_extents_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_device *device = m->private;
+	if (get_ldev_if_state(device, D_FAILED)) {
+		lc_seq_printf_stats(m, device->resync);
+		lc_seq_dump_details(m, device->resync, "rs_left flags", resync_dump_detail);
+		put_ldev(device);
+	}
+	return 0;
+}
+
+static int device_act_log_extents_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_device *device = m->private;
+	if (get_ldev_if_state(device, D_FAILED)) {
+		lc_seq_printf_stats(m, device->act_log);
+		lc_seq_dump_details(m, device->act_log, "", NULL);
+		put_ldev(device);
+	}
+	return 0;
+}
+
+static int device_oldest_requests_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_device *device = m->private;
+	struct drbd_resource *resource = device->resource;
+	unsigned long now = jiffies;
+	struct drbd_request *r1, *r2;
+	int i;
+
+	seq_puts(m, RQ_HDR);
+	spin_lock_irq(&resource->req_lock);
+	/* WRITE, then READ */
+	for (i = 1; i >= 0; --i) {
+		r1 = list_first_entry_or_null(&device->pending_master_completion[i],
+			struct drbd_request, req_pending_master_completion);
+		r2 = list_first_entry_or_null(&device->pending_completion[i],
+			struct drbd_request, req_pending_local);
+		if (r1)
+			seq_print_one_request(m, r1, now);
+		if (r2 && r2 != r1)
+			seq_print_one_request(m, r2, now);
+	}
+	spin_unlock_irq(&resource->req_lock);
+	return 0;
+}
+
+#define drbd_debugfs_device_attr(name)						\
+static int device_ ## name ## _open(struct inode *inode, struct file *file)	\
+{										\
+	struct drbd_device *device = inode->i_private;				\
+	return drbd_single_open(file, device_ ## name ## _show, device,		\
+				&device->kref, drbd_destroy_device);		\
+}										\
+static int device_ ## name ## _release(struct inode *inode, struct file *file)	\
+{										\
+	struct drbd_device *device = inode->i_private;				\
+	kref_put(&device->kref, drbd_destroy_device);				\
+	return single_release(inode, file);					\
+}										\
+static const struct file_operations device_ ## name ## _fops = {		\
+	.owner		= THIS_MODULE,						\
+	.open		= device_ ## name ## _open,				\
+	.read		= seq_read,						\
+	.llseek		= seq_lseek,						\
+	.release	= device_ ## name ## _release,				\
+};
+
+drbd_debugfs_device_attr(oldest_requests)
+drbd_debugfs_device_attr(act_log_extents)
+drbd_debugfs_device_attr(resync_extents)
+
 void drbd_debugfs_device_add(struct drbd_device *device)
 {
 	struct dentry *vols_dir = device->resource->debugfs_res_volumes;
@@ -650,10 +778,25 @@ void drbd_debugfs_device_add(struct drbd_device *device)
 	if (!slink_name)
 		goto fail;
 	dentry = debugfs_create_symlink(minor_buf, drbd_debugfs_minors, slink_name);
+	kfree(slink_name);
+	slink_name = NULL;
 	if (IS_ERR_OR_NULL(dentry))
 		goto fail;
 	device->debugfs_minor = dentry;
-	kfree(slink_name);
+
+#define DCF(name)	do {					\
+	dentry = debugfs_create_file(#name, S_IRUSR|S_IRGRP,	\
+			device->debugfs_vol, device,		\
+			&device_ ## name ## _fops);		\
+	if (IS_ERR_OR_NULL(dentry))				\
+		goto fail;					\
+	device->debugfs_vol_ ## name = dentry;			\
+	} while (0)
+
+	DCF(oldest_requests);
+	DCF(act_log_extents);
+	DCF(resync_extents);
+	return;
 
 fail:
 	drbd_debugfs_device_cleanup(device);
diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 6111cd1..852c81e 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -643,9 +643,10 @@ void lc_set(struct lru_cache *lc, unsigned int enr, int index)
  * lc_dump - Dump a complete LRU cache to seq in textual form.
  * @lc: the lru cache to operate on
  * @seq: the &struct seq_file pointer to seq_printf into
- * @utext: user supplied "heading" or other info
+ * @utext: user supplied additional "heading" or other info
  * @detail: function pointer the user may provide to dump further details
- * of the object the lc_element is embedded in.
+ * of the object the lc_element is embedded in. May be NULL.
+ * Note: a leading space ' ' and trailing newline '\n' is implied.
  */
 void lc_seq_dump_details(struct seq_file *seq, struct lru_cache *lc, char *utext,
 	     void (*detail) (struct seq_file *, struct lc_element *))
@@ -654,16 +655,18 @@ void lc_seq_dump_details(struct seq_file *seq, struct lru_cache *lc, char *utext
 	struct lc_element *e;
 	int i;
 
-	seq_printf(seq, "\tnn: lc_number refcnt %s\n ", utext);
+	seq_printf(seq, "\tnn: lc_number (new nr) refcnt %s\n ", utext);
 	for (i = 0; i < nr_elements; i++) {
 		e = lc_element_by_index(lc, i);
-		if (e->lc_number == LC_FREE) {
-			seq_printf(seq, "\t%2d: FREE\n", i);
-		} else {
-			seq_printf(seq, "\t%2d: %4u %4u    ", i,
-				   e->lc_number, e->refcnt);
+		if (e->lc_number != e->lc_new_number)
+			seq_printf(seq, "\t%5d: %6d %8d %6d ",
+				i, e->lc_number, e->lc_new_number, e->refcnt);
+		else
+			seq_printf(seq, "\t%5d: %6d %-8s %6d ",
+				i, e->lc_number, "-\"-", e->refcnt);
+		if (detail)
 			detail(seq, e);
-		}
+		seq_putc(seq, '\n');
 	}
 }
 
-- 
1.9.1

