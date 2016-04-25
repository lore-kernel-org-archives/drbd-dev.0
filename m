Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 93D351056458
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:27 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:43 +0200
Message-Id: <1461586077-11581-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/30] drbd: introduce unfence-peer handler
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

From: Lars Ellenberg <lars@linbit.com>

When resync is finished, we already call the "after-resync-target"
handler (on the former sync target, obviously), once per volume.

Paired with the before-resync-target handler, you can create snapshots,
before the resync causes the volumes to become inconsistent,
and discard those snapshots again, once they are no longer needed.

It was also overloaded to be paired with the "fence-peer" handler,
to "unfence" once the volumes are up-to-date and known good.

This has some disadvantages, though: we call "fence-peer" for the whole
connection (once for the group of volumes), but would call unfence as
side-effect of after-resync-target once for each volume.

Also, we fence on a (current, or about to become) Primary,
which will later become the sync-source.

Calling unfence only as a side effect of the after-resync-target
handler opens a race window, between a new fence on the Primary
(SyncTarget) and the unfence on the SyncTarget, which is difficult to
close without some kind of "cluster wide lock" in those handlers.

We would not need those handlers if we could still communicate.
Which makes trying to aquire a cluster wide lock from those handlers
seem like a very bad idea.

This introduces the "unfence-peer" handler, which will be called
per connection (once for the group of volumes), just like the fence
handler, only once all volumes are back in sync, and on the SyncSource.

Which is expected to be the node that previously called "fence", the
node that is currently allowed to be Primary, and thus the only node
that could trigger a new "fence" that could race with this unfence.

Which makes us not need any cluster wide synchronization here,
serializing two scripts running on the same node is trivial.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h    |  1 +
 drivers/block/drbd/drbd_nl.c     |  2 +-
 drivers/block/drbd/drbd_worker.c | 28 ++++++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 451a745..cb42f6c 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1494,6 +1494,7 @@ extern enum drbd_state_rv drbd_set_role(struct drbd_device *device,
 					int force);
 extern bool conn_try_outdate_peer(struct drbd_connection *connection);
 extern void conn_try_outdate_peer_async(struct drbd_connection *connection);
+extern int conn_khelper(struct drbd_connection *connection, char *cmd);
 extern int drbd_khelper(struct drbd_device *device, char *cmd);
 
 /* drbd_worker.c */
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f335549..f16084a 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -387,7 +387,7 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 	return ret;
 }
 
-static int conn_khelper(struct drbd_connection *connection, char *cmd)
+int conn_khelper(struct drbd_connection *connection, char *cmd)
 {
 	char *envp[] = { "HOME=/",
 			"TERM=linux",
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index fa63c22..f9e142d 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -839,6 +839,7 @@ static void ping_peer(struct drbd_device *device)
 
 int drbd_resync_finished(struct drbd_device *device)
 {
+	struct drbd_connection *connection = first_peer_device(device)->connection;
 	unsigned long db, dt, dbdt;
 	unsigned long n_oos;
 	union drbd_state os, ns;
@@ -860,8 +861,7 @@ int drbd_resync_finished(struct drbd_device *device)
 		if (dw) {
 			dw->w.cb = w_resync_finished;
 			dw->device = device;
-			drbd_queue_work(&first_peer_device(device)->connection->sender_work,
-					&dw->w);
+			drbd_queue_work(&connection->sender_work, &dw->w);
 			return 1;
 		}
 		drbd_err(device, "Warn failed to drbd_rs_del_all() and to kmalloc(dw).\n");
@@ -974,6 +974,30 @@ int drbd_resync_finished(struct drbd_device *device)
 	_drbd_set_state(device, ns, CS_VERBOSE, NULL);
 out_unlock:
 	spin_unlock_irq(&device->resource->req_lock);
+
+	/* If we have been sync source, and have an effective fencing-policy,
+	 * once *all* volumes are back in sync, call "unfence". */
+	if (os.conn == C_SYNC_SOURCE) {
+		enum drbd_disk_state disk_state = D_MASK;
+		enum drbd_disk_state pdsk_state = D_MASK;
+		enum drbd_fencing_p fp = FP_DONT_CARE;
+
+		rcu_read_lock();
+		fp = rcu_dereference(device->ldev->disk_conf)->fencing;
+		if (fp != FP_DONT_CARE) {
+			struct drbd_peer_device *peer_device;
+			int vnr;
+			idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+				struct drbd_device *device = peer_device->device;
+				disk_state = min_t(enum drbd_disk_state, disk_state, device->state.disk);
+				pdsk_state = min_t(enum drbd_disk_state, pdsk_state, device->state.pdsk);
+			}
+		}
+		rcu_read_unlock();
+		if (disk_state == D_UP_TO_DATE && pdsk_state == D_UP_TO_DATE)
+			conn_khelper(connection, "unfence-peer");
+	}
+
 	put_ldev(device);
 out:
 	device->rs_total  = 0;
-- 
1.9.1

