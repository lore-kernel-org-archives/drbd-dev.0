Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 30F661056443
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:52:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2249C3EC8E3
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:52:59 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id pURCd8I4dqsI for <drbd-dev@lists.linbit.com>;
	Tue,  5 Apr 2016 14:52:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 027DA3F76F6
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:52:59 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dbrzxmAct_8q for <drbd-dev@lists.linbit.com>;
	Tue,  5 Apr 2016 14:52:58 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id CBBA33F76EA
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:52:58 +0200 (CEST)
Resent-Message-ID: <20160405125258.GY3078@soda.linbit>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DC8B71056441
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 13:58:50 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id q129so1166817pfb.3
	for <drbd-dev@lists.linbit.com>; Tue, 05 Apr 2016 04:58:50 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue,  5 Apr 2016 19:56:47 +0800
Message-Id: <1459857443-20611-3-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1459857443-20611-1-git-send-email-tom.leiming@gmail.com>
References: <1459857443-20611-1-git-send-email-tom.leiming@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 02/27] block: drbd: use bio_get_base_vec() to
	retrieve the 1st bvec
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
 drivers/block/drbd/drbd_bitmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 92d6fc0..ccbd1e0 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -938,7 +938,9 @@ static void drbd_bm_endio(struct bio *bio)
 	struct drbd_bm_aio_ctx *ctx = bio->bi_private;
 	struct drbd_device *device = ctx->device;
 	struct drbd_bitmap *b = device->bitmap;
-	unsigned int idx = bm_page_to_idx(bio->bi_io_vec[0].bv_page);
+	/* single bvec bio */
+	const struct bio_vec *bvec = bio_get_base_vec(bio);
+	unsigned int idx = bm_page_to_idx(bvec->bv_page);
 
 	if ((ctx->flags & BM_AIO_COPY_PAGES) == 0 &&
 	    !bm_test_page_unchanged(b->bm_pages[idx]))
-- 
1.9.1

