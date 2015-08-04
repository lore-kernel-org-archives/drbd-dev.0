Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C8D4A100EC11
	for <drbd-dev@lists.linbit.com>; Tue,  4 Aug 2015 14:56:57 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  4 Aug 2015 14:56:24 +0200
Message-Id: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/19] RFC DRBD updates for the 4.3 merge window
	(part II)
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

these patches are intended for the 4.3 merge window.

The first two patches split on of kernel threads (drbd_asender)
into one that mainly receives packets on the control connection,
and a workqueue that only sends packets on the control connection.

All the other patches are self-contained fixes or minor
improvements described in the commit message.

Lars Ellenberg (13):
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

Oleg Drokin (1):
  drbd: fix memory leak in drbd_adm_resize

Philipp Reisner (3):
  drbd: Rename asender to ack_receiver
  drbd: Create a dedicated workqueue for sending acks on the control
    connection
  drbd: make suspend_io() / resume_io() must be thread and recursion
    safe

Roland Kammerer (2):
  lru_cache: Converted lc_seq_printf_status to return void
  MAINTAINERS: Updated information for DRBD DRIVER

 MAINTAINERS                        |  11 +-
 drivers/block/drbd/drbd_actlog.c   | 323 +++++++++++++++++++------------------
 drivers/block/drbd/drbd_bitmap.c   |  22 ++-
 drivers/block/drbd/drbd_debugfs.c  |  10 ++
 drivers/block/drbd/drbd_int.h      |  40 ++---
 drivers/block/drbd/drbd_main.c     |  48 ++----
 drivers/block/drbd/drbd_nl.c       | 285 +++++++++++++++++++++-----------
 drivers/block/drbd/drbd_protocol.h |   2 +-
 drivers/block/drbd/drbd_receiver.c | 212 +++++++++++++-----------
 drivers/block/drbd/drbd_req.c      |   4 +-
 drivers/block/drbd/drbd_state.c    |   2 +-
 drivers/block/drbd/drbd_worker.c   |  10 +-
 include/linux/drbd.h               |   2 +-
 include/linux/lru_cache.h          |   2 +-
 lib/lru_cache.c                    |   4 +-
 15 files changed, 560 insertions(+), 417 deletions(-)

-- 
1.9.1

