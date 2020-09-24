Return-Path: <BATV+004c9619e75dbad284dd+6241+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B8AC6420DF6
	for <drbd-dev@lists.linbit.com>; Thu, 24 Sep 2020 08:54:11 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 24 Sep 2020 08:51:31 +0200
Message-Id: <20200924065140.726436-5-hch@lst.de>
In-Reply-To: <20200924065140.726436-1-hch@lst.de>
References: <20200924065140.726436-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-raid@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Justin Sanders <justin@coraid.com>, Jan Kara <jack@suse.cz>,
	Minchan Kim <minchan@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	linux-bcache@vger.kernel.org, Coly Li <colyli@suse.de>,
	linux-block@vger.kernel.org, Song Liu <song@kernel.org>,
	dm-devel@redhat.com, linux-mtd@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/13] aoe: set an optimal I/O size
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

aoe forces a larger readahead size, but any reason to do larger I/O
is not limited to readahead.  Also set the optimal I/O size, and
remove the local constants in favor of just using SZ_2G.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/aoe/aoeblk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 5ca7216e9e01f3..d8cfc233e64b93 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -347,7 +347,6 @@ aoeblk_gdalloc(void *vp)
 	mempool_t *mp;
 	struct request_queue *q;
 	struct blk_mq_tag_set *set;
-	enum { KB = 1024, MB = KB * KB, READ_AHEAD = 2 * MB, };
 	ulong flags;
 	int late = 0;
 	int err;
@@ -407,7 +406,8 @@ aoeblk_gdalloc(void *vp)
 	WARN_ON(d->gd);
 	WARN_ON(d->flags & DEVFL_UP);
 	blk_queue_max_hw_sectors(q, BLK_DEF_MAX_SECTORS);
-	q->backing_dev_info->ra_pages = READ_AHEAD / PAGE_SIZE;
+	q->backing_dev_info->ra_pages = SZ_2M / PAGE_SIZE;
+	blk_queue_io_opt(q, SZ_2M);
 	d->bufpool = mp;
 	d->blkq = gd->queue = q;
 	q->queuedata = d;
-- 
2.28.0

