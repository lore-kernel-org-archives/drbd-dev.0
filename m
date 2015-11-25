Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E6CE010562C6
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:36 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:54:01 +0100
Message-Id: <1448448851-10343-29-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 28/38] drbd: fix spurious alert level printk
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

When accessing out meta data area on disk, we double check the
plausibility of the requested sector offsets, and are very noisy about
it if they look suspicious.

During initial read of our "superblock", for "external" meta data,
this triggered because the range estimate returned by
drbd_md_last_sector() was still wrong.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 3a9a0f1..a4aa7eb 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3270,6 +3270,10 @@ int drbd_md_read(struct drbd_device *device, struct drbd_backing_dev *bdev)
 	 * and read it. */
 	bdev->md.meta_dev_idx = bdev->disk_conf->meta_dev_idx;
 	bdev->md.md_offset = drbd_md_ss(bdev);
+	/* Even for (flexible or indexed) external meta data,
+	 * initially restrict us to the 4k superblock for now.
+	 * Affects the paranoia out-of-range access check in drbd_md_sync_page_io(). */
+	bdev->md.md_size_sect = 8;
 
 	if (drbd_md_sync_page_io(device, bdev, bdev->md.md_offset, READ)) {
 		/* NOTE: can't do normal error processing here as this is
-- 
1.9.1

