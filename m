Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 84E141013804
	for <drbd-dev@lists.linbit.com>; Tue,  2 Oct 2012 15:02:25 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 02 Oct 2012 15:02:24 +0200
Message-ID: <8391701.3EY4hQfmFv@fat-tyre>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [GIT PULL] drbd-8.3 updates
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Jens,

Please consider to pull these changes for the 3.7 merge window.

Best,
 Phil

The following changes since commit a0d271cbfed1dd50278c6b06bead3d00ba0a88f9:

  Linux 3.6 (2012-09-30 16:47:46 -0700)

are available in the git repository at:

  git://git.drbd.org/linux-drbd.git for-jens

for you to fetch changes up to a783d564a1badbb87b3f96aa8df581ed4167a9c9:

  drbd: log request sector offset and size for IO errors (2012-10-02 14:52:24 +0200)

----------------------------------------------------------------
Lars Ellenberg (9):
      drbd: introduce stop-sector to online verify
      drbd: change error cleanup goto for failed kobject_init_and_add
      drbd: panic on delayed completion of aborted requests
      drbd: fix potential deadlock during bitmap (re-)allocation
      drbd: a few more GFP_KERNEL -> GFP_NOIO
      drbd: wait for meta data IO completion even with failed disk, unless force-detached
      drbd: prepare for more than 32 bit flags
      drbd: always write bitmap on detach
      drbd: log request sector offset and size for IO errors

Philipp Reisner (6):
      drbd: Add a drbd directory to sysfs
      drbd: expose the data generation identifiers via sysfs
      drbd: Protect accesses to the uuid set with a spinlock
      drbd: Fix a potential issue with the DISCARD_CONCURRENT flag
      drbd: Avoid NetworkFailure state during disconnect
      drbd: Remove dead code

 drivers/block/drbd/Makefile        |    1 +
 drivers/block/drbd/drbd_actlog.c   |   19 ++--
 drivers/block/drbd/drbd_bitmap.c   |   24 ++---
 drivers/block/drbd/drbd_int.h      |  112 +++++++++++++++++------
 drivers/block/drbd/drbd_main.c     |  175 ++++++++++++++++++++++++------------
 drivers/block/drbd/drbd_nl.c       |  109 +++++++++++++---------
 drivers/block/drbd/drbd_proc.c     |   14 ++-
 drivers/block/drbd/drbd_receiver.c |  147 ++++++++++++++++--------------
 drivers/block/drbd/drbd_req.c      |   43 ++++++---
 drivers/block/drbd/drbd_sysfs.c    |   86 ++++++++++++++++++
 drivers/block/drbd/drbd_worker.c   |   87 ++++++++++++++----
 include/linux/drbd.h               |    4 +-
 include/linux/drbd_nl.h            |    1 +
 13 files changed, 571 insertions(+), 251 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_sysfs.c

