Return-Path: <tom.leiming@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9732A1056483
	for <drbd-dev@lists.linbit.com>; Tue, 27 Dec 2016 17:05:01 +0100 (CET)
Received: by mail-pf0-f193.google.com with SMTP id c4so18357611pfb.3
	for <drbd-dev@lists.linbit.com>; Tue, 27 Dec 2016 08:05:01 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue, 27 Dec 2016 23:55:50 +0800
Message-Id: <1482854250-13481-2-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <tom.leiming@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH v1 01/54] block: drbd: comment on direct access
	bvec table
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

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/drbd/drbd_bitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index ab62b81c2ca7..ce9506da30ad 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -953,6 +953,7 @@ static void drbd_bm_endio(struct bio *bio)
 	struct drbd_bm_aio_ctx *ctx = bio->bi_private;
 	struct drbd_device *device = ctx->device;
 	struct drbd_bitmap *b = device->bitmap;
+	/* single page bio, safe for multipage bvec */
 	unsigned int idx = bm_page_to_idx(bio->bi_io_vec[0].bv_page);
 
 	if ((ctx->flags & BM_AIO_COPY_PAGES) == 0 &&
-- 
2.7.4

