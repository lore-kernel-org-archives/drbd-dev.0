Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C31F51055F53
	for <drbd-dev@lists.linbit.com>; Mon, 29 Oct 2012 15:48:30 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 29 Oct 2012 15:48:29 +0100
Message-ID: <3728568.yDZLErye6B@fat-tyre>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [GIT PULL] 4 fixes for drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Jens,

please consider to pull these fixes in. It is based on your
for-3.7/drivers branch.

Best regards,
 Phil


The following changes since commit 34a73dd594699dc3834167297a74c43948bb6e41:

  Revert "memstick: add support for legacy memorysticks" (2012-10-10 16:13:26 
-0600)

are available in the git repository at:

  git://git.drbd.org/linux-drbd.git for-jens

for you to fetch changes up to 731d4596a6f3ba41418a0b11018c453456c51d92:

  drbd: check return of kmalloc in receive_uuids (2012-10-29 13:18:13 +0100)

----------------------------------------------------------------
Jing Wang (1):
      drbd: check return of kmalloc in receive_uuids

Lars Ellenberg (2):
      drbd: fix regression: potential NULL pointer dereference
      drbd: don't try to clear bits once the disk has failed

Philipp Reisner (1):
      drbd: Broadcast sync progress no more often than once per second

 drivers/block/drbd/drbd_actlog.c   |   19 +++++++++++++------
 drivers/block/drbd/drbd_int.h      |    6 ++++++
 drivers/block/drbd/drbd_main.c     |    8 ++++++--
 drivers/block/drbd/drbd_nl.c       |    5 +++++
 drivers/block/drbd/drbd_receiver.c |    4 ++++
 drivers/block/drbd/drbd_worker.c   |    4 ++++
 6 files changed, 38 insertions(+), 8 deletions(-)

