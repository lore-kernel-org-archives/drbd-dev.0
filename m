Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 39AD2105642B
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 348CB2A5C46
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:50 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zqvfl37ltNYr for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:31:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 18D582A5C4B
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:50 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e6RQuUGGp_Y7 for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:31:50 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id DF8572A5C46
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:49 +0100 (CET)
Resent-Message-ID: <20160108203149.GL28982@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A7347105632F
	for <drbd-dev@lists.linbit.com>; Tue,  5 Jan 2016 22:01:44 +0100 (CET)
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
Date: Tue,  5 Jan 2016 14:53:17 -0600
Message-Id: <1452027218-32303-15-git-send-email-mchristi@redhat.com>
In-Reply-To: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 14/35] hfsplus: set bi_op to REQ_OP
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

This patch has hfsplus set the bio bi_op to a REQ_OP, and
rq_flag_bits to bi_rw.

This patch is compile tested only.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 fs/hfsplus/hfsplus_fs.h |  2 +-
 fs/hfsplus/part_tbl.c   |  5 +++--
 fs/hfsplus/super.c      |  6 ++++--
 fs/hfsplus/wrapper.c    | 15 +++++++++------
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index f91a1fa..80154aa 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -525,7 +525,7 @@ int hfsplus_compare_dentry(const struct dentry *parent,
 
 /* wrapper.c */
 int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
-		       void **data, int rw);
+		       void **data, int op, int op_flags);
 int hfsplus_read_wrapper(struct super_block *sb);
 
 /* time macros */
diff --git a/fs/hfsplus/part_tbl.c b/fs/hfsplus/part_tbl.c
index eb355d8..63164eb 100644
--- a/fs/hfsplus/part_tbl.c
+++ b/fs/hfsplus/part_tbl.c
@@ -112,7 +112,8 @@ static int hfs_parse_new_pmap(struct super_block *sb, void *buf,
 		if ((u8 *)pm - (u8 *)buf >= buf_size) {
 			res = hfsplus_submit_bio(sb,
 						 *part_start + HFS_PMAP_BLK + i,
-						 buf, (void **)&pm, READ);
+						 buf, (void **)&pm, REQ_OP_READ,
+						 0);
 			if (res)
 				return res;
 		}
@@ -136,7 +137,7 @@ int hfs_part_find(struct super_block *sb,
 		return -ENOMEM;
 
 	res = hfsplus_submit_bio(sb, *part_start + HFS_PMAP_BLK,
-				 buf, &data, READ);
+				 buf, &data, REQ_OP_READ, 0);
 	if (res)
 		goto out;
 
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 5d54490..01cf313 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -219,7 +219,8 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 
 	error2 = hfsplus_submit_bio(sb,
 				   sbi->part_start + HFSPLUS_VOLHEAD_SECTOR,
-				   sbi->s_vhdr_buf, NULL, WRITE_SYNC);
+				   sbi->s_vhdr_buf, NULL, REQ_OP_WRITE,
+				   WRITE_SYNC);
 	if (!error)
 		error = error2;
 	if (!write_backup)
@@ -227,7 +228,8 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 
 	error2 = hfsplus_submit_bio(sb,
 				  sbi->part_start + sbi->sect_count - 2,
-				  sbi->s_backup_vhdr_buf, NULL, WRITE_SYNC);
+				  sbi->s_backup_vhdr_buf, NULL, REQ_OP_WRITE,
+				  WRITE_SYNC);
 	if (!error)
 		error2 = error;
 out:
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 7e605b5..d09b726 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -30,7 +30,8 @@ struct hfsplus_wd {
  * @sector: block to read or write, for blocks of HFSPLUS_SECTOR_SIZE bytes
  * @buf: buffer for I/O
  * @data: output pointer for location of requested data
- * @rw: direction of I/O
+ * @op: direction of I/O
+ * @op_flags: request op flags
  *
  * The unit of I/O is hfsplus_min_io_size(sb), which may be bigger than
  * HFSPLUS_SECTOR_SIZE, and @buf must be sized accordingly. On reads
@@ -44,7 +45,7 @@ struct hfsplus_wd {
  * will work correctly.
  */
 int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
-		void *buf, void **data, int rw)
+		       void *buf, void **data, int op, int op_flags)
 {
 	struct bio *bio;
 	int ret = 0;
@@ -65,9 +66,10 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 	bio = bio_alloc(GFP_NOIO, 1);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_bdev = sb->s_bdev;
-	bio->bi_rw |= rw;
+	bio->bi_op = op;
+	bio->bi_rw |= op_flags;
 
-	if (!(rw & WRITE) && data)
+	if (op != WRITE && data)
 		*data = (u8 *)buf + offset;
 
 	while (io_size > 0) {
@@ -182,7 +184,7 @@ int hfsplus_read_wrapper(struct super_block *sb)
 reread:
 	error = hfsplus_submit_bio(sb, part_start + HFSPLUS_VOLHEAD_SECTOR,
 				   sbi->s_vhdr_buf, (void **)&sbi->s_vhdr,
-				   READ);
+				   REQ_OP_READ, 0);
 	if (error)
 		goto out_free_backup_vhdr;
 
@@ -214,7 +216,8 @@ reread:
 
 	error = hfsplus_submit_bio(sb, part_start + part_size - 2,
 				   sbi->s_backup_vhdr_buf,
-				   (void **)&sbi->s_backup_vhdr, READ);
+				   (void **)&sbi->s_backup_vhdr, REQ_OP_READ,
+				   0);
 	if (error)
 		goto out_free_backup_vhdr;
 
-- 
1.8.3.1

