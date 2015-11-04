Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4093E10561A8
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3CEC02A24E3
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:47 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id p5fn0f6oeFCV for <drbd-dev@lists.linbit.com>;
	Wed,  4 Nov 2015 18:09:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1AE5A2A2BCB
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:47 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yjsaah9RDTXl for <drbd-dev@lists.linbit.com>;
	Wed,  4 Nov 2015 18:09:47 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D8CF52A24E3
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:46 +0100 (CET)
Resent-Message-ID: <20151104170946.GV14472@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 399ED1056190
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 17:33:44 +0100 (CET)
From: mchristi@redhat.com
To: linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Date: Wed,  4 Nov 2015 10:33:03 -0600
Message-Id: <1446654807-6935-9-git-send-email-mchristi@redhat.com>
In-Reply-To: <1446654807-6935-1-git-send-email-mchristi@redhat.com>
References: <1446654807-6935-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 08/32] target: prepare for bi_rw split
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

This patch prepares lio's submit_bio use for the next
patches that split bi_rw into a operation and flags field.
Instead of passing in a bitmap with both the operation and
flags mixed in, the callers will now pass them in seperately.

This patch modifies the code related to the submit_bio calls
so the flags and operation are seperated. When this is done
for all code, one of the later patches in the series will
the actual submit_bio call, so the patches are bisectable.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/target/target_core_iblock.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 0f19e11..25f75ab 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -354,14 +354,14 @@ iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num)
 	return bio;
 }
 
-static void iblock_submit_bios(struct bio_list *list, int rw)
+static void iblock_submit_bios(struct bio_list *list, int op, int op_flags)
 {
 	struct blk_plug plug;
 	struct bio *bio;
 
 	blk_start_plug(&plug);
 	while ((bio = bio_list_pop(list)))
-		submit_bio(rw, bio);
+		submit_bio(op | op_flags, bio);
 	blk_finish_plug(&plug);
 }
 
@@ -480,7 +480,7 @@ iblock_execute_write_same(struct se_cmd *cmd)
 		sectors -= 1;
 	}
 
-	iblock_submit_bios(&list, WRITE);
+	iblock_submit_bios(&list, REQ_OP_WRITE, 0);
 	return 0;
 
 fail_put_bios:
@@ -653,7 +653,8 @@ iblock_execute_rw(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 	u32 sg_num = sgl_nents;
 	sector_t block_lba;
 	unsigned bio_cnt;
-	int rw = 0;
+	int op_flags = 0;
+	int op = 0;
 	int i;
 
 	if (data_direction == DMA_TO_DEVICE) {
@@ -664,17 +665,20 @@ iblock_execute_rw(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		 * is not enabled, or if initiator set the Force Unit Access bit.
 		 */
 		if (q->flush_flags & REQ_FUA) {
-			if (cmd->se_cmd_flags & SCF_FUA)
-				rw = WRITE_FUA;
-			else if (!(q->flush_flags & REQ_FLUSH))
-				rw = WRITE_FUA;
-			else
-				rw = WRITE;
+			if (cmd->se_cmd_flags & SCF_FUA) {
+				op = REQ_OP_WRITE;
+				op_flags = WRITE_FUA;
+			} else if (!(q->flush_flags & REQ_FLUSH)) {
+				op = REQ_OP_WRITE;
+				op_flags = WRITE_FUA;
+			} else {
+				op = REQ_OP_WRITE;
+			}
 		} else {
-			rw = WRITE;
+			op = REQ_OP_WRITE;
 		}
 	} else {
-		rw = READ;
+		op = REQ_OP_READ;
 	}
 
 	/*
@@ -726,7 +730,7 @@ iblock_execute_rw(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
 				!= sg->length) {
 			if (bio_cnt >= IBLOCK_MAX_BIO_PER_TASK) {
-				iblock_submit_bios(&list, rw);
+				iblock_submit_bios(&list, op, op_flags);
 				bio_cnt = 0;
 			}
 
@@ -750,7 +754,7 @@ iblock_execute_rw(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 			goto fail_put_bios;
 	}
 
-	iblock_submit_bios(&list, rw);
+	iblock_submit_bios(&list, op, op_flags);
 	iblock_complete_cmd(cmd);
 	return 0;
 
-- 
1.8.3.1

