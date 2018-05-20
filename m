Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 52AE61011B9C
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 15:39:20 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id o78-v6so9420844wmg.0
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 06:39:20 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	y17-v6sm10457334edl.49.2018.05.23.06.39.18
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 23 May 2018 06:39:19 -0700 (PDT)
Resent-Message-ID: <20180523133918.GN499@soda.linbit>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
	[209.85.220.196])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 06761101AC56
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 00:32:18 +0200 (CEST)
Received: by mail-qk0-f196.google.com with SMTP id h140-v6so78862qke.2
	for <drbd-dev@lists.linbit.com>; Sun, 20 May 2018 15:32:17 -0700 (PDT)
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk,
	hch@infradead.org, colyli@suse.de, snitzer@redhat.com,
	darrick.wong@oracle.com, clm@fb.com, bacik@fb.com,
	linux-xfs@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org, neilb@suse.com
Date: Sun, 20 May 2018 18:25:57 -0400
Message-Id: <20180520222558.7053-12-kent.overstreet@gmail.com>
In-Reply-To: <20180520222558.7053-1-kent.overstreet@gmail.com>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [Drbd-dev] [PATCH 11/12] xfs: convert to
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
 fs/xfs/xfs_aops.c  |  2 +-
 fs/xfs/xfs_aops.h  |  2 +-
 fs/xfs/xfs_super.c | 11 +++++------
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 0ab824f574..102463543d 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -594,7 +594,7 @@ xfs_alloc_ioend(
 	struct xfs_ioend	*ioend;
 	struct bio		*bio;
 
-	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, xfs_ioend_bioset);
+	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &xfs_ioend_bioset);
 	xfs_init_bio_from_bh(bio, bh);
 
 	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index 69346d460d..694c85b038 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -18,7 +18,7 @@
 #ifndef __XFS_AOPS_H__
 #define __XFS_AOPS_H__
 
-extern struct bio_set *xfs_ioend_bioset;
+extern struct bio_set xfs_ioend_bioset;
 
 /*
  * Types of I/O for bmap clustering and I/O completion tracking.
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d714240529..f643d76db5 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -63,7 +63,7 @@
 #include <linux/parser.h>
 
 static const struct super_operations xfs_super_operations;
-struct bio_set *xfs_ioend_bioset;
+struct bio_set xfs_ioend_bioset;
 
 static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
 #ifdef DEBUG
@@ -1845,10 +1845,9 @@ MODULE_ALIAS_FS("xfs");
 STATIC int __init
 xfs_init_zones(void)
 {
-	xfs_ioend_bioset = bioset_create(4 * MAX_BUF_PER_PAGE,
+	if (bioset_init(&xfs_ioend_bioset, 4 * MAX_BUF_PER_PAGE,
 			offsetof(struct xfs_ioend, io_inline_bio),
-			BIOSET_NEED_BVECS);
-	if (!xfs_ioend_bioset)
+			BIOSET_NEED_BVECS))
 		goto out;
 
 	xfs_log_ticket_zone = kmem_zone_init(sizeof(xlog_ticket_t),
@@ -1997,7 +1996,7 @@ xfs_init_zones(void)
  out_destroy_log_ticket_zone:
 	kmem_zone_destroy(xfs_log_ticket_zone);
  out_free_ioend_bioset:
-	bioset_free(xfs_ioend_bioset);
+	bioset_exit(&xfs_ioend_bioset);
  out:
 	return -ENOMEM;
 }
@@ -2029,7 +2028,7 @@ xfs_destroy_zones(void)
 	kmem_zone_destroy(xfs_btree_cur_zone);
 	kmem_zone_destroy(xfs_bmap_free_item_zone);
 	kmem_zone_destroy(xfs_log_ticket_zone);
-	bioset_free(xfs_ioend_bioset);
+	bioset_exit(&xfs_ioend_bioset);
 }
 
 STATIC int __init
-- 
2.17.0

