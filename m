Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 510541057584
	for <drbd-dev@lists.linbit.com>; Tue, 16 Jan 2018 00:52:28 +0100 (CET)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: drbd-dev@lists.linbit.com
Date: Mon, 15 Jan 2018 15:52:15 -0800
Message-Id: <1516060335-27029-1-git-send-email-drbd-dev@lists.ewheeler.net>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Eric Wheeler <drbd@linux.ewheeler.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Eric Wheeler <git@linux.ewheeler.net>, linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH] drbd: standardize kthread/workqueue thread
	naming to include drbd minor number
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

From: Eric Wheeler <git@linux.ewheeler.net>

For DRBD resources with long names that start with the same prefix,
it was difficult to find all process pids for that minor since names
are truncated to the task_struct's comm field (16 bytes).

This patch names all processes associated with a DRBD device as drbdN_*
where N is the DRBD minor in the same ways that the drbdN_submit workqueue
is named.  Userspace tools can then lookup the name=>minor=>pid mapping
and for all pids and use tools like chrt, ioprio, nice, add pids to
cgroups, or for other useful purpose.

Signed-off-by: Eric Wheeler <drbd@linux.ewheeler.net>
---
 drivers/block/drbd/drbd_main.c     | 31 +++++++++++++++++++++++++++++--
 drivers/block/drbd/drbd_receiver.c | 19 +++++++++++++++++--
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 8cb3791..c5444b3 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -330,7 +330,21 @@ static int drbd_thread_setup(void *arg)
 	unsigned long flags;
 	int retval;
 
-	snprintf(current->comm, sizeof(current->comm), "drbd_%c_%s",
+	int i, minor = -1;
+	struct drbd_device *device;
+
+	idr_for_each_entry(&resource->devices, device, i) {
+		if (minor >= 0 && minor != device->minor)
+			pr_err("drbd: %s(%s): minor is different.  was %d is now %d\n",
+				__func__,
+				resource->name,
+				minor, device->minor);
+
+		minor = device->minor;
+	}
+
+	snprintf(current->comm, sizeof(current->comm), "drbd%d_%c_%s",
+		 minor,
 		 thi->name[0],
 		 resource->name);
 
@@ -389,6 +403,8 @@ int drbd_thread_start(struct drbd_thread *thi)
 {
 	struct drbd_resource *resource = thi->resource;
 	struct task_struct *nt;
+	struct drbd_device *device;
+	int i, minor = -1;
 	unsigned long flags;
 
 	/* is used from state engine doing drbd_thread_stop_nowait,
@@ -417,8 +433,19 @@ int drbd_thread_start(struct drbd_thread *thi)
 		spin_unlock_irqrestore(&thi->t_lock, flags);
 		flush_signals(current); /* otherw. may get -ERESTARTNOINTR */
 
+		idr_for_each_entry(&resource->devices, device, i) {
+			if (minor >= 0 && minor != device->minor)
+				pr_err("drbd: drbd_thread_start(%s, %s): minor is different.  was %d is now %d\n",
+					thi->name,
+					thi->resource->name,
+					minor, device->minor);
+
+			minor = device->minor;
+		}
+
 		nt = kthread_create(drbd_thread_setup, (void *) thi,
-				    "drbd_%c_%s", thi->name[0], thi->resource->name);
+				    "drbd%d_%c_%s",
+				    minor, thi->name[0], thi->resource->name);
 
 		if (IS_ERR(nt)) {
 			drbd_err(resource, "Couldn't start thread\n");
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 796eaf3..62a902f 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -934,7 +934,7 @@ static int conn_connect(struct drbd_connection *connection)
 	struct drbd_socket sock, msock;
 	struct drbd_peer_device *peer_device;
 	struct net_conf *nc;
-	int vnr, timeout, h;
+	int vnr, timeout, h, i, minor = -1;
 	bool discard_my_data, ok;
 	enum drbd_state_rv rv;
 	struct accept_wait_data ad = {
@@ -1132,10 +1132,25 @@ static int conn_connect(struct drbd_connection *connection)
 	}
 
 	drbd_thread_start(&connection->ack_receiver);
+
+	if (connection->resource) {
+		struct drbd_device *device;
+
+		idr_for_each_entry(&connection->resource->devices, device, i) {
+			if (minor >= 0 && minor != device->minor)
+				pr_err("drbd: conn_connect(%s): minor is different.  was %d is now %d\n",
+					connection->resource->name,
+					minor, device->minor);
+
+			minor = device->minor;
+		}
+	}
 	/* opencoded create_singlethread_workqueue(),
 	 * to be able to use format string arguments */
 	connection->ack_sender =
-		alloc_ordered_workqueue("drbd_as_%s", WQ_MEM_RECLAIM, connection->resource->name);
+		alloc_ordered_workqueue("drbd%d_as_%s",
+		WQ_MEM_RECLAIM,	minor, connection->resource->name);
+
 	if (!connection->ack_sender) {
 		drbd_err(connection, "Failed to create workqueue ack_sender\n");
 		return 0;
-- 
1.8.3.1

