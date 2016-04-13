Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5A7F8105646E
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5476240A52E
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:42 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id QuedSC-W0gHk for <drbd-dev@lists.linbit.com>;
	Thu, 14 Apr 2016 13:26:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 21D4840A59B
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:42 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id USYdEKzbTcMA for <drbd-dev@lists.linbit.com>;
	Thu, 14 Apr 2016 13:26:42 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E883440A52E
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:41 +0200 (CEST)
Resent-Message-ID: <20160414112641.GJ3078@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 684FD1056454
	for <drbd-dev@lists.linbit.com>; Wed, 13 Apr 2016 21:45:45 +0200 (CEST)
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
Date: Wed, 13 Apr 2016 14:36:12 -0500
Message-Id: <1460576188-5751-27-git-send-email-mchristi@redhat.com>
In-Reply-To: <1460576188-5751-1-git-send-email-mchristi@redhat.com>
References: <1460576188-5751-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 26/42] block: copy bio op to request op
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

The bio users should now always be setting up the bio->bi_op. This patch
has us copy that to the struct request op field.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6bcc22e..4224775 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2990,6 +2990,7 @@ void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 {
 	/* tmp compat. Allow users to set bi_op or bi_rw */
 	rq->cmd_flags |= bio_data_dir(bio);
+	rq->op = bio->bi_op;
 
 	if (bio_has_data(bio))
 		rq->nr_phys_segments = bio_phys_segments(q, bio);
@@ -3074,6 +3075,7 @@ EXPORT_SYMBOL_GPL(blk_rq_unprep_clone);
 static void __blk_rq_prep_clone(struct request *dst, struct request *src)
 {
 	dst->cpu = src->cpu;
+	dst->op = src->op;
 	dst->cmd_flags |= (src->cmd_flags & REQ_CLONE_MASK) | REQ_NOMERGE;
 	dst->cmd_type = src->cmd_type;
 	dst->__sector = blk_rq_pos(src);
-- 
2.7.2

