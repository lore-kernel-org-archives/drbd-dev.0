Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 89A3A101E06C
	for <drbd-dev@lists.linbit.com>; Mon, 25 Aug 2014 15:16:39 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 25 Aug 2014 15:16:30 +0200
Message-Id: <1408972598-16650-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/8] RFC DRBD cleanups and performance work
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

Most of these patches are cleanup work. The exception are the two
patches from Lars Ellenberg. These two can bring DRBD's performance
into the area of 160k IOPs. (On fitting hardware of course).

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

 drivers/block/drbd/drbd_actlog.c   |  4 +--
 drivers/block/drbd/drbd_bitmap.c   |  6 ++---
 drivers/block/drbd/drbd_debugfs.c  |  2 +-
 drivers/block/drbd/drbd_int.h      | 19 +++++++-------
 drivers/block/drbd/drbd_main.c     | 28 ++++++++++----------
 drivers/block/drbd/drbd_receiver.c | 52 +++++++++++++++++++++-----------------
 drivers/block/drbd/drbd_req.c      |  2 +-
 drivers/block/drbd/drbd_state.c    | 18 ++++++-------
 drivers/block/drbd/drbd_worker.c   | 51 +++++++++++++++----------------------
 9 files changed, 90 insertions(+), 92 deletions(-)

-- 
1.9.1

