Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (prv3-mh.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8CFA51056491
	for <drbd-dev@lists.linbit.com>; Mon, 13 Mar 2017 08:24:15 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 13 Mar 2017 15:23:28 +0800
Message-Id: <1489389811-31234-6-git-send-email-nwang@suse.com>
In-Reply-To: <1489389811-31234-1-git-send-email-nwang@suse.com>
References: <1489389811-31234-1-git-send-email-nwang@suse.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: [Drbd-dev] [Patch v1 5/8] Use refcount_t 'atomic' type to implement
	structref
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

In 10383aea, atomic type for refcount is obsoleted, instead use
refcount_t. Also convert the related call.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: Roland Kammerer <roland.kammerer@linbit.com>
CC: drbd-dev@lists.linbit.com 
---
 drbd/drbd_bitmap.c | 4 ++++
 drbd/drbd_req.c    | 6 +++---
 drbd/kref_debug.c  | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drbd/drbd_bitmap.c b/drbd/drbd_bitmap.c
index 51cfdc8..726cfae 100644
--- a/drbd/drbd_bitmap.c
+++ b/drbd/drbd_bitmap.c
@@ -1182,7 +1182,11 @@ static int bm_rw_range(struct drbd_device *device,
 		.done = 0,
 		.flags = flags,
 		.error = 0,
+#ifdef KREF_INIT
+		.kref = KREF_INIT(2),
+#else
 		.kref = { ATOMIC_INIT(2) },
+#endif
 	};
 
 	if (!expect(device, get_ldev_if_state(device, D_ATTACHING))) {  /* put is in drbd_bm_aio_ctx_destroy() */
diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
index d6d9dc1..b433a12 100644
--- a/drbd/drbd_req.c
+++ b/drbd/drbd_req.c
@@ -124,7 +124,7 @@ void drbd_queue_peer_ack(struct drbd_resource *resource, struct drbd_request *re
 		    connection->cstate[NOW] != C_CONNECTED ||
 		    !(req->rq_state[1 + node_id] & RQ_NET_SENT))
 			continue;
-		atomic_inc(&req->kref.refcount); /* was 0, instead of kref_get() */
+		refcount_inc(&req->kref.refcount); /* was 0, instead of kref_get() */
 		req->rq_state[1 + node_id] |= RQ_PEER_ACK;
 		if (!queued) {
 			list_add_tail(&req->tl_requests, &resource->peer_ack_list);
@@ -324,7 +324,7 @@ void drbd_req_destroy(struct kref *kref)
 	 */
 	if (destroy_next) {
 		req = destroy_next;
-		if (atomic_dec_and_test(&req->kref.refcount))
+		if (refcount_dec_and_test(&req->kref.refcount))
 			goto tail_recursion;
 	}
 
@@ -722,7 +722,7 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
 		/* Completion does it's own kref_put.  If we are going to
 		 * kref_sub below, we need req to be still around then. */
 		int at_least = k_put + !!c_put;
-		int refcount = atomic_read(&req->kref.refcount);
+		int refcount = refcount_read(&req->kref.refcount);
 		if (refcount < at_least)
 			drbd_err(req->device,
 				"mod_rq_state: Logic BUG: 0: %x -> %x, %d: %x -> %x: refcount = %d, should be >= %d\n",
diff --git a/drbd/kref_debug.c b/drbd/kref_debug.c
index 0aa0e6e..a77cc35 100644
--- a/drbd/kref_debug.c
+++ b/drbd/kref_debug.c
@@ -108,7 +108,7 @@ void print_kref_debug_info(struct seq_file *seq)
 		char obj_name[80];
 
 		debug_refs = number_of_debug_refs(debug_info);
-		refs = atomic_read(&debug_info->kref->refcount);
+		refs = refcount_read(&debug_info->kref->refcount);
 		debug_info->class->get_object_name(debug_info, obj_name);
 
 		seq_printf(seq, "class: %s, name: %s, refs: %d, dr: %d\n",
-- 
1.8.5.6

