Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6A312105647D
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jun 2016 16:09:27 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2016 16:09:14 +0200
Message-Id: <1465826958-19398-27-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
References: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 26/30] drbd: code cleanups without semantic
	changes
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

From: Fabian Frederick <fabf@skynet.be>

This contains various cosmetic fixes ranging from simple typos to
const-ifying, and using booleans properly.

Original commit messages from Fabian's patch set:
drbd: debugfs: constify drbd_version_fops
drbd: use seq_put instead of seq_print where possible
drbd: include linux/uaccess.h instead of asm/uaccess.h
drbd: use const char * const for drbd strings
drbd: kerneldoc warning fix in w_e_end_data_req()
drbd: use unsigned for one bit fields
drbd: use bool for peer is_ states
drbd: fix typo
drbd: use | for bitmask combination
drbd: use true/false for bool
drbd: fix drbd_bm_init() comments
drbd: introduce peer state union
drbd: fix maybe_pull_ahead() locking comments
drbd: use bool for growing
drbd: remove redundant declarations
drbd: replace if/BUG by BUG_ON

Signed-off-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c   |  6 +++---
 drivers/block/drbd/drbd_debugfs.c  |  2 +-
 drivers/block/drbd/drbd_int.h      |  4 +---
 drivers/block/drbd/drbd_interval.h | 14 +++++++-------
 drivers/block/drbd/drbd_main.c     |  2 +-
 drivers/block/drbd/drbd_nl.c       | 14 ++++++++------
 drivers/block/drbd/drbd_proc.c     | 30 +++++++++++++++---------------
 drivers/block/drbd/drbd_receiver.c |  8 ++++----
 drivers/block/drbd/drbd_req.c      |  2 +-
 drivers/block/drbd/drbd_state.c    |  4 +---
 drivers/block/drbd/drbd_state.h    |  2 +-
 drivers/block/drbd/drbd_strings.c  |  8 ++++----
 drivers/block/drbd/drbd_worker.c   |  9 ++++-----
 include/linux/drbd.h               |  8 ++++++++
 14 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 92d6fc0..17e5e60 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -427,8 +427,7 @@ static struct page **bm_realloc_pages(struct drbd_bitmap *b, unsigned long want)
 }
 
 /*
- * called on driver init only. TODO call when a device is created.
- * allocates the drbd_bitmap, and stores it in device->bitmap.
+ * allocates the drbd_bitmap and stores it in device->bitmap.
  */
 int drbd_bm_init(struct drbd_device *device)
 {
@@ -633,7 +632,8 @@ int drbd_bm_resize(struct drbd_device *device, sector_t capacity, int set_new_bi
 	unsigned long bits, words, owords, obits;
 	unsigned long want, have, onpages; /* number of pages */
 	struct page **npages, **opages = NULL;
-	int err = 0, growing;
+	int err = 0;
+	bool growing;
 
 	if (!expect(b))
 		return -ENOMEM;
diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 8a90812..be91a8d 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -903,7 +903,7 @@ static int drbd_version_open(struct inode *inode, struct file *file)
 	return single_open(file, drbd_version_show, NULL);
 }
 
-static struct file_operations drbd_version_fops = {
+static const struct file_operations drbd_version_fops = {
 	.owner = THIS_MODULE,
 	.open = drbd_version_open,
 	.llseek = seq_lseek,
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index cb47809..acb1462 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1499,7 +1499,7 @@ extern enum drbd_state_rv drbd_set_role(struct drbd_device *device,
 					int force);
 extern bool conn_try_outdate_peer(struct drbd_connection *connection);
 extern void conn_try_outdate_peer_async(struct drbd_connection *connection);
-extern int conn_khelper(struct drbd_connection *connection, char *cmd);
+extern enum drbd_peer_state conn_khelper(struct drbd_connection *connection, char *cmd);
 extern int drbd_khelper(struct drbd_device *device, char *cmd);
 
 /* drbd_worker.c */
@@ -1648,8 +1648,6 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 /* drbd_proc.c */
 extern struct proc_dir_entry *drbd_proc;
 extern const struct file_operations drbd_proc_fops;
-extern const char *drbd_conn_str(enum drbd_conns s);
-extern const char *drbd_role_str(enum drbd_role s);
 
 /* drbd_actlog.c */
 extern bool drbd_al_begin_io_prepare(struct drbd_device *device, struct drbd_interval *i);
diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd_interval.h
index f210543..23c5a94 100644
--- a/drivers/block/drbd/drbd_interval.h
+++ b/drivers/block/drbd/drbd_interval.h
@@ -6,13 +6,13 @@
 
 struct drbd_interval {
 	struct rb_node rb;
-	sector_t sector;	/* start sector of the interval */
-	unsigned int size;	/* size in bytes */
-	sector_t end;		/* highest interval end in subtree */
-	int local:1		/* local or remote request? */;
-	int waiting:1;		/* someone is waiting for this to complete */
-	int completed:1;	/* this has been completed already;
-				 * ignore for conflict detection */
+	sector_t sector;		/* start sector of the interval */
+	unsigned int size;		/* size in bytes */
+	sector_t end;			/* highest interval end in subtree */
+	unsigned int local:1		/* local or remote request? */;
+	unsigned int waiting:1;		/* someone is waiting for completion */
+	unsigned int completed:1;	/* this has been completed already;
+					 * ignore for conflict detection */
 };
 
 static inline void drbd_clear_interval(struct drbd_interval *i)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 55b83f8..e4e8e9f 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -31,7 +31,7 @@
 #include <linux/module.h>
 #include <linux/jiffies.h>
 #include <linux/drbd.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/types.h>
 #include <net/sock.h>
 #include <linux/ctype.h>
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 9a45c80..f35db29 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -387,7 +387,7 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 	return ret;
 }
 
-int conn_khelper(struct drbd_connection *connection, char *cmd)
+enum drbd_peer_state conn_khelper(struct drbd_connection *connection, char *cmd)
 {
 	char *envp[] = { "HOME=/",
 			"TERM=linux",
@@ -503,17 +503,17 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 	r = conn_khelper(connection, "fence-peer");
 
 	switch ((r>>8) & 0xff) {
-	case 3: /* peer is inconsistent */
+	case P_INCONSISTENT: /* peer is inconsistent */
 		ex_to_string = "peer is inconsistent or worse";
 		mask.pdsk = D_MASK;
 		val.pdsk = D_INCONSISTENT;
 		break;
-	case 4: /* peer got outdated, or was already outdated */
+	case P_OUTDATED: /* peer got outdated, or was already outdated */
 		ex_to_string = "peer was fenced";
 		mask.pdsk = D_MASK;
 		val.pdsk = D_OUTDATED;
 		break;
-	case 5: /* peer was down */
+	case P_DOWN: /* peer was down */
 		if (conn_highest_disk(connection) == D_UP_TO_DATE) {
 			/* we will(have) create(d) a new UUID anyways... */
 			ex_to_string = "peer is unreachable, assumed to be dead";
@@ -523,7 +523,7 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 			ex_to_string = "peer unreachable, doing nothing since disk != UpToDate";
 		}
 		break;
-	case 6: /* Peer is primary, voluntarily outdate myself.
+	case P_PRIMARY: /* Peer is primary, voluntarily outdate myself.
 		 * This is useful when an unconnected R_SECONDARY is asked to
 		 * become R_PRIMARY, but finds the other peer being active. */
 		ex_to_string = "peer is active";
@@ -531,7 +531,9 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 		mask.disk = D_MASK;
 		val.disk = D_OUTDATED;
 		break;
-	case 7:
+	case P_FENCING:
+		/* THINK: do we need to handle this
+		 * like case 4, or more like case 5? */
 		if (fp != FP_STONITH)
 			drbd_err(connection, "fence-peer() = 7 && fencing != Stonith !!!\n");
 		ex_to_string = "peer was stonithed";
diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 6537b25..be2b93f 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -25,7 +25,7 @@
 
 #include <linux/module.h>
 
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/proc_fs.h>
@@ -122,18 +122,18 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 
 	x = res/50;
 	y = 20-x;
-	seq_printf(seq, "\t[");
+	seq_puts(seq, "\t[");
 	for (i = 1; i < x; i++)
-		seq_printf(seq, "=");
-	seq_printf(seq, ">");
+		seq_putc(seq, '=');
+	seq_putc(seq, '>');
 	for (i = 0; i < y; i++)
 		seq_printf(seq, ".");
-	seq_printf(seq, "] ");
+	seq_puts(seq, "] ");
 
 	if (state.conn == C_VERIFY_S || state.conn == C_VERIFY_T)
-		seq_printf(seq, "verified:");
+		seq_puts(seq, "verified:");
 	else
-		seq_printf(seq, "sync'ed:");
+		seq_puts(seq, "sync'ed:");
 	seq_printf(seq, "%3u.%u%% ", res / 10, res % 10);
 
 	/* if more than a few GB, display in MB */
@@ -146,7 +146,7 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 			    (unsigned long) Bit2KB(rs_left),
 			    (unsigned long) Bit2KB(rs_total));
 
-	seq_printf(seq, "\n\t");
+	seq_puts(seq, "\n\t");
 
 	/* see drivers/md/md.c
 	 * We do not want to overflow, so the order of operands and
@@ -175,9 +175,9 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 		rt / 3600, (rt % 3600) / 60, rt % 60);
 
 	dbdt = Bit2KB(db/dt);
-	seq_printf(seq, " speed: ");
+	seq_puts(seq, " speed: ");
 	seq_printf_with_thousands_grouping(seq, dbdt);
-	seq_printf(seq, " (");
+	seq_puts(seq, " (");
 	/* ------------------------- ~3s average ------------------------ */
 	if (proc_details >= 1) {
 		/* this is what drbd_rs_should_slow_down() uses */
@@ -188,7 +188,7 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 		db = device->rs_mark_left[i] - rs_left;
 		dbdt = Bit2KB(db/dt);
 		seq_printf_with_thousands_grouping(seq, dbdt);
-		seq_printf(seq, " -- ");
+		seq_puts(seq, " -- ");
 	}
 
 	/* --------------------- long term average ---------------------- */
@@ -200,11 +200,11 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 	db = rs_total - rs_left;
 	dbdt = Bit2KB(db/dt);
 	seq_printf_with_thousands_grouping(seq, dbdt);
-	seq_printf(seq, ")");
+	seq_putc(seq, ')');
 
 	if (state.conn == C_SYNC_TARGET ||
 	    state.conn == C_VERIFY_S) {
-		seq_printf(seq, " want: ");
+		seq_puts(seq, " want: ");
 		seq_printf_with_thousands_grouping(seq, device->c_sync_rate);
 	}
 	seq_printf(seq, " K/sec%s\n", stalled ? " (stalled)" : "");
@@ -231,7 +231,7 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 			(unsigned long long)bm_bits * BM_SECT_PER_BIT);
 		if (stop_sector != 0 && stop_sector != ULLONG_MAX)
 			seq_printf(seq, " stop sector: %llu", stop_sector);
-		seq_printf(seq, "\n");
+		seq_putc(seq, '\n');
 	}
 }
 
@@ -276,7 +276,7 @@ static int drbd_seq_show(struct seq_file *seq, void *v)
 	rcu_read_lock();
 	idr_for_each_entry(&drbd_devices, device, i) {
 		if (prev_i != i - 1)
-			seq_printf(seq, "\n");
+			seq_putc(seq, '\n');
 		prev_i = i;
 
 		state = device->state;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 8e7afa3..5c06286 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -25,7 +25,7 @@
 
 #include <linux/module.h>
 
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <net/sock.h>
 
 #include <linux/drbd.h>
@@ -2286,13 +2286,13 @@ static inline int overlaps(sector_t s1, int l1, sector_t s2, int l2)
 static bool overlapping_resync_write(struct drbd_device *device, struct drbd_peer_request *peer_req)
 {
 	struct drbd_peer_request *rs_req;
-	bool rv = 0;
+	bool rv = false;
 
 	spin_lock_irq(&device->resource->req_lock);
 	list_for_each_entry(rs_req, &device->sync_ee, w.list) {
 		if (overlaps(peer_req->i.sector, peer_req->i.size,
 			     rs_req->i.sector, rs_req->i.size)) {
-			rv = 1;
+			rv = true;
 			break;
 		}
 	}
@@ -2666,7 +2666,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	}
 
 out_interrupted:
-	drbd_may_finish_epoch(connection, peer_req->epoch, EV_PUT + EV_CLEANUP);
+	drbd_may_finish_epoch(connection, peer_req->epoch, EV_PUT | EV_CLEANUP);
 	put_ldev(device);
 	drbd_free_peer_req(device, peer_req);
 	return err;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 72bb1b1..784b02a 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1000,7 +1000,7 @@ static void complete_conflicting_writes(struct drbd_request *req)
 	finish_wait(&device->misc_wait, &wait);
 }
 
-/* called within req_lock and rcu_read_lock() */
+/* called within req_lock */
 static void maybe_pull_ahead(struct drbd_device *device)
 {
 	struct drbd_connection *connection = first_peer_device(device)->connection;
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index a1b5e6c9..aca68a5 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -2196,9 +2196,7 @@ conn_set_state(struct drbd_connection *connection, union drbd_state mask, union
 			ns.disk = os.disk;
 
 		rv = _drbd_set_state(device, ns, flags, NULL);
-		if (rv < SS_SUCCESS)
-			BUG();
-
+		BUG_ON(rv < SS_SUCCESS);
 		ns.i = device->state.i;
 		ns_max.role = max_role(ns.role, ns_max.role);
 		ns_max.peer = max_role(ns.peer, ns_max.peer);
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index bd98953..6c9d5d4 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -140,7 +140,7 @@ extern void drbd_resume_al(struct drbd_device *device);
 extern bool conn_all_vols_unconf(struct drbd_connection *connection);
 
 /**
- * drbd_request_state() - Reqest a state change
+ * drbd_request_state() - Request a state change
  * @device:	DRBD device.
  * @mask:	mask of state bits to change.
  * @val:	value of new state bits.
diff --git a/drivers/block/drbd/drbd_strings.c b/drivers/block/drbd/drbd_strings.c
index 80b0f63..0eeab14 100644
--- a/drivers/block/drbd/drbd_strings.c
+++ b/drivers/block/drbd/drbd_strings.c
@@ -26,7 +26,7 @@
 #include <linux/drbd.h>
 #include "drbd_strings.h"
 
-static const char *drbd_conn_s_names[] = {
+static const char * const drbd_conn_s_names[] = {
 	[C_STANDALONE]       = "StandAlone",
 	[C_DISCONNECTING]    = "Disconnecting",
 	[C_UNCONNECTED]      = "Unconnected",
@@ -53,13 +53,13 @@ static const char *drbd_conn_s_names[] = {
 	[C_BEHIND]           = "Behind",
 };
 
-static const char *drbd_role_s_names[] = {
+static const char * const drbd_role_s_names[] = {
 	[R_PRIMARY]   = "Primary",
 	[R_SECONDARY] = "Secondary",
 	[R_UNKNOWN]   = "Unknown"
 };
 
-static const char *drbd_disk_s_names[] = {
+static const char * const drbd_disk_s_names[] = {
 	[D_DISKLESS]     = "Diskless",
 	[D_ATTACHING]    = "Attaching",
 	[D_FAILED]       = "Failed",
@@ -71,7 +71,7 @@ static const char *drbd_disk_s_names[] = {
 	[D_UP_TO_DATE]   = "UpToDate",
 };
 
-static const char *drbd_state_sw_errors[] = {
+static const char * const drbd_state_sw_errors[] = {
 	[-SS_TWO_PRIMARIES] = "Multiple primaries not allowed by config",
 	[-SS_NO_UP_TO_DATE_DISK] = "Need access to UpToDate data",
 	[-SS_NO_LOCAL_DISK] = "Can not resync without local disk",
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index ed422a5..9f3c550 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -173,8 +173,8 @@ void drbd_peer_request_endio(struct bio *bio)
 {
 	struct drbd_peer_request *peer_req = bio->bi_private;
 	struct drbd_device *device = peer_req->peer_device->device;
-	int is_write = bio_data_dir(bio) == WRITE;
-	int is_discard = !!(bio->bi_rw & REQ_DISCARD);
+	bool is_write = bio_data_dir(bio) == WRITE;
+	bool is_discard = !!(bio->bi_rw & REQ_DISCARD);
 
 	if (bio->bi_error && __ratelimit(&drbd_ratelimit_state))
 		drbd_warn(device, "%s: error=%d s=%llus\n",
@@ -1038,7 +1038,6 @@ static void move_to_net_ee_or_free(struct drbd_device *device, struct drbd_peer_
 
 /**
  * w_e_end_data_req() - Worker callback, to send a P_DATA_REPLY packet in response to a P_DATA_REQUEST
- * @device:	DRBD device.
  * @w:		work object.
  * @cancel:	The connection will be closed anyways
  */
@@ -1699,7 +1698,7 @@ static bool use_checksum_based_resync(struct drbd_connection *connection, struct
 	rcu_read_unlock();
 	return connection->agreed_pro_version >= 89 &&		/* supported? */
 		connection->csums_tfm &&			/* configured? */
-		(csums_after_crash_only == 0			/* use for each resync? */
+		(csums_after_crash_only == false		/* use for each resync? */
 		 || test_bit(CRASHED_PRIMARY, &device->flags));	/* or only after Primary crash? */
 }
 
@@ -1834,7 +1833,7 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 			device->bm_resync_fo = 0;
 			device->use_csums = use_checksum_based_resync(connection, device);
 		} else {
-			device->use_csums = 0;
+			device->use_csums = false;
 		}
 
 		/* Since protocol 96, we must serialize drbd_gen_and_send_sync_uuid
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index d6b3c99..2b26156 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -370,6 +370,14 @@ enum drbd_notification_type {
 	NOTIFY_FLAGS = NOTIFY_CONTINUES,
 };
 
+enum drbd_peer_state {
+	P_INCONSISTENT = 3,
+	P_OUTDATED = 4,
+	P_DOWN = 5,
+	P_PRIMARY = 6,
+	P_FENCING = 7,
+};
+
 #define UUID_JUST_CREATED ((__u64)4)
 
 enum write_ordering_e {
-- 
2.7.4

