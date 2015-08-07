Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3EA90100EC11
	for <drbd-dev@lists.linbit.com>; Fri,  7 Aug 2015 14:52:11 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>
Date: Fri, 07 Aug 2015 14:51:56 +0200
Message-ID: <18460711.j6in3RjE5D@fat-tyre>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: lnux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [GIT PULL] DRBD updates for 4.3
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

please pull these patches into your	for-4.3/drivers tree. I have posted
them for review last week and Wednesday 


The following changes since commit c45f5c9943ce0b16b299b543c2aae12408039027:

  nvme: Fixes u64 division which breaks i386 builds (2015-07-21 15:36:24 -0600)

are available in the git repository at:

  http://git.drbd.org/linux-drbd.git/ for-4.3

for you to fetch changes up to f8381300ea1812299d5ddf83c5f890b231bcb830:

  MAINTAINERS: Updated information for DRBD DRIVER (2015-08-07 14:33:53 +0200)

----------------------------------------------------------------
Andreas Gruenbacher (7):
      drbd: De-inline drbd_should_do_remote() and drbd_should_send_out_of_sync()
      drbd: Get rid of some first_peer_device() calls
      drbd: Move enum write_ordering_e to drbd.h
      drbd: drbd_adm_attach(): Add missing drbd_resync_after_changed()
      drbd: Fix locking across all resources
      drbd: Backport the "events2" command
      drbd: Backport the "status" command

Lars Ellenberg (22):
      drbd: Fix spurious disk-timeout
      drbd: drop remnants of connector -- we don't use it anymore in drbd 8.4
      drbd: drbdsetup detach of an unresponsive local disk should not block IO "forever"
      drbd: also bump UUIDs if a diskless primary connects
      drbd: add comment why we want to first call local-io-error, then send state
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
      drbd: don't block forever in disconnect during resync if fencing=r-a-stonith
      drbd: fix "endless" transfer log walk in protocol A
      drbd: separate out __al_write_transaction helper function
      drbd: avoid potential deadlock during handshake
      drbd: fix error path during resize

Markus Elfring (1):
      drbd: Deletion of an unnecessary check before the function call "lc_destroy"

Oleg Drokin (1):
      drbd: fix memory leak in drbd_adm_resize

Philipp Reisner (5):
      drbd: Remove pointless check
      drbd: Replace 0 with the more meaningful GFP_NOWAIT
      drbd: Rename asender to ack_receiver
      drbd: Create a dedicated workqueue for sending acks on the control connection
      drbd: make suspend_io() / resume_io() must be thread and recursion safe

Roland Kammerer (2):
      lru_cache: Converted lc_seq_printf_status to return void
      MAINTAINERS: Updated information for DRBD DRIVER

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

