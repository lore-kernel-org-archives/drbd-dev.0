Return-Path: <BATV+11ac0858211c0bd5236f+6757+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EA8CF4201FE
	for <drbd-dev@lists.linbit.com>; Tue, 22 Feb 2022 16:52:10 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 22 Feb 2022 16:51:46 +0100
Message-Id: <20220222155156.597597-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Chris Zankel <chris@zankel.net>, Justin Sanders <justin@coraid.com>,
	Minchan Kim <minchan@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	linux-xtensa@linux-xtensa.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Denis Efremov <efremov@linux.com>, Coly Li <colyli@suse.de>,
	linux-block@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] remove opencoded kmap of bio_vecs
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

this series replaces various open coded kmaps of bio_vecs with higher
level helpers that use kmap_local_page underneath.

Diffstat:
 arch/xtensa/platforms/iss/simdisk.c |    4 ++--
 drivers/block/aoe/aoecmd.c          |    2 +-
 drivers/block/drbd/drbd_receiver.c  |    4 ++--
 drivers/block/drbd/drbd_worker.c    |    6 +++---
 drivers/block/floppy.c              |    6 ++----
 drivers/block/zram/zram_drv.c       |    9 ++-------
 drivers/md/bcache/request.c         |    4 ++--
 drivers/nvdimm/blk.c                |    7 +++----
 drivers/nvdimm/btt.c                |   10 ++++------
 9 files changed, 21 insertions(+), 31 deletions(-)
