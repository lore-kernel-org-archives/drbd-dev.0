Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6D650105643D
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:53:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3581E3EC8E3
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:53:00 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id hTxYZUv-ffzq for <drbd-dev@lists.linbit.com>;
	Tue,  5 Apr 2016 14:53:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 174333F76EA
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:53:00 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hj0MF1FP3iWy for <drbd-dev@lists.linbit.com>;
	Tue,  5 Apr 2016 14:53:00 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id DEC9F3EC8E3
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:52:59 +0200 (CEST)
Resent-Message-ID: <20160405125259.GZ3078@soda.linbit>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BE6981056442
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 13:59:00 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id d184so1169734pfc.1
	for <drbd-dev@lists.linbit.com>; Tue, 05 Apr 2016 04:59:00 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue,  5 Apr 2016 19:56:48 +0800
Message-Id: <1459857443-20611-4-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1459857443-20611-1-git-send-email-tom.leiming@gmail.com>
References: <1459857443-20611-1-git-send-email-tom.leiming@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 03/27] block: drbd: remove impossible failure
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

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 050aaa1..1b0ed15 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1465,20 +1465,8 @@ next_bio:
 
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
1.9.1

