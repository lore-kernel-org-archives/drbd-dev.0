Return-Path: <philipp.reisner@linbit.com>
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
	[209.85.208.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 573974205D4
	for <drbd-dev@lists.linbit.com>; Wed,  6 Mar 2024 15:04:20 +0100 (CET)
Received: by mail-ed1-f49.google.com with SMTP id
	4fb4d7f45d1cf-564fc495d83so8382089a12.0
	for <drbd-dev@lists.linbit.com>; Wed, 06 Mar 2024 06:04:20 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/7] drbd: don't set max_write_zeroes_sectors in
	decide_on_discard_support
Date: Wed,  6 Mar 2024 15:03:30 +0100
Message-Id: <20240306140332.623759-6-philipp.reisner@linbit.com>
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
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

From: Christoph Hellwig <hch@lst.de>

fixup_write_zeroes always overrides the max_write_zeroes_sectors value
a little further down the callchain, so don't bother to setup a limit
in decide_on_discard_support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 0f40fdee0899..a79b7fe5335d 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1260,7 +1260,6 @@ static void decide_on_discard_support(struct drbd_device *device,
 	blk_queue_discard_granularity(q, 512);
 	max_discard_sectors = drbd_max_discard_sectors(connection);
 	blk_queue_max_discard_sectors(q, max_discard_sectors);
-	blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
 	return;
 
 not_supported:
-- 
2.40.1

