Return-Path: <BATV+ade674efe42abf9194a0+6102+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 66277420308
	for <drbd-dev@lists.linbit.com>; Fri,  8 May 2020 18:44:35 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri,  8 May 2020 18:15:07 +0200
Message-Id: <20200508161517.252308-6-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 05/15] ps3vram: stop using ->queuedata
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
 drivers/block/ps3vram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 821d4d8b1d763..5a1d1d137c724 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -587,7 +587,7 @@ static struct bio *ps3vram_do_bio(struct ps3_system_bus_device *dev,
 
 static blk_qc_t ps3vram_make_request(struct request_queue *q, struct bio *bio)
 {
-	struct ps3_system_bus_device *dev = q->queuedata;
+	struct ps3_system_bus_device *dev = bio->bi_disk->private_data;
 	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	int busy;
 
@@ -745,7 +745,6 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 	}
 
 	priv->queue = queue;
-	queue->queuedata = dev;
 	blk_queue_max_segments(queue, BLK_MAX_SEGMENTS);
 	blk_queue_max_segment_size(queue, BLK_MAX_SEGMENT_SIZE);
 	blk_queue_max_hw_sectors(queue, BLK_SAFE_MAX_SECTORS);
-- 
2.26.2

