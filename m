Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D4E791056459
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:27 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:44 +0200
Message-Id: <1461586077-11581-18-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 17/30] drbd: don't forget error completion when
	"unsuspending" IO
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

Possibly sequence of events:
SyncTarget is made Primary, then loses replication link
(only path to good data on SyncSource).

Behavior is then controlled by the on-no-data-accessible policy,
which defaults to OND_IO_ERROR (may be set to OND_SUSPEND_IO).

If OND_IO_ERROR is in fact the current policy, we clear the susp_fen
(IO suspended due to fencing policy) flag, do NOT set the susp_nod
(IO suspended due to no data) flag.

But we forgot to call the IO error completion for all pending,
suspended, requests.

While at it, also add a race check for a theoretically possible
race with a new handshake (network hickup), we may be able to
re-send requests, and can avoid passing IO errors up the stack.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 48 +++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f16084a..a703a0e 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -442,19 +442,17 @@ static enum drbd_fencing_p highest_fencing_policy(struct drbd_connection *connec
 	}
 	rcu_read_unlock();
 
-	if (fp == FP_NOT_AVAIL) {
-		/* IO Suspending works on the whole resource.
-		   Do it only for one device. */
-		vnr = 0;
-		peer_device = idr_get_next(&connection->peer_devices, &vnr);
-		drbd_change_state(peer_device->device, CS_VERBOSE | CS_HARD, NS(susp_fen, 0));
-	}
-
 	return fp;
 }
 
+static bool resource_is_supended(struct drbd_resource *resource)
+{
+	return resource->susp || resource->susp_fen || resource->susp_nod;
+}
+
 bool conn_try_outdate_peer(struct drbd_connection *connection)
 {
+	struct drbd_resource * const resource = connection->resource;
 	unsigned int connect_cnt;
 	union drbd_state mask = { };
 	union drbd_state val = { };
@@ -462,21 +460,41 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 	char *ex_to_string;
 	int r;
 
-	spin_lock_irq(&connection->resource->req_lock);
+	spin_lock_irq(&resource->req_lock);
 	if (connection->cstate >= C_WF_REPORT_PARAMS) {
 		drbd_err(connection, "Expected cstate < C_WF_REPORT_PARAMS\n");
-		spin_unlock_irq(&connection->resource->req_lock);
+		spin_unlock_irq(&resource->req_lock);
 		return false;
 	}
 
 	connect_cnt = connection->connect_cnt;
-	spin_unlock_irq(&connection->resource->req_lock);
+	spin_unlock_irq(&resource->req_lock);
 
 	fp = highest_fencing_policy(connection);
 	switch (fp) {
 	case FP_NOT_AVAIL:
 		drbd_warn(connection, "Not fencing peer, I'm not even Consistent myself.\n");
-		goto out;
+		spin_lock_irq(&resource->req_lock);
+		if (connection->cstate < C_WF_REPORT_PARAMS) {
+			_conn_request_state(connection,
+					    (union drbd_state) { { .susp_fen = 1 } },
+					    (union drbd_state) { { .susp_fen = 0 } },
+					    CS_VERBOSE | CS_HARD | CS_DC_SUSP);
+			/* We are no longer suspended due to the fencing policy.
+			 * We may still be suspended due to the on-no-data-accessible policy.
+			 * If that was OND_IO_ERROR, fail pending requests. */
+			if (!resource_is_supended(resource))
+				_tl_restart(connection, CONNECTION_LOST_WHILE_PENDING);
+		}
+		/* Else: in case we raced with a connection handshake,
+		 * let the handshake figure out if we maybe can RESEND,
+		 * and do not resume/fail pending requests here.
+		 * Worst case is we stay suspended for now, which may be
+		 * resolved by either re-establishing the replication link, or
+		 * the next link failure, or eventually the administrator.  */
+		spin_unlock_irq(&resource->req_lock);
+		return false;
+
 	case FP_DONT_CARE:
 		return true;
 	default: ;
@@ -529,13 +547,11 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 	drbd_info(connection, "fence-peer helper returned %d (%s)\n",
 		  (r>>8) & 0xff, ex_to_string);
 
- out:
-
 	/* Not using
 	   conn_request_state(connection, mask, val, CS_VERBOSE);
 	   here, because we might were able to re-establish the connection in the
 	   meantime. */
-	spin_lock_irq(&connection->resource->req_lock);
+	spin_lock_irq(&resource->req_lock);
 	if (connection->cstate < C_WF_REPORT_PARAMS && !test_bit(STATE_SENT, &connection->flags)) {
 		if (connection->connect_cnt != connect_cnt)
 			/* In case the connection was established and droped
@@ -544,7 +560,7 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 		else
 			_conn_request_state(connection, mask, val, CS_VERBOSE);
 	}
-	spin_unlock_irq(&connection->resource->req_lock);
+	spin_unlock_irq(&resource->req_lock);
 
 	return conn_highest_pdsk(connection) <= D_OUTDATED;
 }
-- 
1.9.1

