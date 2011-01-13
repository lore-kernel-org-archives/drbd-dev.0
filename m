Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0BC431057A39
	for <drbd-dev@lists.linbit.com>; Thu, 13 Jan 2011 12:04:04 +0100 (CET)
Resent-Message-ID: <20110113110404.GB25975@barkeeper1-xen.linbit>
Received: from Exil2010.voltaire.com (fwil.voltaire.com [193.47.165.2])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9C3481057A40
	for <drbd-dev@lists.linbit.com>; Thu, 13 Jan 2011 10:40:07 +0100 (CET)
Date: Thu, 13 Jan 2011 11:34:35 +0200
From: Or Gerlitz <ogerlitz@voltaire.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <Pine.LNX.4.64.1101131124380.19218@zuben.voltaire.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Jens Axboe <jaxboe@fusionio.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] drbd: clean reference to old kernels
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

drop code present under #ifdef which is relevant to 2.6.28 and below

Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>

---

Philipp, I haven't noted if/where the drbd updates for 2.6.38 were posted,
have them? do you typically post the pull request to LKML or there's a lower
volume mailing list where this can be tracked?

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 11a75d3..85f6cf6 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1074,9 +1074,6 @@ int drbd_make_request_26(struct request_queue *q, struct bio *bio)
 		const int mask = sps - 1;
 		const sector_t first_sectors = sps - (sect & mask);
 		bp = bio_split(bio,
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-				bio_split_pool,
-#endif
 				first_sectors);

 		/* we need to get a "reference count" (ap_bio_cnt)
