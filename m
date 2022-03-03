Return-Path: <BATV+335b74d913dda7e264a9+6766+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 12B1042065E
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2022 12:20:05 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  3 Mar 2022 14:19:01 +0300
Message-Id: <20220303111905.321089-7-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 06/10] nvdimm-btt: use bvec_kmap_local in
	btt_rw_integrity
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

Using local kmaps slightly reduces the chances to stray writes, and
the bvec interface cleans up the code a little bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvdimm/btt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index cbd994f7f1fe6..9613e54c7a675 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1163,17 +1163,15 @@ static int btt_rw_integrity(struct btt *btt, struct bio_integrity_payload *bip,
 		 */
 
 		cur_len = min(len, bv.bv_len);
-		mem = kmap_atomic(bv.bv_page);
+		mem = bvec_kmap_local(&bv);
 		if (rw)
-			ret = arena_write_bytes(arena, meta_nsoff,
-					mem + bv.bv_offset, cur_len,
+			ret = arena_write_bytes(arena, meta_nsoff, mem, cur_len,
 					NVDIMM_IO_ATOMIC);
 		else
-			ret = arena_read_bytes(arena, meta_nsoff,
-					mem + bv.bv_offset, cur_len,
+			ret = arena_read_bytes(arena, meta_nsoff, mem, cur_len,
 					NVDIMM_IO_ATOMIC);
 
-		kunmap_atomic(mem);
+		kunmap_local(mem);
 		if (ret)
 			return ret;
 
-- 
2.30.2

