Return-Path: <yanzhen@vivo.com>
Received: from APC01-PSA-obe.outbound.protection.outlook.com
	(mail-psaapc01on2080.outbound.protection.outlook.com [40.107.255.80])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 00C08420312
	for <drbd-dev@lists.linbit.com>; Fri, 27 Sep 2024 12:31:09 +0200 (CEST)
From: Yan Zhen <yanzhen@vivo.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, axboe@kernel.dk
Subject: [PATCH v1] drbd: Fix typos in the comment
Date: Fri, 27 Sep 2024 17:57:35 +0800
Message-Id: <20240927095735.228661-1-yanzhen@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Cc: linux-block@vger.kernel.org, opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
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

Correctly spelled comments make it easier for the reader to understand
the code.

Fix typos:
'mutliple' ==> 'multiple',
'droped' ==> 'dropped',
'Suprisingly' ==> 'Surprisingly',
'chage' ==> 'change',
'typicaly' ==> 'typically',
'progres' ==> 'progress',
'catched' ==> 'caught',
'protocoll' ==> 'protocol',
'stroage' ==> 'storage',
'independend' ==> 'independent'.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/block/drbd/drbd_debugfs.c | 2 +-
 drivers/block/drbd/drbd_nl.c      | 6 +++---
 drivers/block/drbd/drbd_req.c     | 8 ++++----
 drivers/block/drbd/drbd_vli.h     | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 12460b584bcb..c116c4f93eea 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -622,7 +622,7 @@ void drbd_debugfs_connection_add(struct drbd_connection *connection)
 	struct dentry *conns_dir = connection->resource->debugfs_res_connections;
 	struct dentry *dentry;
 
-	/* Once we enable mutliple peers,
+	/* Once we enable multiple peers,
 	 * these connections will have descriptive names.
 	 * For now, it is just the one connection to the (only) "peer". */
 	dentry = debugfs_create_dir("peer", conns_dir);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 5d65c9754d83..4b1876baf472 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -572,7 +572,7 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 	spin_lock_irq(&resource->req_lock);
 	if (connection->cstate < C_WF_REPORT_PARAMS && !test_bit(STATE_SENT, &connection->flags)) {
 		if (connection->connect_cnt != connect_cnt)
-			/* In case the connection was established and droped
+			/* In case the connection was established and dropped
 			   while the fence-peer handler was running, ignore it */
 			drbd_info(connection, "Ignoring fence-peer exit code\n");
 		else
@@ -3918,7 +3918,7 @@ static int get_one_status(struct sk_buff *skb, struct netlink_callback *cb)
 
 		if (!device) {
 			/* This is a connection without a single volume.
-			 * Suprisingly enough, it may have a network
+			 * Surprisingly enough, it may have a network
 			 * configuration. */
 			struct drbd_connection *connection;
 
@@ -4852,7 +4852,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 	int err = 0;
 
 	/* There is no need for taking notification_mutex here: it doesn't
-	   matter if the initial state events mix with later state chage
+	   matter if the initial state events mix with later state change
 	   events; we can always tell the events apart by the NOTIFY_EXISTS
 	   flag. */
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 380e6584a4ee..9ecdaac20e1f 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -85,7 +85,7 @@ void drbd_req_destroy(struct kref *kref)
 
 	/* If called from mod_rq_state (expected normal case) or
 	 * drbd_send_and_submit (the less likely normal path), this holds the
-	 * req_lock, and req->tl_requests will typicaly be on ->transfer_log,
+	 * req_lock, and req->tl_requests will typically be on ->transfer_log,
 	 * though it may be still empty (never added to the transfer log).
 	 *
 	 * If called from do_retry(), we do NOT hold the req_lock, but we are
@@ -1575,7 +1575,7 @@ void do_submit(struct work_struct *ws)
 		 * Be strictly non-blocking here,
 		 * we already have something to commit.
 		 *
-		 * Commit if we don't make any more progres.
+		 * Commit if we don't make any more progress.
 		 */
 
 		while (list_empty(&incoming)) {
@@ -1689,7 +1689,7 @@ static bool net_timeout_reached(struct drbd_request *net_req,
  * - the connection was established (resp. disk was attached)
  *   for longer than the timeout already.
  * Note that for 32bit jiffies and very stable connections/disks,
- * we may have a wrap around, which is catched by
+ * we may have a wrap around, which is caught by
  *   !time_in_range(now, last_..._jif, last_..._jif + timeout).
  *
  * Side effect: once per 32bit wrap-around interval, which means every
@@ -1745,7 +1745,7 @@ void request_timer_fn(struct timer_list *t)
 	 * but which is still waiting for an ACK. */
 	req_peer = connection->req_ack_pending;
 
-	/* if we don't have such request (e.g. protocoll A)
+	/* if we don't have such request (e.g. protocol A)
 	 * check the oldest requests which is still waiting on its epoch
 	 * closing barrier ack. */
 	if (!req_peer)
diff --git a/drivers/block/drbd/drbd_vli.h b/drivers/block/drbd/drbd_vli.h
index 941c511cc4da..aa78a55aa1af 100644
--- a/drivers/block/drbd/drbd_vli.h
+++ b/drivers/block/drbd/drbd_vli.h
@@ -15,7 +15,7 @@
 
 /*
  * At a granularity of 4KiB storage represented per bit,
- * and stroage sizes of several TiB,
+ * and storage sizes of several TiB,
  * and possibly small-bandwidth replication,
  * the bitmap transfer time can take much too long,
  * if transmitted in plain text.
@@ -179,7 +179,7 @@ static inline int __vli_encode_bits(u64 *out, const u64 in)
 
 #undef VLI_L_1_1
 
-/* code from here down is independend of actually used bit code */
+/* code from here down is independent of actually used bit code */
 
 /*
  * Code length is determined by some unique (e.g. unary) prefix.
-- 
2.34.1

