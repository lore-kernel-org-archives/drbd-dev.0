Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A00CE1056492
	for <drbd-dev@lists.linbit.com>; Tue,  7 Mar 2017 04:28:45 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Tue,  7 Mar 2017 11:27:56 +0800
Message-Id: <1488857279-29079-6-git-send-email-nwang@suse.com>
In-Reply-To: <1488857279-29079-1-git-send-email-nwang@suse.com>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [Patch v0 5/8] Use refcount_t 'atomic' type to implement
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
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com 

---
 drbd/drbd_bitmap.c      |  4 ++++
 drbd/drbd_req.c         | 12 ++++++++++++
 drbd/kref_debug.c       |  4 ++++
 3 files changed, 20 insertions(+)

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
index d6d9dc1..467549a 100644
--- a/drbd/drbd_req.c
+++ b/drbd/drbd_req.c
@@ -124,7 +124,11 @@ void drbd_queue_peer_ack(struct drbd_resource *resource, struct drbd_request *re
 		    connection->cstate[NOW] != C_CONNECTED ||
 		    !(req->rq_state[1 + node_id] & RQ_NET_SENT))
 			continue;
+#ifdef COMPAT_HAVE_REFCOUNT_INC
+		refcount_inc(&req->kref.refcount); /* was 0, instead of kref_get() */
+#else
 		atomic_inc(&req->kref.refcount); /* was 0, instead of kref_get() */
+#endif
 		req->rq_state[1 + node_id] |= RQ_PEER_ACK;
 		if (!queued) {
 			list_add_tail(&req->tl_requests, &resource->peer_ack_list);
@@ -324,7 +328,11 @@ void drbd_req_destroy(struct kref *kref)
 	 */
 	if (destroy_next) {
 		req = destroy_next;
+#ifdef COMPAT_HAVE_REFCOUNT_INC
+		if (refcount_dec_and_test(&req->kref.refcount))
+#else
 		if (atomic_dec_and_test(&req->kref.refcount))
+#endif
 			goto tail_recursion;
 	}
 
@@ -722,7 +730,11 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
 		/* Completion does it's own kref_put.  If we are going to
 		 * kref_sub below, we need req to be still around then. */
 		int at_least = k_put + !!c_put;
+#ifdef COMPAT_HAVE_REFCOUNT_INC
+		int refcount = refcount_read(&req->kref.refcount);
+#else
 		int refcount = atomic_read(&req->kref.refcount);
+#endif
 		if (refcount < at_least)
 			drbd_err(req->device,
 				"mod_rq_state: Logic BUG: 0: %x -> %x, %d: %x -> %x: refcount = %d, should be >= %d\n",
diff --git a/drbd/kref_debug.c b/drbd/kref_debug.c
index 0aa0e6e..4c50f53 100644
--- a/drbd/kref_debug.c
+++ b/drbd/kref_debug.c
@@ -108,7 +108,11 @@ void print_kref_debug_info(struct seq_file *seq)
 		char obj_name[80];
 
 		debug_refs = number_of_debug_refs(debug_info);
+#ifdef COMPAT_HAVE_REFCOUNT_INC
+		refs = refcount_read(&debug_info->kref->refcount);
+#else
 		refs = atomic_read(&debug_info->kref->refcount);
+#endif
 		debug_info->class->get_object_name(debug_info, obj_name);
 
 		seq_printf(seq, "class: %s, name: %s, refs: %d, dr: %d\n",
-- 
1.8.5.6

