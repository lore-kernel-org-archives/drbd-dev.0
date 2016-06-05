Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6DAA41056473
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6413642024A
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:51 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ZbOYGGeRtXS4 for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:46:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6DF77420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:50 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ILKb-Ar-NepE for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:46:50 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 4609D42024A
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:50 +0200 (CEST)
Resent-Message-ID: <20160610114649.GZ3235@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4544F1056457
	for <drbd-dev@lists.linbit.com>; Sun,  5 Jun 2016 21:32:50 +0200 (CEST)
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
Date: Sun,  5 Jun 2016 14:31:47 -0500
Message-Id: <1465155145-10812-8-git-send-email-mchristi@redhat.com>
In-Reply-To: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
References: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 07/45] bcache: use op_is_write instead of
	checking for REQ_WRITE
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

We currently set REQ_WRITE/WRITE for all non READ IOs
like discard, flush, writesame, etc. In the next patches where we
no longer set up the op as a bitmap, we will not be able to
detect a operation direction like writesame by testing if REQ_WRITE is
set.

This has bcache use the op_is_write helper which will do the right
thing.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/md/bcache/io.c      | 2 +-
 drivers/md/bcache/request.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/io.c b/drivers/md/bcache/io.c
index 86a0bb8..fd885cc 100644
--- a/drivers/md/bcache/io.c
+++ b/drivers/md/bcache/io.c
@@ -111,7 +111,7 @@ void bch_bbio_count_io_errors(struct cache_set *c, struct bio *bio,
 	struct bbio *b = container_of(bio, struct bbio, bio);
 	struct cache *ca = PTR_CACHE(c, &b->key, 0);
 
-	unsigned threshold = bio->bi_rw & REQ_WRITE
+	unsigned threshold = op_is_write(bio_op(bio))
 		? c->congested_write_threshold_us
 		: c->congested_read_threshold_us;
 
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 25fa844..6b85a23 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -383,7 +383,7 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
 
 	if (mode == CACHE_MODE_NONE ||
 	    (mode == CACHE_MODE_WRITEAROUND &&
-	     (bio->bi_rw & REQ_WRITE)))
+	     op_is_write(bio_op(bio))))
 		goto skip;
 
 	if (bio->bi_iter.bi_sector & (c->sb.block_size - 1) ||
@@ -404,7 +404,7 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
 
 	if (!congested &&
 	    mode == CACHE_MODE_WRITEBACK &&
-	    (bio->bi_rw & REQ_WRITE) &&
+	    op_is_write(bio_op(bio)) &&
 	    (bio->bi_rw & REQ_SYNC))
 		goto rescale;
 
@@ -657,7 +657,7 @@ static inline struct search *search_alloc(struct bio *bio,
 	s->cache_miss		= NULL;
 	s->d			= d;
 	s->recoverable		= 1;
-	s->write		= (bio->bi_rw & REQ_WRITE) != 0;
+	s->write		= op_is_write(bio_op(bio));
 	s->read_dirty_data	= 0;
 	s->start_time		= jiffies;
 
-- 
2.7.2

