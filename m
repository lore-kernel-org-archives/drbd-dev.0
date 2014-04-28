Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:11 +0200
Message-Id: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/24] RFC: DRBD Fixes and REQ_DISCARD support
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

This patch series contains these new features for DRBD:
 * Support for REQ_DISCARD
 * Allow parallel promote/demote
 * Allow online changing of al-stripes and al-stripe-size with the
   resize command

and contains fixes for these issues:
 * fix potential deadlock when concurrently fencing and establishing a connection
 * fix potential distributed deadlock during verify or resync
 * fix decoding of bitmap vli rle for device sizes > 64 TB
 * fix for deadlock when using automatic split-brain-recovery
 * only fail empty flushes if no good data is reachable
 * avoid to shrink max_bio_size due to peer re-configuration
 * fix resume-io after reconnect with broken fence-peer handler
 * fix too large bursts for very slow resync rates
 * don't let application IO throttle resync to a stall
 * Fixed a hole in the challenge-response implementation
 * Fixed a theoretical IO deadlock (Only triggers with unusual small AL i.e. 7)
 * Fixed attaching to disks with fixed size external meta-data
   (This regressions was introduced with 8.4.3)
 * Fixed a crash when the connection broke at a very exact point in
   time while a graceful disconnect executes

Lars Ellenberg (15):
  drbd: fix stalled resync detection in /proc/drbd
  drbd: resync: fix too large bursts for very slow rates
  drbd: fix potential distributed deadlock during verify or resync
  drbd: don't let application IO pre-empt resync too often
  drbd: perpare for genetlink parallel_ops
  drbd: allow parallel promote/demote actions
  drbd: prepare receiving side for REQ_DISCARD
  drbd: prepare sending side for REQ_DISCARD
  drbd: Enable QUEUE_FLAG_DISCARD only if the peer can recieve P_TRIM
  drbd: fix a race between start_resync and send_and_submit
  drbd: keep max-bio size during detach/attach on disconnected primary
  drbd: add back some fairness to AL transactions
  drbd: always implicitly close last epoch when idle
  drbd: evaluate disk and network timeout on different requests
  drbd: use list_first_entry_or_null in first_peer_device/first_connection

Philipp Reisner (9):
  drbd: Break a deadlock while concurrent fencing and establishing a connection
  drbd: Leave IO suspended if the fence handler find the peer primary
  drbd: Remove drbd_wrappers.h
  drbd: Allow online layout change of AL while peer is not connected
  drbd: Do not BUG() when connection breaks in a special way
  drbd: Fix a hole in the challange-response connection authentication
  drbd: use blk_set_stacking_limits()
  drbd: Test cstate while holding req_lock
  drbd: Allow attaching of a newly created device to any backing device

 drivers/block/drbd/drbd_actlog.c   |  23 +-
 drivers/block/drbd/drbd_int.h      |  92 ++++++-
 drivers/block/drbd/drbd_main.c     |  28 ++-
 drivers/block/drbd/drbd_nl.c       | 485 ++++++++++++++++++++++---------------
 drivers/block/drbd/drbd_nla.c      |   1 -
 drivers/block/drbd/drbd_proc.c     |   2 +-
 drivers/block/drbd/drbd_protocol.h |  12 +
 drivers/block/drbd/drbd_receiver.c | 196 ++++++++++-----
 drivers/block/drbd/drbd_req.c      |  74 ++++--
 drivers/block/drbd/drbd_req.h      |   6 +-
 drivers/block/drbd/drbd_state.c    |  38 +--
 drivers/block/drbd/drbd_worker.c   | 107 ++++----
 drivers/block/drbd/drbd_wrappers.h |  54 -----
 13 files changed, 701 insertions(+), 417 deletions(-)
 delete mode 100644 drivers/block/drbd/drbd_wrappers.h

-- 
1.9.1

