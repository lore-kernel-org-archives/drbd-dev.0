Return-Path: <yi.zhang@huaweicloud.com>
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com
	[45.249.212.56])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F3D2C162276
	for <drbd-dev@lists.linbit.com>; Mon, 25 Aug 2025 10:50:52 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9PG03PYbzKHNkK
	for <drbd-dev@lists.linbit.com>; Mon, 25 Aug 2025 16:33:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 13F191A0E9D
	for <drbd-dev@lists.linbit.com>; Mon, 25 Aug 2025 16:33:44 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [PATCH 2/2] drbd: init queue_limits->max_hw_wzeroes_unmap_sectors
	parameter
Message-ID: <20250825083320.797165-3-yi.zhang@huaweicloud.com>
In-Reply-To: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
References: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, martin.petersen@oracle.com, john.g.garry@oracle.com,
	yangerkun@huawei.com, yi.zhang@huawei.com,
	linux-kernel@vger.kernel.org, yi.zhang@huaweicloud.com,
	linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, hch@lst.de
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
Date: Mon, 25 Aug 2025 08:51:23 -0000

From: Zhang Yi <yi.zhang@huawei.com>

The parameter max_hw_wzeroes_unmap_sectors in queue_limits should be
equal to max_write_zeroes_sectors if it is set to a non-zero value.
However, when the backend bdev is specified, this parameter is
initialized to UINT_MAX during the call to blk_set_stacking_limits(),
while only max_write_zeroes_sectors is adjusted. Therefore, this
discrepancy triggers a value check failure in blk_validate_limits().

Since the drvd driver doesn't yet support unmap write zeroes, so fix
this failure by explicitly setting max_hw_wzeroes_unmap_sectors to
zero.

Fixes: 0c40d7cb5ef3 ("block: introduce max_{hw|user}_wzeroes_unmap_sectors to queue limits")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 drivers/block/drbd/drbd_nl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index e09930c2b226..91f3b8afb63c 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1330,6 +1330,7 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		lim.max_write_zeroes_sectors = DRBD_MAX_BBIO_SECTORS;
 	else
 		lim.max_write_zeroes_sectors = 0;
+	lim.max_hw_wzeroes_unmap_sectors = 0;
 
 	if ((lim.discard_granularity >> SECTOR_SHIFT) >
 	    lim.max_hw_discard_sectors) {
-- 
2.46.1

