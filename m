Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F0E841056472
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id EA7CC42024A
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id KKSLUgd5nSqN for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:46:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CC10E420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JEytAGpySRRg for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:46:49 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A070942024A
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:49 +0200 (CEST)
Resent-Message-ID: <20160610114649.GY3235@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 25CB91056455
	for <drbd-dev@lists.linbit.com>; Sun,  5 Jun 2016 21:32:48 +0200 (CEST)
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
Date: Sun,  5 Jun 2016 14:31:46 -0500
Message-Id: <1465155145-10812-7-git-send-email-mchristi@redhat.com>
In-Reply-To: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
References: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 06/45] dm: use op_is_write instead of checking
	for REQ_WRITE
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

This has dm use the op_is_write helper which will do the right
thing.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/md/dm-io.c     | 4 ++--
 drivers/md/dm-kcopyd.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 50f17e3..26e9a85 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -409,7 +409,7 @@ static int sync_io(struct dm_io_client *client, unsigned int num_regions,
 	struct io *io;
 	struct sync_io sio;
 
-	if (num_regions > 1 && (rw & RW_MASK) != WRITE) {
+	if (num_regions > 1 && !op_is_write(rw)) {
 		WARN_ON(1);
 		return -EIO;
 	}
@@ -442,7 +442,7 @@ static int async_io(struct dm_io_client *client, unsigned int num_regions,
 {
 	struct io *io;
 
-	if (num_regions > 1 && (rw & RW_MASK) != WRITE) {
+	if (num_regions > 1 && !op_is_write(rw)) {
 		WARN_ON(1);
 		fn(1, context);
 		return -EIO;
diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index 1452ed9..9f390e4 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -465,7 +465,7 @@ static void complete_io(unsigned long error, void *context)
 	io_job_finish(kc->throttle);
 
 	if (error) {
-		if (job->rw & WRITE)
+		if (op_is_write(job->rw))
 			job->write_err |= error;
 		else
 			job->read_err = 1;
@@ -477,7 +477,7 @@ static void complete_io(unsigned long error, void *context)
 		}
 	}
 
-	if (job->rw & WRITE)
+	if (op_is_write(job->rw))
 		push(&kc->complete_jobs, job);
 
 	else {
@@ -550,7 +550,7 @@ static int process_jobs(struct list_head *jobs, struct dm_kcopyd_client *kc,
 
 		if (r < 0) {
 			/* error this rogue job */
-			if (job->rw & WRITE)
+			if (op_is_write(job->rw))
 				job->write_err = (unsigned long) -1L;
 			else
 				job->read_err = 1;
-- 
2.7.2

