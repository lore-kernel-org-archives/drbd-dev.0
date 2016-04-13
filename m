Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 049F11056470
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id F3A8C40A546
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:43 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 4bQesJIFVtxd for <drbd-dev@lists.linbit.com>;
	Thu, 14 Apr 2016 13:26:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D550F40A530
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:43 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8rajBf23HxDK for <drbd-dev@lists.linbit.com>;
	Thu, 14 Apr 2016 13:26:43 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id AD3AC40A52E
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:43 +0200 (CEST)
Resent-Message-ID: <20160414112643.GM3078@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 38EE61056452
	for <drbd-dev@lists.linbit.com>; Wed, 13 Apr 2016 21:37:43 +0200 (CEST)
From: mchristi@redhat.com
To: linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	konrad.wilk@oracle.com, drbd-dev@lists.linbit.com,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-mtd@lists.infradead.org,
	target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	osd-dev@open-osd.org, xfs@oss.sgi.com, ocfs2-devel@oss.oracle.com
Date: Wed, 13 Apr 2016 14:36:15 -0500
Message-Id: <1460576188-5751-30-git-send-email-mchristi@redhat.com>
In-Reply-To: <1460576188-5751-1-git-send-email-mchristi@redhat.com>
References: <1460576188-5751-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 29/42] block: prepare elevator to use REQ_OPs.
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

From: Mike Christie <mchristi@redhat.com>

This patch converts the elevator code to use separate variables
for the operation and flags, and to check request->op for the REQ_OP.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c         | 2 +-
 block/cfq-iosched.c      | 4 ++--
 block/elevator.c         | 7 +++----
 include/linux/elevator.h | 4 ++--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f1545d1..3ec1310 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1081,7 +1081,7 @@ static struct request *__get_request(struct request_list *rl, int op,
 	if (unlikely(blk_queue_dying(q)))
 		return ERR_PTR(-ENODEV);
 
-	may_queue = elv_may_queue(q, op | op_flags);
+	may_queue = elv_may_queue(q, op, op_flags);
 	if (may_queue == ELV_MQUEUE_NO)
 		goto rq_starved;
 
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 4a34978..3fcc598 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -4285,7 +4285,7 @@ static inline int __cfq_may_queue(struct cfq_queue *cfqq)
 	return ELV_MQUEUE_MAY;
 }
 
-static int cfq_may_queue(struct request_queue *q, int rw)
+static int cfq_may_queue(struct request_queue *q, int op, int op_flags)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct task_struct *tsk = current;
@@ -4302,7 +4302,7 @@ static int cfq_may_queue(struct request_queue *q, int rw)
 	if (!cic)
 		return ELV_MQUEUE_MAY;
 
-	cfqq = cic_to_cfqq(cic, rw_is_sync(rw));
+	cfqq = cic_to_cfqq(cic, rw_is_sync(op | op_flags));
 	if (cfqq) {
 		cfq_init_prio_data(cfqq, cic);
 
diff --git a/block/elevator.c b/block/elevator.c
index c3555c9..6a282bf 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -366,8 +366,7 @@ void elv_dispatch_sort(struct request_queue *q, struct request *rq)
 	list_for_each_prev(entry, &q->queue_head) {
 		struct request *pos = list_entry_rq(entry);
 
-		if ((rq->cmd_flags & REQ_DISCARD) !=
-		    (pos->cmd_flags & REQ_DISCARD))
+		if ((rq->op == REQ_OP_DISCARD) != (pos->op == REQ_OP_DISCARD))
 			break;
 		if (rq_data_dir(rq) != rq_data_dir(pos))
 			break;
@@ -717,12 +716,12 @@ void elv_put_request(struct request_queue *q, struct request *rq)
 		e->type->ops.elevator_put_req_fn(rq);
 }
 
-int elv_may_queue(struct request_queue *q, int rw)
+int elv_may_queue(struct request_queue *q, int op, int op_flags)
 {
 	struct elevator_queue *e = q->elevator;
 
 	if (e->type->ops.elevator_may_queue_fn)
-		return e->type->ops.elevator_may_queue_fn(q, rw);
+		return e->type->ops.elevator_may_queue_fn(q, op, op_flags);
 
 	return ELV_MQUEUE_MAY;
 }
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 638b324..953d286 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -26,7 +26,7 @@ typedef int (elevator_dispatch_fn) (struct request_queue *, int);
 typedef void (elevator_add_req_fn) (struct request_queue *, struct request *);
 typedef struct request *(elevator_request_list_fn) (struct request_queue *, struct request *);
 typedef void (elevator_completed_req_fn) (struct request_queue *, struct request *);
-typedef int (elevator_may_queue_fn) (struct request_queue *, int);
+typedef int (elevator_may_queue_fn) (struct request_queue *, int, int);
 
 typedef void (elevator_init_icq_fn) (struct io_cq *);
 typedef void (elevator_exit_icq_fn) (struct io_cq *);
@@ -134,7 +134,7 @@ extern struct request *elv_former_request(struct request_queue *, struct request
 extern struct request *elv_latter_request(struct request_queue *, struct request *);
 extern int elv_register_queue(struct request_queue *q);
 extern void elv_unregister_queue(struct request_queue *q);
-extern int elv_may_queue(struct request_queue *, int);
+extern int elv_may_queue(struct request_queue *, int, int);
 extern void elv_completed_request(struct request_queue *, struct request *);
 extern int elv_set_request(struct request_queue *q, struct request *rq,
 			   struct bio *bio, gfp_t gfp_mask);
-- 
2.7.2

