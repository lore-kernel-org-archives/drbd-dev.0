Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 076F2105059E
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2015 15:45:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id EFE603CBB2B
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2015 15:45:57 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id BUWWYC_VjekA for <drbd-dev@lists.linbit.com>;
	Fri, 27 Mar 2015 15:45:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C6FC53D4520
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2015 15:45:57 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yMMcSZmzta5b for <drbd-dev@lists.linbit.com>;
	Fri, 27 Mar 2015 15:45:57 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 8CCF23CBB2B
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2015 15:45:57 +0100 (CET)
Resent-Message-ID: <20150327144557.GA13700@soda.linbit>
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com
	[209.85.213.181]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4D8DE1050592
	for <drbd-dev@lists.linbit.com>; Wed, 25 Mar 2015 00:21:19 +0100 (CET)
Received: by igcau2 with SMTP id au2so86529787igc.0
	for <drbd-dev@lists.linbit.com>; Tue, 24 Mar 2015 16:21:18 -0700 (PDT)
Date: Tue, 24 Mar 2015 16:21:16 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>
Message-ID: <alpine.DEB.2.10.1503241620190.21805@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [patch resend 1/3] block: allocate request memory local
 to request queue
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

blk_init_rl() allocates a mempool using mempool_create_node() with node
local memory.  This only allocates the mempool and element list locally
to the requeue queue node.

What we really want to do is allocate the request itself local to the
queue.  To do this, we need our own alloc and free functions that will
allocate from request_cachep and pass the request queue node in to prefer
node local memory.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 block/blk-core.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -557,6 +557,18 @@ void blk_cleanup_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_cleanup_queue);
 
+/* Allocate memory local to the request queue */
+static void *alloc_request_struct(gfp_t gfp_mask, void *data)
+{
+	int nid = (int)(long)data;
+	return kmem_cache_alloc_node(request_cachep, gfp_mask, nid);
+}
+
+static void free_request_struct(void *element, void *unused)
+{
+	kmem_cache_free(request_cachep, element);
+}
+
 int blk_init_rl(struct request_list *rl, struct request_queue *q,
 		gfp_t gfp_mask)
 {
@@ -569,9 +581,10 @@ int blk_init_rl(struct request_list *rl, struct request_queue *q,
 	init_waitqueue_head(&rl->wait[BLK_RW_SYNC]);
 	init_waitqueue_head(&rl->wait[BLK_RW_ASYNC]);
 
-	rl->rq_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab,
-					  mempool_free_slab, request_cachep,
-					  gfp_mask, q->node);
+	rl->rq_pool = mempool_create_node(BLKDEV_MIN_RQ, alloc_request_struct,
+					  free_request_struct,
+					  (void *)(long)q->node, gfp_mask,
+					  q->node);
 	if (!rl->rq_pool)
 		return -ENOMEM;
 
