Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4305910003DE
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jun 2012 18:22:04 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 12 Jun 2012 18:22:03 +0000
Message-ID: <1788738.mNsnrf6o6T@fat-tyre>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [GIT PULL] drbd fixes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Jens,

In the last 4 weeks three bugs were reported and fixed. Please consider
to pass these 3 commits on to Linus.

The following changes since commit 4fd1ffaa122cf66bfb710ced43679413df4f3605:

  Merge branch 'for-jens' of git://git.drbd.org/linux-drbd into for-3.5/drivers (2012-05-18 16:20:06 +0200)

are available in the git repository at:


  git://git.drbd.org/linux-drbd.git for-jens

for you to fetch changes up to 0d5934e3c258fc5decc4103600c597086fd95a52:

  drbd: fix null pointer dereference with on-congestion policy when diskless (2012-06-12 14:35:19 +0200)

----------------------------------------------------------------
Lars Ellenberg (3):
      drbd: fix access of unallocated pages and kernel panic
      drbd: fix list corruption by failing but already aborted reads
      drbd: fix null pointer dereference with on-congestion policy when diskless

 drivers/block/drbd/drbd_bitmap.c |   11 +++++--
 drivers/block/drbd/drbd_req.c    |   66 ++++++++++++++++++++++++--------------
2 files changed, 51 insertions(+), 26 deletions(-)

Best,
 Philipp
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.

