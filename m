Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 144031059181
	for <drbd-dev@lists.linbit.com>; Thu, 11 Nov 2010 18:10:47 +0100 (CET)
Message-ID: <4CDC2379.3050505@kernel.org>
Date: Thu, 11 Nov 2010 18:10:17 +0100
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: axboe@kernel.dk, hch@infradead.org, linux-kernel@vger.kernel.org,
	petero2@telia.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
	jack@suse.cz, akpm@linux-foundation.org, adilger.kernel@dilger.ca,
	tytso@mit.edu, mfasheh@suse.com, joel.becker@oracle.com,
	aelder@sgi.com, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
	neilb@suse.de, leochen@broadcom.com, sbranden@broadcom.com,
	chris.mason@oracle.com, swhiteho@redhat.com, shaggy@linux.vnet.ibm.com,
	joern@logfs.org, konishi.ryusuke@lab.ntt.co.jp,
	reiserfs-devel@vger.kernel.org, viro@zeniv.linux.org.uk,
	dbrownell@users.sourceforge.net
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
In-Reply-To: <1288628129-12811-1-git-send-email-tj@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] [PATCH 6/5] block: check bdev_read_only() from
	blkdev_get()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

bdev read-only status can be queried using bdev_read_only() and may
change while the device is being opened.  Enforce it by checking it
from blkdev_get() after open succeeds.

This makes bdev_read_only() check in open_bdev_exclusive() and
fsg_lun_open() unnecessary.  Drop them.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/gadget/storage_common.c |    7 ++-----
 fs/block_dev.c                      |   11 ++++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/storage_common.c b/drivers/usb/gadget/storage_common.c
index 3b513ba..b015561 100644
--- a/drivers/usb/gadget/storage_common.c
+++ b/drivers/usb/gadget/storage_common.c
@@ -543,7 +543,7 @@ static int fsg_lun_open(struct fsg_lun *curlun, const char *filename)
 	ro = curlun->initially_ro;
 	if (!ro) {
 		filp = filp_open(filename, O_RDWR | O_LARGEFILE, 0);
-		if (-EROFS == PTR_ERR(filp))
+		if (PTR_ERR(filp) == -EROFS || PTR_ERR(filp) == -EACCES)
 			ro = 1;
 	}
 	if (ro)
@@ -558,10 +558,7 @@ static int fsg_lun_open(struct fsg_lun *curlun, const char *filename)

 	if (filp->f_path.dentry)
 		inode = filp->f_path.dentry->d_inode;
-	if (inode && S_ISBLK(inode->i_mode)) {
-		if (bdev_read_only(inode->i_bdev))
-			ro = 1;
-	} else if (!inode || !S_ISREG(inode->i_mode)) {
+	if (!inode || (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))) {
 		LINFO(curlun, "invalid file type: %s\n", filename);
 		goto out;
 	}
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 269bfbb..606a525 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1149,6 +1149,12 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)

 	res = __blkdev_get(bdev, mode, 0);

+	/* __blkdev_get() may alter read only status, check it afterwards */
+	if (!res && (mode & FMODE_WRITE) && bdev_read_only(bdev)) {
+		__blkdev_put(bdev, mode, 0);
+		res = -EACCES;
+	}
+
 	if (whole) {
 		/* finish claiming */
 		spin_lock(&bdev_lock);
@@ -1453,11 +1459,6 @@ struct block_device *open_bdev_exclusive(const char *path, fmode_t mode, void *h
 	if (error)
 		return ERR_PTR(error);

-	if ((mode & FMODE_WRITE) && bdev_read_only(bdev)) {
-		blkdev_put(bdev, mode);
-		return ERR_PTR(-EACCES);
-	}
-
 	return bdev;
 }

-- 
1.7.1

