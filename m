Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D469F1028A54
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:27 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:53:33 +0100
Message-Id: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/38] DRBD update
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

please pull these patches into your for-4.5/drivers branch.

This huge patch set updates the in-tree DRBD to what we have out of tree.
All of this has been extensively tested and in production use by LINBIT's
customers.

Andreas' patches backport some DRBD-9 interface functionality, easing
smooth migration of the user base to DRBD-9 later on. These patches
add contains touch the most lines in the series.

Lars and others did the maintenance and bug-fixing work.

PS1: I have sent all of this to LKML for review in July and August,
     sorry for the late pull request.

PS2: Optionally you can pull it here:
The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  http://git.drbd.org/linux-drbd.git/ for-4.5

for you to fetch changes up to a97f4c8180c7ddb09eeadf1994aa12f14db52fa5:

  drbd: fix error path during resize (2015-11-25 10:45:04 +0100)

Best,
 Phil

Andreas Gruenbacher (7):
  drbd: De-inline drbd_should_do_remote() and
    drbd_should_send_out_of_sync()
  drbd: Get rid of some first_peer_device() calls
  drbd: Move enum write_ordering_e to drbd.h
  drbd: drbd_adm_attach(): Add missing drbd_resync_after_changed()
  drbd: Fix locking across all resources
  drbd: Backport the "events2" command
  drbd: Backport the "status" command

Lars Ellenberg (22):
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
  drbd: prevent NULL pointer deref when resuming diskless primary
  drbd: debugfs: expose ed_data_gen_id
  drbd: use resource name in workqueue
  drbd: avoid redefinition of BITS_PER_PAGE
  drbd: use bitmap_weight() helper, don't open code
  drbd: fix spurious alert level printk
  drbd: fix queue limit setup for discard
  drbd: make drbd known to lsblk: use bd_link_disk_holder
  drbd: don't block forever in disconnect during resync if
    fencing=r-a-stonith
  drbd: fix "endless" transfer log walk in protocol A
  drbd: separate out __al_write_transaction helper function
  drbd: avoid potential deadlock during handshake
  drbd: fix error path during resize

Markus Elfring (1):
  drbd: Deletion of an unnecessary check before the function call
    "lc_destroy"

Oleg Drokin (1):
  drbd: fix memory leak in drbd_adm_resize

Philipp Reisner (5):
  drbd: Remove pointless check
  drbd: Replace 0 with the more meaningful GFP_NOWAIT
  drbd: Rename asender to ack_receiver
  drbd: Create a dedicated workqueue for sending acks on the control
    connection
  drbd: make suspend_io() / resume_io() must be thread and recursion
    safe

Roland Kammerer (2):
  MAINTAINERS: Updated information for DRBD DRIVER
  lru_cache: Converted lc_seq_printf_status to return void

 MAINTAINERS                            |   11 +-
 drivers/block/drbd/drbd_actlog.c       |  323 ++++----
 drivers/block/drbd/drbd_bitmap.c       |   22 +-
 drivers/block/drbd/drbd_debugfs.c      |   10 +
 drivers/block/drbd/drbd_int.h          |  111 ++-
 drivers/block/drbd/drbd_main.c         |   74 +-
 drivers/block/drbd/drbd_nl.c           | 1361 +++++++++++++++++++++++++++++---
 drivers/block/drbd/drbd_proc.c         |    6 +-
 drivers/block/drbd/drbd_protocol.h     |    2 +-
 drivers/block/drbd/drbd_receiver.c     |  254 +++---
 drivers/block/drbd/drbd_req.c          |  147 +++-
 drivers/block/drbd/drbd_req.h          |   17 +-
 drivers/block/drbd/drbd_state.c        |  428 +++++++++-
 drivers/block/drbd/drbd_state.h        |    6 +-
 drivers/block/drbd/drbd_state_change.h |   63 ++
 drivers/block/drbd/drbd_worker.c       |  105 +--
 include/linux/drbd.h                   |   26 +-
 include/linux/drbd_genl.h              |  149 ++++
 include/linux/idr.h                    |   14 +
 include/linux/lru_cache.h              |    2 +-
 lib/lru_cache.c                        |    4 +-
 21 files changed, 2543 insertions(+), 592 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_state_change.h

-- 
1.9.1

