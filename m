Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 415ED1019A36
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jul 2015 13:22:06 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2015 13:21:35 +0200
Message-Id: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/19] RFC DRBD updates for the 4.3 merge window
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

these patches are in the end intended for the 4.3 merge window.

Apart from a few random fixes and cleanups, the biggest part of
the patch are two new userspace commands for drbd ("events" and
"status"). These two commands where developed with the drbd-9
effort. Introducing them right now into the current code base,
allows for smooth transition of the user base.


Andreas Gruenbacher (7):
  drbd: De-inline drbd_should_do_remote() and
    drbd_should_send_out_of_sync()
  drbd: Get rid of some first_peer_device() calls
  drbd: Move enum write_ordering_e to drbd.h
  drbd: drbd_adm_attach(): Add missing drbd_resync_after_changed()
  drbd: Fix locking across all resources
  drbd: Backport the "events2" command
  drbd: Backport the "status" command

Lars Ellenberg (9):
  drbd: Fix spurious disk-timeout
  drbd: drop remnants of connector -- we don't use it anymore in drbd
    8.4
  drbd: drbdsetup detach of an unresponsive local disk should not block
    IO "forever"
  drbd: also bump UUIDs if a diskless primary connects
  drbd: add comment why we want to first call local-io-error, then send
    state
  drbd: drbd_panic_after_delayed_completion_of_aborted_request()
  drbd: improve network timeout detection
  drbd: fix NULL deref in remember_new_state
  drbd: fix refcount error during detach of an already failed disk

Markus Elfring (1):
  drbd: Deletion of an unnecessary check before the function call
    "lc_destroy"

Philipp Reisner (2):
  drbd: Remove pointless check
  drbd: Replace 0 with the more meaningful GFP_NOWAIT

 drivers/block/drbd/drbd_int.h          |   71 ++-
 drivers/block/drbd/drbd_main.c         |   26 +-
 drivers/block/drbd/drbd_nl.c           | 1077 +++++++++++++++++++++++++++++++-
 drivers/block/drbd/drbd_proc.c         |    6 +-
 drivers/block/drbd/drbd_receiver.c     |   42 +-
 drivers/block/drbd/drbd_req.c          |  143 ++++-
 drivers/block/drbd/drbd_req.h          |   17 +-
 drivers/block/drbd/drbd_state.c        |  426 ++++++++++++-
 drivers/block/drbd/drbd_state.h        |    6 +-
 drivers/block/drbd/drbd_state_change.h |   63 ++
 drivers/block/drbd/drbd_worker.c       |   95 ++-
 include/linux/drbd.h                   |   24 +-
 include/linux/drbd_genl.h              |  149 +++++
 include/linux/idr.h                    |   14 +
 14 files changed, 1983 insertions(+), 176 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_state_change.h

-- 
1.9.1

