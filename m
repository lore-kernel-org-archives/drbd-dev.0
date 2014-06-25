Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 56F94101AC77
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jun 2014 17:52:39 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 25 Jun 2014 17:52:37 +0200
Message-Id: <1403711558-27267-1-git-send-email-philipp.reisner@linbit.com>
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

this patch is intended for 3.16-rc3 (or -rc4). The issue was introduced
with the 3.16 merge window, while adding support for REQ_DISCARD to DRBD.
Please see the commit message for more details.

best regards,
 Phil

Lars Ellenberg (1):
  drbd: fix NULL pointer deref in blk_add_request_payload

 drivers/block/drbd/drbd_receiver.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
1.9.1

