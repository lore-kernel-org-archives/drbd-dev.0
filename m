Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 748901057FFE
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:29:26 +0200 (CEST)
Received: by mail-wm0-f53.google.com with SMTP id z132so4671214wmg.1
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:29:26 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:22:57 +0200
Message-Id: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/17] DRBD updates
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

Please consider these patches for your for-4.14 branch.

The first and third patch help with request merging on DRBD's secondary side.
That can improves performance for some workloads.

The other patches are fixes and random mentenance.


Baoyou Xie (1):
  drbd: mark symbols static where possible

Geliang Tang (1):
  drbd: Use setup_timer() instead of init_timer() to simplify the code.

Greg Kroah-Hartman (1):
  drbd: rename "usermode_helper" to "drbd_usermode_helper"

Lars Ellenberg (9):
  drbd: introduce drbd_recv_header_maybe_unplug
  drbd: change list_for_each_safe to while(list_first_entry_or_null)
  drbd: add explicit plugging when submitting batches
  drbd: Send P_NEG_ACK upon write error in protocol != C
  drbd: new disk-option disable-write-same
  drbd: fix potential get_ldev/put_ldev refcount imbalance during attach
  drbd: fix rmmod cleanup, remove _all_ debugfs entries
  drbd: fix potential deadlock when trying to detach during handshake
  drbd: fix race between handshake and admin disconnect/down

Markus Elfring (1):
  drbd: A single dot should be put into a sequence.

Philipp Reisner (1):
  drbd: Fix resource role for newly created resources in events2

Roland Kammerer (3):
  drbd: move global variables to drbd namespace and make some static
  drbd: abort drbd_start_resync if there is no connection
  drbd: switch from kmalloc() to kmalloc_array()

 drivers/block/drbd/drbd_int.h      |  27 +++++-----
 drivers/block/drbd/drbd_main.c     | 106 +++++++++++++++++++++----------------
 drivers/block/drbd/drbd_nl.c       |  60 +++++++++------------
 drivers/block/drbd/drbd_proc.c     |  10 ++--
 drivers/block/drbd/drbd_receiver.c |  56 +++++++++++++++++---
 drivers/block/drbd/drbd_req.c      |  80 ++++++++++++++++++++++++++--
 drivers/block/drbd/drbd_req.h      |   6 +++
 drivers/block/drbd/drbd_state.c    |  48 ++++++++++++++++-
 drivers/block/drbd/drbd_state.h    |   8 +++
 drivers/block/drbd/drbd_worker.c   |  46 ++++++++++++----
 include/linux/drbd.h               |   2 +-
 include/linux/drbd_genl.h          |   3 +-
 include/linux/drbd_limits.h        |   8 ++-
 13 files changed, 333 insertions(+), 127 deletions(-)

-- 
2.7.4

