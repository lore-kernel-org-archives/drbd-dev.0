Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 64841101E048
	for <drbd-dev@lists.linbit.com>; Wed,  9 Jul 2014 21:18:33 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed,  9 Jul 2014 21:18:31 +0200
Message-Id: <1404933512-5166-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] Fix DRBD regression
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

In 3.13 the commit 786235eeb 'kthread: make kthread_create() killable'
broke DRBD's fence peer mechanism in a subtle way. Since only a part
of our user base has fencing properly configured this regression was
unnoticed until now. Please consider to submit this for 3.16-rc5.

Thanks,
 Phil

Lars Ellenberg (1):
  drbd: fix regression 'out of mem, failed to invoke fence-peer helper'

 drivers/block/drbd/drbd_nl.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
1.9.1

