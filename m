Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E5A6B10595AD
	for <drbd-dev@lists.linbit.com>; Tue,  2 Nov 2010 11:38:29 +0100 (CET)
Resent-Message-ID: <20101102103829.GD4340@barkeeper1-xen.linbit>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DCDF010593B9
	for <drbd-dev@lists.linbit.com>; Mon,  1 Nov 2010 17:16:26 +0100 (CET)
From: Tejun Heo <tj@kernel.org>
To: axboe@kernel.dk, hch@infradead.org, linux-kernel@vger.kernel.org,
	petero2@telia.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
	jack@suse.cz, akpm@linux-foundation.org, adilger.kernel@dilger.ca,
	tytso@mit.edu, mfasheh@suse.com, joel.becker@oracle.com,
	aelder@sgi.com, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
	neilb@suse.de, leochen@broadcom.com, sbranden@broadcom.com,
	chris.mason@oracle.com, swhiteho@redhat.com, shaggy@linux.vnet.ibm.com,
	joern@logfs.org, konishi.ryusuke@lab.ntt.co.jp,
	reiserfs-devel@vger.kernel.org, viro@zeniv.linux.org.uk
Date: Mon,  1 Nov 2010 17:15:25 +0100
Message-Id: <1288628129-12811-2-git-send-email-tj@kernel.org>
In-Reply-To: <1288628129-12811-1-git-send-email-tj@kernel.org>
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, linux-mtd@lists.infradead.org
Subject: [Drbd-dev] [PATCH 1/5] mtd: fix bdev exclusive open bugs in
	block2mtd::add_device()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

There are two bdev exclusive open bugs.

* open_bdev_exclusive() must not be called with NULL holder.  Use dev
  as the holder.

* open_by_devnum() doesn't open the bdev exclusively but
  block2mtd_free_device() always assumes it.  Explicitly claim the
  bdev.

The latter is rather clumsy but will be simplified with future
blkdev_get/put() cleanups.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: linux-mtd@lists.infradead.org
---
 drivers/mtd/devices/block2mtd.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 2cf0cc6..806a9ed 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -246,7 +246,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size)
 		return NULL;
 
 	/* Get a handle on the device */
-	bdev = open_bdev_exclusive(devname, FMODE_READ|FMODE_WRITE, NULL);
+	bdev = open_bdev_exclusive(devname, FMODE_READ|FMODE_WRITE, dev);
 #ifndef MODULE
 	if (IS_ERR(bdev)) {
 
@@ -256,6 +256,15 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size)
 		dev_t devt = name_to_dev_t(devname);
 		if (devt) {
 			bdev = open_by_devnum(devt, FMODE_WRITE | FMODE_READ);
+			if (!IS_ERR(bdev)) {
+				int ret;
+				ret = bd_claim(bdev, dev);
+				if (ret) {
+					blkdev_put(bdev,
+						   FMODE_READ | FMODE_WRITE);
+					bdev = ERR_PTR(ret);
+				}
+			}
 		}
 	}
 #endif
-- 
1.7.1

