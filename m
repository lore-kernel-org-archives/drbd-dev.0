Return-Path: <caihuoqing@baidu.com>
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 597814203EF
	for <drbd-dev@lists.linbit.com>; Mon,  2 Aug 2021 10:16:12 +0200 (CEST)
From: Cai Huoqing <caihuoqing@baidu.com>
To: <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
	<axboe@kernel.dk>
Date: Mon, 2 Aug 2021 16:00:21 +0800
Message-ID: <20210802080023.1259-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Cai Huoqing <caihuoqing@baidu.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/2] drbd: Make use of PFN_UP helper macro
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

it's a nice refactor to make use of PFN_UP helper macro.
when run checkpath.pl for the first patch, found that
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'.
so fix it. BTW

Cai Huoqing (2):
  drbd: Make use of PFN_UP helper macro
  drbd: Replace "unsigned" with "unsigned int"

 drivers/block/drbd/drbd_bitmap.c   | 2 +-
 drivers/block/drbd/drbd_receiver.c | 8 ++++----
 drivers/block/drbd/drbd_worker.c   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.1

