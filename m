Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:28 +0200
Message-Id: <1398703415-17780-18-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 17/24] drbd: add back some fairness to AL
	transactions
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

When batching more updates to the activity log into single transactions,
we lost the ability for new requests to force themselves into the active
set: all preparation steps became non-blocking, and if all currently
hot extents keep busy, they could starve out new incoming requests
to cold extents for quite a while.

This can only happen if your IO backend accepts more IO operations per
average DRBD replication round trip time than you have al-extents
configured.

If we have incoming requests to cold extents,
at least do one blocking update per transaction.

In an artificial worst-case workload on SSD with an asynchronous 600 ms
replication link, with al-extents = 7 (the minimum we allow), and
concurrent full resynch, without this patch, some write requests have
been observed to be starved for 40 seconds.
With this patch, application observed a worst case latency of twice the
replication round trip time.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c |  3 +--
 drivers/block/drbd/drbd_int.h    |  1 +
 drivers/block/drbd/drbd_req.c    | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 8fc5d71..05a1780 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -203,7 +203,7 @@ int drbd_md_sync_page_io(struct drbd_device *device, struct drbd_backing_dev *bd
 
 	BUG_ON(!bdev->md_bdev);
 
-	drbd_dbg(device, "meta_data io: %s [%d]:%s(,%llus,%s) %pS\n",
+	dynamic_drbd_dbg(device, "meta_data io: %s [%d]:%s(,%llus,%s) %pS\n",
 	     current->comm, current->pid, __func__,
 	     (unsigned long long)sector, (rw & WRITE) ? "WRITE" : "READ",
 	     (void*)_RET_IP_ );
@@ -275,7 +275,6 @@ bool drbd_al_begin_io_fastpath(struct drbd_device *device, struct drbd_interval
 	return _al_get(device, first, true);
 }
 
-static
 bool drbd_al_begin_io_prepare(struct drbd_device *device, struct drbd_interval *i)
 {
 	/* for bios crossing activity log extent boundaries,
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d5f39fd..297ba40 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1487,6 +1487,7 @@ extern const char *drbd_conn_str(enum drbd_conns s);
 extern const char *drbd_role_str(enum drbd_role s);
 
 /* drbd_actlog.c */
+extern bool drbd_al_begin_io_prepare(struct drbd_device *device, struct drbd_interval *i);
 extern int drbd_al_begin_io_nonblock(struct drbd_device *device, struct drbd_interval *i);
 extern void drbd_al_begin_io_commit(struct drbd_device *device, bool delegate);
 extern bool drbd_al_begin_io_fastpath(struct drbd_device *device, struct drbd_interval *i);
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 7aadd09..99411bf 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1242,6 +1242,7 @@ void do_submit(struct work_struct *ws)
 		if (list_empty(&incoming))
 			break;
 
+skip_fast_path:
 		wait_event(device->al_wait, prepare_al_transaction_nonblock(device, &incoming, &pending));
 		/* Maybe more was queued, while we prepared the transaction?
 		 * Try to stuff them into this transaction as well.
@@ -1280,6 +1281,25 @@ void do_submit(struct work_struct *ws)
 			list_del_init(&req->tl_requests);
 			drbd_send_and_submit(device, req);
 		}
+
+		/* If all currently hot activity log extents are kept busy by
+		 * incoming requests, we still must not totally starve new
+		 * requests to cold extents. In that case, prepare one request
+		 * in blocking mode. */
+		list_for_each_entry_safe(req, tmp, &incoming, tl_requests) {
+			list_del_init(&req->tl_requests);
+			req->rq_state |= RQ_IN_ACT_LOG;
+			if (!drbd_al_begin_io_prepare(device, &req->i)) {
+				/* Corresponding extent was hot after all? */
+				drbd_send_and_submit(device, req);
+			} else {
+				/* Found a request to a cold extent.
+				 * Put on "pending" list,
+				 * and try to cumulate with more. */
+				list_add(&req->tl_requests, &pending);
+				goto skip_fast_path;
+			}
+		}
 	}
 }
 
-- 
1.9.1

