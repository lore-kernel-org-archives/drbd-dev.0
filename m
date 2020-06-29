Return-Path: <BATV+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4324D4203E1
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jun 2020 22:23:04 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 29 Jun 2020 21:39:36 +0200
Message-Id: <20200629193947.2705954-10-hch@lst.de>
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
	linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org,
	dm-devel@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/20] bcache: stop setting ->queuedata
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

Nothing in bcache actually uses the ->queuedata field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 2014016f9a60d3..21aa168113d30b 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -876,7 +876,6 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 		return -ENOMEM;
 
 	d->disk->queue			= q;
-	q->queuedata			= d;
 	q->backing_dev_info->congested_data = d;
 	q->limits.max_hw_sectors	= UINT_MAX;
 	q->limits.max_sectors		= UINT_MAX;
-- 
2.26.2

