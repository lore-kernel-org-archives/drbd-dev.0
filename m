Return-Path: <yi.zhang@huaweicloud.com>
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com
	[45.249.212.56])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F211016094F
	for <drbd-dev@lists.linbit.com>; Mon, 25 Aug 2025 10:50:52 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9PFy29kqzKHNjw
	for <drbd-dev@lists.linbit.com>; Mon, 25 Aug 2025 16:33:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DE9F01A01A6
	for <drbd-dev@lists.linbit.com>; Mon, 25 Aug 2025 16:33:41 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [PATCH 0/2] Fix the initialization of max_hw_wzeroes_unmap_sectors
	for stacking drivers
Message-ID: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
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
Date: Mon, 25 Aug 2025 08:50:53 -0000

From: Zhang Yi <yi.zhang@huawei.com>

Hello,

This series fixes the initialization of max_hw_wzeroes_unmap_sectors in
queue_limits for all md raid and drbd drivers, preventing
blk_validate_limits() failures on underlying devices that support the
unmap write zeroes command.

Best regards,
Yi.

Zhang Yi (2):
  md: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
  drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter

 drivers/block/drbd/drbd_nl.c | 1 +
 drivers/md/md-linear.c       | 1 +
 drivers/md/raid0.c           | 1 +
 drivers/md/raid1.c           | 1 +
 drivers/md/raid10.c          | 1 +
 drivers/md/raid5.c           | 1 +
 6 files changed, 6 insertions(+)

-- 
2.46.1

