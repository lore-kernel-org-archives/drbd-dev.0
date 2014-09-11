Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2E833101AC7E
	for <drbd-dev@lists.linbit.com>; Thu, 11 Sep 2014 14:29:14 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Thu, 11 Sep 2014 14:29:04 +0200
Message-Id: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/9] DRBD updates for 3.18
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

please consider to put these patches into your (future) for-3.18/drivers
branch. I have posted it for review on August 28. It consists mainly of
minor cleanups, and an important performance improvement. With that
DRBD was seen to write with 160k IOPS, on SSDs.

You may take the patches from this posting, or pull them from
http://git.drbd.org/linux-2.6-drbd.git for-3.18-rc1
the branch there is based on Linux 3.17-rc4.

Andreas Gruenbacher (5):
  drbd: Use better variable names
  drbd: Use consistent names for all the bi_end_io callbacks
  drbd: Avoid inconsistent locking warning
  drbd: Get rid of the __no_warn and __cond_lock macros
  drbd: Get rid of the WORK_PENDING macro

Lars Ellenberg (2):
  drbd: Improve asender performance
  drbd: reduce lock contention in drbd_worker

Philipp Marek (1):
  drbd: Remove superfluous newline from "resync_extents" debugfs entry.

Philipp Reisner (1):
  drbd: Add missing newline in resync progress display in /proc/drbd

 drivers/block/drbd/drbd_actlog.c   |  4 +--
 drivers/block/drbd/drbd_bitmap.c   |  6 ++---
 drivers/block/drbd/drbd_debugfs.c  |  2 +-
 drivers/block/drbd/drbd_int.h      | 19 +++++++-------
 drivers/block/drbd/drbd_main.c     | 28 ++++++++++----------
 drivers/block/drbd/drbd_proc.c     |  4 ++-
 drivers/block/drbd/drbd_receiver.c | 52 +++++++++++++++++++++-----------------
 drivers/block/drbd/drbd_req.c      |  2 +-
 drivers/block/drbd/drbd_state.c    | 18 ++++++-------
 drivers/block/drbd/drbd_worker.c   | 51 +++++++++++++++----------------------
 10 files changed, 93 insertions(+), 93 deletions(-)

-- 
1.9.1

