Return-Path: <BATV+335b74d913dda7e264a9+6766+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 541FA42178E
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2022 12:20:26 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  3 Mar 2022 14:19:05 +0300
Message-Id: <20220303111905.321089-11-hch@lst.de>
In-Reply-To: <20220303111905.321089-1-hch@lst.de>
References: <20220303111905.321089-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Chris Zankel <chris@zankel.net>, Justin Sanders <justin@coraid.com>,
	Minchan Kim <minchan@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	linux-xtensa@linux-xtensa.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Denis Efremov <efremov@linux.com>, Coly Li <colyli@suse.de>,
	linux-block@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/10] floppy: use memcpy_{to,from}_bvec
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

Use the helpers instead of open coding them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/block/floppy.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 19c2d0327e157..8c647532e3ce9 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2485,11 +2485,9 @@ static void copy_buffer(int ssize, int max_sector, int max_sector_2)
 		}
 
 		if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
-			memcpy_to_page(bv.bv_page, bv.bv_offset, dma_buffer,
-				       size);
+			memcpy_to_bvec(&bv, dma_buffer);
 		else
-			memcpy_from_page(dma_buffer, bv.bv_page, bv.bv_offset,
-					 size);
+			memcpy_from_bvec(dma_buffer, &bv);
 
 		remaining -= size;
 		dma_buffer += size;
-- 
2.30.2

