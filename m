Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A1BBE1056426
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9C67B2A5C46
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:45 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id vzRj5hAG1bU1 for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:31:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7782C2A5C4B
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:45 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lgqqgI3ECVeb for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:31:45 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 500012A5C46
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:45 +0100 (CET)
Resent-Message-ID: <20160108203144.GH28982@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3817A1056326
	for <drbd-dev@lists.linbit.com>; Tue,  5 Jan 2016 22:01:04 +0100 (CET)
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
Date: Tue,  5 Jan 2016 14:53:23 -0600
Message-Id: <1452027218-32303-21-git-send-email-mchristi@redhat.com>
In-Reply-To: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 20/35] dm: pass dm stats data dir instead of bi_rw
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

It looks like dm stats cares about the data direction
(READ vs WRITE) and does not need the bio/request flags.
Commands like REQ_FLUSH, REQ_DISCARD and REQ_WRITE_SAME
are currently always set with REQ_WRITE, so the extra check for
REQ_DISCARD in dm_stats_account_io is not needed.

This patch has it use the bio and request data_dir helpers
instead of accessing the bi_rw/cmd_flags directly. This makes
the next patches that remove the operation from the cmd_flags
and bi_rw easier, because we will no longer have the REQ_WRITE
bit set for operations like discards.

This patch is compile tested only.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/md/dm-stats.c | 6 +++---
 drivers/md/dm.c       | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-stats.c b/drivers/md/dm-stats.c
index 8289804..96b5c1b 100644
--- a/drivers/md/dm-stats.c
+++ b/drivers/md/dm-stats.c
@@ -518,7 +518,7 @@ static void dm_stat_for_entry(struct dm_stat *s, size_t entry,
 			      struct dm_stats_aux *stats_aux, bool end,
 			      unsigned long duration_jiffies)
 {
-	unsigned long idx = bi_rw & REQ_WRITE;
+	unsigned long idx = bi_rw;
 	struct dm_stat_shared *shared = &s->stat_shared[entry];
 	struct dm_stat_percpu *p;
 
@@ -645,8 +645,8 @@ void dm_stats_account_io(struct dm_stats *stats, unsigned long bi_rw,
 		last = raw_cpu_ptr(stats->last);
 		stats_aux->merged =
 			(bi_sector == (ACCESS_ONCE(last->last_sector) &&
-				       ((bi_rw & (REQ_WRITE | REQ_DISCARD)) ==
-					(ACCESS_ONCE(last->last_rw) & (REQ_WRITE | REQ_DISCARD)))
+				       ((bi_rw == WRITE) ==
+					(ACCESS_ONCE(last->last_rw) == WRITE))
 				       ));
 		ACCESS_ONCE(last->last_sector) = end_sector;
 		ACCESS_ONCE(last->last_rw) = bi_rw;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1777c9c..5dbdae7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -686,7 +686,7 @@ static void start_io_acct(struct dm_io *io)
 		atomic_inc_return(&md->pending[rw]));
 
 	if (unlikely(dm_stats_used(&md->stats)))
-		dm_stats_account_io(&md->stats, bio->bi_rw, bio->bi_iter.bi_sector,
+		dm_stats_account_io(&md->stats, bio_data_dir(bio), bio->bi_iter.bi_sector,
 				    bio_sectors(bio), false, 0, &io->stats_aux);
 }
 
@@ -701,7 +701,7 @@ static void end_io_acct(struct dm_io *io)
 	generic_end_io_acct(rw, &dm_disk(md)->part0, io->start_time);
 
 	if (unlikely(dm_stats_used(&md->stats)))
-		dm_stats_account_io(&md->stats, bio->bi_rw, bio->bi_iter.bi_sector,
+		dm_stats_account_io(&md->stats, bio_data_dir(bio), bio->bi_iter.bi_sector,
 				    bio_sectors(bio), true, duration, &io->stats_aux);
 
 	/*
@@ -1084,7 +1084,7 @@ static void rq_end_stats(struct mapped_device *md, struct request *orig)
 	if (unlikely(dm_stats_used(&md->stats))) {
 		struct dm_rq_target_io *tio = tio_from_request(orig);
 		tio->duration_jiffies = jiffies - tio->duration_jiffies;
-		dm_stats_account_io(&md->stats, orig->cmd_flags, blk_rq_pos(orig),
+		dm_stats_account_io(&md->stats, rq_data_dir(orig), blk_rq_pos(orig),
 				    tio->n_sectors, true, tio->duration_jiffies,
 				    &tio->stats_aux);
 	}
@@ -2017,7 +2017,7 @@ static void dm_start_request(struct mapped_device *md, struct request *orig)
 		struct dm_rq_target_io *tio = tio_from_request(orig);
 		tio->duration_jiffies = jiffies;
 		tio->n_sectors = blk_rq_sectors(orig);
-		dm_stats_account_io(&md->stats, orig->cmd_flags, blk_rq_pos(orig),
+		dm_stats_account_io(&md->stats, rq_data_dir(orig), blk_rq_pos(orig),
 				    tio->n_sectors, false, 0, &tio->stats_aux);
 	}
 
-- 
1.8.3.1

