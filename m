Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:13 +0200
Message-Id: <1398703415-17780-3-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/24] drbd: Leave IO suspended if the fence
	handler find the peer primary
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

Actually we are clearing the susp_fen flag if we are not going
to call a fencing handler.

For setting the susp_fen flag needs to be edge-triggerd, and not
level triggered.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c    |  8 ++++++++
 drivers/block/drbd/drbd_state.c | 24 +++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 526414b..5ccbd71 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -426,6 +426,14 @@ static enum drbd_fencing_p highest_fencing_policy(struct drbd_connection *connec
 	}
 	rcu_read_unlock();
 
+	if (fp == FP_NOT_AVAIL) {
+		/* IO Suspending works on the whole resource.
+		   Do it only for one device. */
+		vnr = 0;
+		peer_device = idr_get_next(&connection->peer_devices, &vnr);
+		drbd_change_state(peer_device->device, CS_VERBOSE | CS_HARD, NS(susp_fen, 0));
+	}
+
 	return fp;
 }
 
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 1a84345..3796662 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -54,8 +54,8 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 static enum drbd_state_rv is_valid_state(struct drbd_device *, union drbd_state);
 static enum drbd_state_rv is_valid_soft_transition(union drbd_state, union drbd_state, struct drbd_connection *);
 static enum drbd_state_rv is_valid_transition(union drbd_state os, union drbd_state ns);
-static union drbd_state sanitize_state(struct drbd_device *device, union drbd_state ns,
-				       enum sanitize_state_warnings *warn);
+static union drbd_state sanitize_state(struct drbd_device *device, union drbd_state os,
+				       union drbd_state ns, enum sanitize_state_warnings *warn);
 
 static inline bool is_susp(union drbd_state s)
 {
@@ -287,7 +287,7 @@ _req_st_cond(struct drbd_device *device, union drbd_state mask,
 
 	spin_lock_irqsave(&device->resource->req_lock, flags);
 	os = drbd_read_state(device);
-	ns = sanitize_state(device, apply_mask_val(os, mask, val), NULL);
+	ns = sanitize_state(device, os, apply_mask_val(os, mask, val), NULL);
 	rv = is_valid_transition(os, ns);
 	if (rv >= SS_SUCCESS)
 		rv = SS_UNKNOWN_ERROR;  /* cont waiting, otherwise fail. */
@@ -333,7 +333,7 @@ drbd_req_state(struct drbd_device *device, union drbd_state mask,
 
 	spin_lock_irqsave(&device->resource->req_lock, flags);
 	os = drbd_read_state(device);
-	ns = sanitize_state(device, apply_mask_val(os, mask, val), NULL);
+	ns = sanitize_state(device, os, apply_mask_val(os, mask, val), NULL);
 	rv = is_valid_transition(os, ns);
 	if (rv < SS_SUCCESS) {
 		spin_unlock_irqrestore(&device->resource->req_lock, flags);
@@ -740,8 +740,8 @@ static void print_sanitize_warnings(struct drbd_device *device, enum sanitize_st
  * When we loose connection, we have to set the state of the peers disk (pdsk)
  * to D_UNKNOWN. This rule and many more along those lines are in this function.
  */
-static union drbd_state sanitize_state(struct drbd_device *device, union drbd_state ns,
-				       enum sanitize_state_warnings *warn)
+static union drbd_state sanitize_state(struct drbd_device *device, union drbd_state os,
+				       union drbd_state ns, enum sanitize_state_warnings *warn)
 {
 	enum drbd_fencing_p fp;
 	enum drbd_disk_state disk_min, disk_max, pdsk_min, pdsk_max;
@@ -882,11 +882,13 @@ static union drbd_state sanitize_state(struct drbd_device *device, union drbd_st
 	}
 
 	if (fp == FP_STONITH &&
-	    (ns.role == R_PRIMARY && ns.conn < C_CONNECTED && ns.pdsk > D_OUTDATED))
+	    (ns.role == R_PRIMARY && ns.conn < C_CONNECTED && ns.pdsk > D_OUTDATED) &&
+	    !(os.role == R_PRIMARY && os.conn < C_CONNECTED && os.pdsk > D_OUTDATED))
 		ns.susp_fen = 1; /* Suspend IO while fence-peer handler runs (peer lost) */
 
 	if (device->resource->res_opts.on_no_data == OND_SUSPEND_IO &&
-	    (ns.role == R_PRIMARY && ns.disk < D_UP_TO_DATE && ns.pdsk < D_UP_TO_DATE))
+	    (ns.role == R_PRIMARY && ns.disk < D_UP_TO_DATE && ns.pdsk < D_UP_TO_DATE) &&
+	    !(os.role == R_PRIMARY && os.disk < D_UP_TO_DATE && os.pdsk < D_UP_TO_DATE))
 		ns.susp_nod = 1; /* Suspend IO while no data available (no accessible data available) */
 
 	if (ns.aftr_isp || ns.peer_isp || ns.user_isp) {
@@ -958,7 +960,7 @@ __drbd_set_state(struct drbd_device *device, union drbd_state ns,
 
 	os = drbd_read_state(device);
 
-	ns = sanitize_state(device, ns, &ssw);
+	ns = sanitize_state(device, os, ns, &ssw);
 	if (ns.i == os.i)
 		return SS_NOTHING_TO_DO;
 
@@ -1656,7 +1658,7 @@ conn_is_valid_transition(struct drbd_connection *connection, union drbd_state ma
 	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
 		struct drbd_device *device = peer_device->device;
 		os = drbd_read_state(device);
-		ns = sanitize_state(device, apply_mask_val(os, mask, val), NULL);
+		ns = sanitize_state(device, os, apply_mask_val(os, mask, val), NULL);
 
 		if (flags & CS_IGN_OUTD_FAIL && ns.disk == D_OUTDATED && os.disk < D_OUTDATED)
 			ns.disk = os.disk;
@@ -1718,7 +1720,7 @@ conn_set_state(struct drbd_connection *connection, union drbd_state mask, union
 		number_of_volumes++;
 		os = drbd_read_state(device);
 		ns = apply_mask_val(os, mask, val);
-		ns = sanitize_state(device, ns, NULL);
+		ns = sanitize_state(device, os, ns, NULL);
 
 		if (flags & CS_IGN_OUTD_FAIL && ns.disk == D_OUTDATED && os.disk < D_OUTDATED)
 			ns.disk = os.disk;
-- 
1.9.1

