Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8ADDE101AC7E
	for <drbd-dev@lists.linbit.com>; Wed, 29 Oct 2014 17:37:57 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 29 Oct 2014 17:37:49 +0100
Message-Id: <1414600676-11203-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/7] RFC DRBD updates for 3.19
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

Hi,

these are the proposed DRBD changes for 3.19. All minor stuff
and fixes.

I will repost it in one week with the appropriate CC: stable
header set, and eventual feedback integrated.

Thanks!


Andreas Gruenbacher (2):
  drbd: Minor cleanups
  drbd: Only use drbd_msg_put_info() in drbd_nl.c

Lars Ellenberg (2):
  drbd: fix resync throttling initialization
  drbd: merge_bvec_fn: properly remap bvm->bi_bdev

Philipp Reisner (3):
  drbd: fix race between role change and handshake
  drbd: Fix state change in case of connection timeout
  drbd: Remove an useless copy of kernel_setsockopt()

 drivers/block/drbd/drbd_actlog.c   |  3 +-
 drivers/block/drbd/drbd_int.h      | 39 +++++------------------
 drivers/block/drbd/drbd_main.c     | 23 ++++----------
 drivers/block/drbd/drbd_nl.c       | 64 +++++++++++++++++---------------------
 drivers/block/drbd/drbd_receiver.c |  2 +-
 drivers/block/drbd/drbd_req.c      |  3 +-
 drivers/block/drbd/drbd_state.c    | 42 ++++++++++++++++++++-----
 drivers/block/drbd/drbd_state.h    |  5 +++
 drivers/block/drbd/drbd_worker.c   |  5 ++-
 include/linux/drbd.h               |  2 +-
 10 files changed, 90 insertions(+), 98 deletions(-)

-- 
1.9.1

