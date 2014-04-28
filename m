Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:24 +0200
Message-Id: <1398703415-17780-14-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/24] drbd: prepare sending side for REQ_DISCARD
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

Note that I do NOT call __drbd_chk_io_error for failed REQ_DISCARD.
That may be wrong, though, or needs to differ between EOPNOTSUPP and
other errors...

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c   | 15 +++++++++++++--
 drivers/block/drbd/drbd_req.c    |  7 +++++++
 drivers/block/drbd/drbd_req.h    |  5 ++++-
 drivers/block/drbd/drbd_worker.c |  7 ++++++-
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 05db597..960645c 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1607,8 +1607,8 @@ static u32 bio_flags_to_wire(struct drbd_connection *connection, unsigned long b
 		return bi_rw & REQ_SYNC ? DP_RW_SYNC : 0;
 }
 
-/* Used to send write requests
- * R_PRIMARY -> Peer	(P_DATA)
+/* Used to send write or TRIM aka REQ_DISCARD requests
+ * R_PRIMARY -> Peer	(P_DATA, P_TRIM)
  */
 int drbd_send_dblock(struct drbd_peer_device *peer_device, struct drbd_request *req)
 {
@@ -1640,6 +1640,16 @@ int drbd_send_dblock(struct drbd_peer_device *peer_device, struct drbd_request *
 			dp_flags |= DP_SEND_WRITE_ACK;
 	}
 	p->dp_flags = cpu_to_be32(dp_flags);
+
+	if (dp_flags & DP_DISCARD) {
+		struct p_trim *t = (struct p_trim*)p;
+		t->size = cpu_to_be32(req->i.size);
+		err = __send_command(peer_device->connection, device->vnr, sock, P_TRIM, sizeof(*t), NULL, 0);
+		goto out;
+	}
+
+	/* our digest is still only over the payload.
+	 * TRIM does not carry any payload. */
 	if (dgs)
 		drbd_csum_bio(peer_device->connection->integrity_tfm, req->master_bio, p + 1);
 	err = __send_command(peer_device->connection, device->vnr, sock, P_DATA, sizeof(*p) + dgs, NULL, req->i.size);
@@ -1675,6 +1685,7 @@ int drbd_send_dblock(struct drbd_peer_device *peer_device, struct drbd_request *
 		     ... Be noisy about digest too large ...
 		} */
 	}
+out:
 	mutex_unlock(&sock->mutex);  /* locked by drbd_prepare_command() */
 
 	return err;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 3779c8d..7aadd09 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -522,6 +522,13 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		mod_rq_state(req, m, RQ_LOCAL_PENDING, RQ_LOCAL_COMPLETED);
 		break;
 
+	case DISCARD_COMPLETED_NOTSUPP:
+	case DISCARD_COMPLETED_WITH_ERROR:
+		/* I'd rather not detach from local disk just because it
+		 * failed a REQ_DISCARD. */
+		mod_rq_state(req, m, RQ_LOCAL_PENDING, RQ_LOCAL_COMPLETED);
+		break;
+
 	case QUEUE_FOR_NET_READ:
 		/* READ or READA, and
 		 * no local disk,
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index 07cc8e8..8566cd5 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -110,11 +110,14 @@ enum drbd_req_event {
 	BARRIER_ACKED, /* in protocol A and B */
 	DATA_RECEIVED, /* (remote read) */
 
+	COMPLETED_OK,
 	READ_COMPLETED_WITH_ERROR,
 	READ_AHEAD_COMPLETED_WITH_ERROR,
 	WRITE_COMPLETED_WITH_ERROR,
+	DISCARD_COMPLETED_NOTSUPP,
+	DISCARD_COMPLETED_WITH_ERROR,
+
 	ABORT_DISK_IO,
-	COMPLETED_OK,
 	RESEND,
 	FAIL_FROZEN_DISK_IO,
 	RESTART_FROZEN_DISK_IO,
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 5fd4eae..26338be 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -267,7 +267,12 @@ void drbd_request_endio(struct bio *bio, int error)
 
 	/* to avoid recursion in __req_mod */
 	if (unlikely(error)) {
-		what = (bio_data_dir(bio) == WRITE)
+		if (bio->bi_rw & REQ_DISCARD)
+			what = (error == -EOPNOTSUPP)
+				? DISCARD_COMPLETED_NOTSUPP
+				: DISCARD_COMPLETED_WITH_ERROR;
+		else
+			what = (bio_data_dir(bio) == WRITE)
 			? WRITE_COMPLETED_WITH_ERROR
 			: (bio_rw(bio) == READ)
 			  ? READ_COMPLETED_WITH_ERROR
-- 
1.9.1

