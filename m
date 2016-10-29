Return-Path: <tom.leiming@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 08E981056468
	for <drbd-dev@lists.linbit.com>; Sat, 29 Oct 2016 10:23:44 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id s8so3400495pfj.2
	for <drbd-dev@lists.linbit.com>; Sat, 29 Oct 2016 01:23:44 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Sat, 29 Oct 2016 16:08:02 +0800
Message-Id: <1477728600-12938-4-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <tom.leiming@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 03/60] block: drbd: remove impossible failure
	handling
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

For a non-cloned bio, bio_add_page() only returns failure when
the io vec table is full, but in that case, bio->bi_vcnt can't
be zero at all.

So remove the impossible failure handling.

Acked-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 942384f34e22..c537e3bd09eb 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1648,20 +1648,8 @@ int drbd_submit_peer_request(struct drbd_device *device,
 
 	page_chain_for_each(page) {
 		unsigned len = min_t(unsigned, data_size, PAGE_SIZE);
-		if (!bio_add_page(bio, page, len, 0)) {
-			/* A single page must always be possible!
-			 * But in case it fails anyways,
-			 * we deal with it, and complain (below). */
-			if (bio->bi_vcnt == 0) {
-				drbd_err(device,
-					"bio_add_page failed for len=%u, "
-					"bi_vcnt=0 (bi_sector=%llu)\n",
-					len, (uint64_t)bio->bi_iter.bi_sector);
-				err = -ENOSPC;
-				goto fail;
-			}
+		if (!bio_add_page(bio, page, len, 0))
 			goto next_bio;
-		}
 		data_size -= len;
 		sector += len >> 9;
 		--nr_pages;
-- 
2.7.4

