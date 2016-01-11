Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 254E1105633E
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1F34D360050
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:46 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id gAM_HRQEL9fv for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 048EF364792
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:46 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ygdwTnAiJADB for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:45 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D1CF2360050
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:45 +0100 (CET)
Resent-Message-ID: <20160112100945.GW3313@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B69CD1056317
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jan 2016 21:27:59 +0100 (CET)
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
Date: Mon, 11 Jan 2016 14:21:15 -0600
Message-Id: <1452543693-4440-18-git-send-email-mchristi@redhat.com>
In-Reply-To: <1452543693-4440-1-git-send-email-mchristi@redhat.com>
References: <1452543693-4440-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 17/35] ocfs2: set bi_op to REQ_OP
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

This patch has ocfs2 set the bio bi_op to a REQ_OP, and
rq_flag_bits to bi_rw.

This patch is compile tested only.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 fs/ocfs2/cluster/heartbeat.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 119bd85..271ef2a 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -391,7 +391,8 @@ static void o2hb_bio_end_io(struct bio *bio)
 static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 				      struct o2hb_bio_wait_ctxt *wc,
 				      unsigned int *current_slot,
-				      unsigned int max_slots, int rw)
+				      unsigned int max_slots, int op,
+				      int op_flags)
 {
 	int len, current_page;
 	unsigned int vec_len, vec_start;
@@ -417,7 +418,8 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	bio->bi_bdev = reg->hr_bdev;
 	bio->bi_private = wc;
 	bio->bi_end_io = o2hb_bio_end_io;
-	bio->bi_rw = rw;
+	bio->bi_op = op;
+	bio->bi_rw = op_flags;
 
 	vec_start = (cs << bits) % PAGE_CACHE_SIZE;
 	while(cs < max_slots) {
@@ -454,7 +456,7 @@ static int o2hb_read_slots(struct o2hb_region *reg,
 
 	while(current_slot < max_slots) {
 		bio = o2hb_setup_one_bio(reg, &wc, &current_slot, max_slots,
-					 READ);
+					 REQ_OP_READ, 0);
 		if (IS_ERR(bio)) {
 			status = PTR_ERR(bio);
 			mlog_errno(status);
@@ -486,7 +488,8 @@ static int o2hb_issue_node_write(struct o2hb_region *reg,
 
 	slot = o2nm_this_node();
 
-	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1, WRITE_SYNC);
+	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1, REQ_OP_WRITE,
+				 WRITE_SYNC);
 	if (IS_ERR(bio)) {
 		status = PTR_ERR(bio);
 		mlog_errno(status);
-- 
1.8.3.1

