Return-Path: <bobo.shaobowang@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6099642096B
	for <drbd-dev@lists.linbit.com>;
	Thu, 24 Nov 2022 03:00:05 +0100 (CET)
From: Wang ShaoBo <bobo.shaobowang@huawei.com>
To: 
Date: Thu, 24 Nov 2022 09:58:15 +0800
Message-ID: <20221124015817.2729789-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: axboe@kernel.dk, bobo.shaobowang@huawei.com, linux-block@vger.kernel.org,
	lars.ellenberg@linbit.com, liwei391@huawei.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v4 0/2] drbd bugfix and cleanup.
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

drbd bugfix and cleanup.

v4:
  - solve conflict in applying patch [2/2] to for-6.2/block branch

v3:
  - add out_* label for destroy_workqueue().

v2:
  - add new patch for removing useless memset().


Wang ShaoBo (2):
  drbd: remove call to memset before free device/resource/connection
  drbd: destroy workqueue when drbd device was freed

 drivers/block/drbd/drbd_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.25.1

