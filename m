Return-Path: <lijinlin3@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2ED1D420629
	for <drbd-dev@lists.linbit.com>;
	Fri, 10 Dec 2021 06:08:59 +0100 (CET)
From: Li Jinlin <lijinlin3@huawei.com>
To: <song@kernel.org>, <philipp.reisner@linbit.com>,
	<lars.ellenberg@linbit.com>, <axboe@kernel.dk>, <hare@suse.de>,
	<jack@suse.cz>, <ming.lei@redhat.com>, <tj@kernel.org>,
	<mcgrof@kernel.org>, <mcroce@microsoft.com>
Date: Fri, 10 Dec 2021 13:17:04 +0800
Message-ID: <20211210051707.2202646-1-lijinlin3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
	linfeilong@huawei.com, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/3] Fix undefined behaviour during device
	synchronization
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

md/drbd drivers use 'signed int' variable to track sync vs non-sync IO,
and judge whether sync IO needs to be throttled by signed comparison.
If the value of the variable is greater than INT_MAX or close to
INT_MAX, some undefined behavior may occur.

Fix by using 64bit signed integer type.

The v2 "md: Fix undefined behaviour in is_mddev_idle" patch
differences to v1:
- add ubsan info in message
- use 64bit signed integer type instead of long type;
- move sync_io variable form struct gendisk to struct md_rdev, and 
  modify md_sync_acct() and md_sync_acct_bio() to fit for this change.

Li Jinlin (3):
  md: Fix undefined behaviour in is_mddev_idle
  drdb: Fix undefined behaviour in drbd_rs_c_min_rate_throttle
  drdb: Remove useless variable in struct drbd_device

 drivers/block/drbd/drbd_bitmap.c   |  2 +-
 drivers/block/drbd/drbd_int.h      |  5 ++---
 drivers/block/drbd/drbd_main.c     |  3 +--
 drivers/block/drbd/drbd_receiver.c | 12 ++++++------
 drivers/block/drbd/drbd_state.c    |  1 -
 drivers/block/drbd/drbd_worker.c   |  5 ++---
 drivers/md/md.c                    |  6 +++---
 drivers/md/md.h                    | 13 +++++++++----
 drivers/md/raid1.c                 |  4 ++--
 drivers/md/raid10.c                | 24 ++++++++++++------------
 drivers/md/raid5.c                 |  4 ++--
 include/linux/genhd.h              |  1 -
 12 files changed, 40 insertions(+), 40 deletions(-)

-- 
2.27.0

