Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F0AE01011B96
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 15:39:10 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id f6-v6so9099384wmc.4
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 06:39:10 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	x49-v6sm10099023edb.5.2018.05.23.06.39.09
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 23 May 2018 06:39:09 -0700 (PDT)
Resent-Message-ID: <20180523133909.GK499@soda.linbit>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
	[209.85.216.194])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 63B8B1011BF2
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 00:32:54 +0200 (CEST)
Received: by mail-qt0-f194.google.com with SMTP id m16-v6so16808756qtg.13
	for <drbd-dev@lists.linbit.com>; Sun, 20 May 2018 15:32:54 -0700 (PDT)
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk,
	hch@infradead.org, colyli@suse.de, snitzer@redhat.com,
	darrick.wong@oracle.com, clm@fb.com, bacik@fb.com,
	linux-xfs@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org, neilb@suse.com
Date: Sun, 20 May 2018 18:25:54 -0400
Message-Id: <20180520222558.7053-9-kent.overstreet@gmail.com>
In-Reply-To: <20180520222558.7053-1-kent.overstreet@gmail.com>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [Drbd-dev] [PATCH 08/12] target: convert to
	bioset_init()/mempool_init()
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

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/target/target_core_iblock.c | 14 ++++++--------
 drivers/target/target_core_iblock.h |  2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 44cacd001a..ce1321a5cb 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -94,8 +94,8 @@ static int iblock_configure_device(struct se_device *dev)
 		return -EINVAL;
 	}
 
-	ib_dev->ibd_bio_set = bioset_create(IBLOCK_BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
-	if (!ib_dev->ibd_bio_set) {
+	ret = bioset_init(&ib_dev->ibd_bio_set, IBLOCK_BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
+	if (ret) {
 		pr_err("IBLOCK: Unable to create bioset\n");
 		goto out;
 	}
@@ -141,7 +141,7 @@ static int iblock_configure_device(struct se_device *dev)
 
 	bi = bdev_get_integrity(bd);
 	if (bi) {
-		struct bio_set *bs = ib_dev->ibd_bio_set;
+		struct bio_set *bs = &ib_dev->ibd_bio_set;
 
 		if (!strcmp(bi->profile->name, "T10-DIF-TYPE3-IP") ||
 		    !strcmp(bi->profile->name, "T10-DIF-TYPE1-IP")) {
@@ -174,8 +174,7 @@ static int iblock_configure_device(struct se_device *dev)
 out_blkdev_put:
 	blkdev_put(ib_dev->ibd_bd, FMODE_WRITE|FMODE_READ|FMODE_EXCL);
 out_free_bioset:
-	bioset_free(ib_dev->ibd_bio_set);
-	ib_dev->ibd_bio_set = NULL;
+	bioset_exit(&ib_dev->ibd_bio_set);
 out:
 	return ret;
 }
@@ -199,8 +198,7 @@ static void iblock_destroy_device(struct se_device *dev)
 
 	if (ib_dev->ibd_bd != NULL)
 		blkdev_put(ib_dev->ibd_bd, FMODE_WRITE|FMODE_READ|FMODE_EXCL);
-	if (ib_dev->ibd_bio_set != NULL)
-		bioset_free(ib_dev->ibd_bio_set);
+	bioset_exit(&ib_dev->ibd_bio_set);
 }
 
 static unsigned long long iblock_emulate_read_cap_with_block_size(
@@ -332,7 +330,7 @@ iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num, int op,
 	if (sg_num > BIO_MAX_PAGES)
 		sg_num = BIO_MAX_PAGES;
 
-	bio = bio_alloc_bioset(GFP_NOIO, sg_num, ib_dev->ibd_bio_set);
+	bio = bio_alloc_bioset(GFP_NOIO, sg_num, &ib_dev->ibd_bio_set);
 	if (!bio) {
 		pr_err("Unable to allocate memory for bio\n");
 		return NULL;
diff --git a/drivers/target/target_core_iblock.h b/drivers/target/target_core_iblock.h
index b4aeb2584a..9cc3843404 100644
--- a/drivers/target/target_core_iblock.h
+++ b/drivers/target/target_core_iblock.h
@@ -22,7 +22,7 @@ struct iblock_dev {
 	struct se_device dev;
 	unsigned char ibd_udev_path[SE_UDEV_PATH_LEN];
 	u32	ibd_flags;
-	struct bio_set	*ibd_bio_set;
+	struct bio_set	ibd_bio_set;
 	struct block_device *ibd_bd;
 	bool ibd_readonly;
 } ____cacheline_aligned;
-- 
2.17.0

