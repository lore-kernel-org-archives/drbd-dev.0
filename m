Return-Path: <BATV+2fedbe304aabaf399917+7597+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 51762420640
	for <drbd-dev@lists.linbit.com>; Tue, 11 Jun 2024 08:32:38 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/26] loop: stop using loop_reconfigure_limits in
	__loop_clr_fd
Date: Tue, 11 Jun 2024 07:19:03 +0200
Message-ID: <20240611051929.513387-4-hch@lst.de>
In-Reply-To: <20240611051929.513387-1-hch@lst.de>
References: <20240611051929.513387-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: nvdimm@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, linux-mtd@lists.infradead.org,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yu Kuai <yukuai3@huawei.com>, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, Mike Snitzer <snitzer@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-mmc@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	virtualization@lists.linux.dev, Lars Ellenberg <lars.ellenberg@linbit.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

__loop_clr_fd wants to clear all settings on the device.  Prepare for
moving more settings into the block limits by open coding
loop_reconfigure_limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 93780f41646b75..93a49c40a31a71 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1133,6 +1133,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 
 static void __loop_clr_fd(struct loop_device *lo, bool release)
 {
+	struct queue_limits lim;
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
 
@@ -1156,7 +1157,14 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	lo->lo_offset = 0;
 	lo->lo_sizelimit = 0;
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
-	loop_reconfigure_limits(lo, 512, false);
+
+	/* reset the block size to the default */
+	lim = queue_limits_start_update(lo->lo_queue);
+	lim.logical_block_size = 512;
+	lim.physical_block_size = 512;
+	lim.io_min = 512;
+	queue_limits_commit_update(lo->lo_queue, &lim);
+
 	invalidate_disk(lo->lo_disk);
 	loop_sysfs_exit(lo);
 	/* let user-space know about this change */
-- 
2.43.0

