Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 27 Mar 2013 14:08:32 +0100
Message-Id: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/17] RFC: Pile of DRBD fixes
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

The first patch improves the idr_for_each_entry() macro and its
documentation, which is not specific to DRBD.

Each patch in this series addresses an independent issue, please refer
to the individual commit messages for a description.


Alexey Khoroshilov (1):
  drbd: add module_put() on error path in drbd_proc_open()

George Spelvin (1):
  idr: document exit conditions on idr_for_each_entry better

Lars Ellenberg (5):
  drbd: only fail empty flushes if no good data is reachable
  drbd: fix memory leak
  drbd: validate resync_after dependency on attach already
  drbd: fix drbd epoch write count for ahead/behind mode
  drbd: fix if(); found by kbuild test robot

Philipp Reisner (10):
  drbd: reset ap_in_flight counter for new connections
  drbd: abort start of resync early, if it raced with connection
    breakage
  drbd: move invalidating the whole bitmap out of after_state ch()
  drbd: fix effective error returned when refusing an invalidate
  drbd: drop now useless duplicate state request from invalidate
  drbd: fix spurious warning about bitmap being locked from detach
  drbd: Fix disconnect to keep the peer disk state if connection breaks
    during operation
  drbd: Fix build error when CONFIG_CRYPTO_HMAC is not set
  drbd: fix for deadlock when using automatic split-brain-recovery
  drbd: use sched_setscheduler()

 drivers/block/drbd/drbd_actlog.c   |    2 +-
 drivers/block/drbd/drbd_main.c     |    7 +++-
 drivers/block/drbd/drbd_nl.c       |   71 ++++++++++++++++++++----------------
 drivers/block/drbd/drbd_proc.c     |   10 ++++-
 drivers/block/drbd/drbd_receiver.c |   12 +++---
 drivers/block/drbd/drbd_req.c      |   26 +++++++------
 drivers/block/drbd/drbd_req.h      |    8 ++++
 drivers/block/drbd/drbd_state.c    |   28 +++++++-------
 drivers/block/drbd/drbd_strings.c  |    1 +
 drivers/block/drbd/drbd_worker.c   |   19 ++++++++--
 include/linux/drbd.h               |    5 ++-
 include/linux/idr.h                |   10 +++--
 12 files changed, 123 insertions(+), 76 deletions(-)

-- 
1.7.9.5

