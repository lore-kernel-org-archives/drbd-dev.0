Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B9917101AC75
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 10:43:15 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  3 Jul 2014 10:42:52 +0200
Message-Id: <1404376995-4877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/23] RFC DRBD fixes
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

this series adds a debugfs hierarchy to DRBD. It unveils a lot
of information about timing of states/stages of IO requests.

This information helps a lot while optimizing DRBD for SSD
based IO stacks.

Dan Carpenter (1):
  drbd: silence underflow warning in read_in_block()

Lars Ellenberg (22):
  drbd: poison free'd device, resource and connection structs
  drbd: fix drbd_destroy_device reference count updates
  drbd: track meta data IO intent, start and submit time
  drbd: gather detailed timing statistics for drbd_requests
  drbd: add lists to find oldest pending requests
  drbd: add caching oldest request pointers for replication stages
  drbd: improve throttling decisions of background resynchronisation
  drbd: track timing details of peer_requests
  drbd: register peer requests on read_ee early
  drbd: track details of bitmap IO
  drbd: debugfs: add basic hierarchy
  drbd: debugfs: add in_flight_summary data
  drbd: debugfs: deal with destructor racing with open of debugfs file
  drbd: debugfs: Add in_flight_summary
  drbd: debugfs: add callback_history
  drbd: debugfs: add per volume oldest_requests
  drbd: debugfs: add version tag to debugfs files
  drbd: debugfs: add per connection oldest requests
  drbd: debugfs: add per device data_gen_id
  drbd: resync should only lock out specific ranges
  drbd: drop spurious parameters from _drbd_md_sync_page_io
  drbd: implicitly truncate cpu-mask

 drivers/block/drbd/Makefile        |   1 +
 drivers/block/drbd/drbd_actlog.c   |  80 +++-
 drivers/block/drbd/drbd_bitmap.c   |  70 ++-
 drivers/block/drbd/drbd_debugfs.c  | 958 +++++++++++++++++++++++++++++++++++++
 drivers/block/drbd/drbd_debugfs.h  |  39 ++
 drivers/block/drbd/drbd_int.h      | 175 ++++++-
 drivers/block/drbd/drbd_main.c     | 116 +++--
 drivers/block/drbd/drbd_nl.c       |   4 +-
 drivers/block/drbd/drbd_proc.c     |   3 +
 drivers/block/drbd/drbd_receiver.c | 138 ++++--
 drivers/block/drbd/drbd_req.c      | 411 +++++++++++-----
 drivers/block/drbd/drbd_worker.c   |  59 ++-
 include/linux/drbd.h               |   2 +-
 lib/lru_cache.c                    |  21 +-
 14 files changed, 1784 insertions(+), 293 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_debugfs.c
 create mode 100644 drivers/block/drbd/drbd_debugfs.h

-- 
1.9.1

