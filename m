Return-Path: <BATV+3075c4dbfe213c24d6b2+7491+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A1D4B4205E3
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 12:34:49 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: atomic queue limit updates for stackable devices v2
Date: Mon, 26 Feb 2024 11:29:48 +0100
Message-Id: <20240226103004.281412-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi all,

this series adds new helpers for the atomic queue limit update
functionality and then switches dm and md over to it.  The dm switch is
pretty trivial as it was basically implementing the model by hand
already, md is a bit more work.

I've run the mdadm testsuite, and it has the same (rather large) number
of failures as the baseline.  I've still not managed to get the dm
testuite running unfortunately, but it survives xfstests which exercises
quite a few dm targets and blktests.

nvme-multipath will be handled separately as it is too tightly integrated
with the rest of nvme.

Changes since v1:
 - a few kerneldoc fixes
 - fix a line remove after testing in raid0
 - also add drbd

Diffstat:
 block/blk-settings.c           |   47 ++++++---
 drivers/block/drbd/drbd_main.c |   13 +-
 drivers/block/drbd/drbd_nl.c   |  210 +++++++++++++++++++----------------------
 drivers/md/dm-table.c          |   27 ++---
 drivers/md/md.c                |   37 +++++++
 drivers/md/md.h                |    3 
 drivers/md/raid0.c             |   37 +++----
 drivers/md/raid1.c             |   24 +---
 drivers/md/raid10.c            |   52 ++++------
 drivers/md/raid5.c             |  123 ++++++++++--------------
 include/linux/blkdev.h         |    5 
 11 files changed, 305 insertions(+), 273 deletions(-)
