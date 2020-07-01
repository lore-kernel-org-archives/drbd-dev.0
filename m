Return-Path: <BATV+501e1de201b53739768b+6156+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D89094203F1
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jul 2020 11:43:32 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  1 Jul 2020 10:59:38 +0200
Message-Id: <20200701085947.3354405-12-hch@lst.de>
In-Reply-To: <20200701085947.3354405-1-hch@lst.de>
References: <20200701085947.3354405-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
	linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org,
	dm-devel@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/20] fs: remove a weird comment in submit_bh_wbc
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

All bios can get remapped if submitted to partitions.  No need to
comment on that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 64fe82ec65ff1f..2725ebbcfdc246 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3040,12 +3040,7 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
 		clear_buffer_write_io_error(bh);
 
-	/*
-	 * from here on down, it's all bio -- do the initial mapping,
-	 * submit_bio -> generic_make_request may further map this bio around
-	 */
 	bio = bio_alloc(GFP_NOIO, 1);
-
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_write_hint = write_hint;
-- 
2.26.2

