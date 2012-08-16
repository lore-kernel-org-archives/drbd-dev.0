Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 214B81017A2C
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 17:28:27 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 16 Aug 2012 17:28:26 +0200
Message-ID: <4092615.Zqxn9JocAf@fat-tyre>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] drbd fixes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Jens,

Please consider to pull these 3 fixes in for 3.6.

Best,
 Phil

The following changes since commit a73ff3231df59a4b92ccd0dd4e73897c5822489b:

  drbd: announce FLUSH/FUA capability to upper layers (2012-07-24 15:14:28 +0200)

are available in the git repository at:

  git://git.drbd.org/linux-drbd.git for-jens

for you to fetch changes up to d1aa4d04da8de5c89d73859e077d89c4c71d8ed1:

  drbd: Write all pages of the bitmap after an online resize (2012-08-16 17:17:35 +0200)

----------------------------------------------------------------
Lars Ellenberg (1):
      drbd: fix drbd wire compatibility for empty flushes

Philipp Reisner (2):
      drbd: Finish requests that completed while IO was frozen
      drbd: Write all pages of the bitmap after an online resize

 drivers/block/drbd/drbd_bitmap.c |   15 ++++++++++++++-
 drivers/block/drbd/drbd_int.h    |    1 +
 drivers/block/drbd/drbd_main.c   |   28 ++++++++++++----------------
 drivers/block/drbd/drbd_nl.c     |    4 ++--
 drivers/block/drbd/drbd_req.c    |   36 ++++++++++++++++++++++++++++++++----
 5 files changed, 61 insertions(+), 23 deletions(-)

