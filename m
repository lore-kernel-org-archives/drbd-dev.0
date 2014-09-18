Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BD5A1101AC7F
	for <drbd-dev@lists.linbit.com>; Thu, 18 Sep 2014 16:49:44 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 18 Sep 2014 16:49:40 +0200
Message-Id: <1411051782-23375-1-git-send-email-philipp.reisner@linbit.com>
Cc: Michel Lespinasse <walken@google.com>, Lai Jiangshan <laijs@cn.fujitsu.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/2] More for the 3.18 merge window
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

Hi Jens,

please put these two patches into your for-3.18/drivers branch.  They fix
the safety code for concurrent overlapping write detection in a DRBD
dual primary setup.

The first of those two should also go to the stable kernels, I marked it
with CC: stable@kernel.org


Lai Jiangshan (2):
  drbd: compute the end before rb_insert_augmented()
  drbd: use RB_DECLARE_CALLBACKS() to define augment callbacks

 drivers/block/drbd/drbd_interval.c | 40 ++++++--------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

-- 
1.9.1

