Return-Path: <mcgrof@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 10DDA425C97
	for <drbd-dev@lists.linbit.com>; Sat, 16 Sep 2023 01:01:58 +0200 (CEST)
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, hch@infradead.org, djwong@kernel.org,
	minchan@kernel.org, senozhatsky@chromium.org
Date: Fri, 15 Sep 2023 15:43:40 -0700
Message-Id: <20230915224343.2740317-2-mcgrof@kernel.org>
In-Reply-To: <20230915224343.2740317-1-mcgrof@kernel.org>
References: <20230915224343.2740317-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Cc: p.raghav@samsung.com, linux-xfs@vger.kernel.org, rohan.puri@samsung.com,
	da.gomez@samsung.com, mcgrof@kernel.org, patches@lists.linux.dev,
	willy@infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	dm-devel@redhat.com, hare@suse.de,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-fsdevel@vger.kernel.org, rpuri.linux@gmail.com,
	kbusch@kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v3 1/4] drbd: use PAGE_SECTORS_SHIFT and
	PAGE_SECTORS
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

Replace common constants with generic versions.
This produces no functional changes.

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/drbd/drbd_bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 85ca000a0564..1a1782f55e61 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1000,7 +1000,7 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 	unsigned int len;
 
 	first_bm_sect = device->ldev->md.md_offset + device->ldev->md.bm_offset;
-	on_disk_sector = first_bm_sect + (((sector_t)page_nr) << (PAGE_SHIFT-SECTOR_SHIFT));
+	on_disk_sector = first_bm_sect + (((sector_t)page_nr) << PAGE_SECTORS_SHIFT);
 
 	/* this might happen with very small
 	 * flexible external meta data device,
@@ -1008,7 +1008,7 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 	last_bm_sect = drbd_md_last_bitmap_sector(device->ldev);
 	if (first_bm_sect <= on_disk_sector && last_bm_sect >= on_disk_sector) {
 		sector_t len_sect = last_bm_sect - on_disk_sector + 1;
-		if (len_sect < PAGE_SIZE/SECTOR_SIZE)
+		if (len_sect < PAGE_SECTORS)
 			len = (unsigned int)len_sect*SECTOR_SIZE;
 		else
 			len = PAGE_SIZE;
-- 
2.39.2

