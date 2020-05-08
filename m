Return-Path: <BATV+ade674efe42abf9194a0+6102+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6A8234203EE
	for <drbd-dev@lists.linbit.com>; Fri,  8 May 2020 18:44:38 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri,  8 May 2020 18:15:14 +0200
Message-Id: <20200508161517.252308-13-hch@lst.de>
In-Reply-To: <20200508161517.252308-1-hch@lst.de>
References: <20200508161517.252308-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
	linux-raid@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	linux-nvdimm@lists.01.org, Geoff Levand <geoff@infradead.org>,
	linux-kernel@vger.kernel.org, Jim Paris <jim@jtan.com>,
	linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	linux-m68k@lists.linux-m68k.org, Philip Kelleher <pjk1939@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Joshua Morris <josh.h.morris@us.ibm.com>,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/15] md: stop using ->queuedata
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 271e8a5873549..c079ecf77c564 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -466,7 +466,7 @@ static blk_qc_t md_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int rw = bio_data_dir(bio);
 	const int sgrp = op_stat_group(bio_op(bio));
-	struct mddev *mddev = q->queuedata;
+	struct mddev *mddev = bio->bi_disk->private_data;
 	unsigned int sectors;
 
 	if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
@@ -5626,7 +5626,6 @@ static int md_alloc(dev_t dev, char *name)
 	mddev->queue = blk_alloc_queue(md_make_request, NUMA_NO_NODE);
 	if (!mddev->queue)
 		goto abort;
-	mddev->queue->queuedata = mddev;
 
 	blk_set_stacking_limits(&mddev->queue->limits);
 
-- 
2.26.2

