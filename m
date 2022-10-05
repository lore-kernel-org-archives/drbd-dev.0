Return-Path: <chaitanyak@nvidia.com>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F00D84201A5
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:15:21 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:09 -0700
Message-ID: <20221005050027.39591-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: axboe@kernel.dk, vincent.fu@samsung.com, ming.lei@redhat.com,
	kch@nvidia.com, vigneshr@ti.com, richard@nod.at,
	damien.lemoal@opensource.wdc.com, philipp.reisner@linbit.com,
	efremov@linux.com, josef@toxicpanda.com, mcgrof@kernel.org,
	haris.iqbal@ionos.com, hare@suse.de, miquel.raynal@bootlin.com,
	shinichiro.kawasaki@wdc.com, lars.ellenberg@linbit.com,
	johannes.thumshirn@wdc.com, jinpu.wang@ionos.com,
	tim@cyberelk.net, bvanassche@acm.org
Subject: [Drbd-dev] [RFC PATCH 00/18] block: add and use init disk helper
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

Hi,

Add and use the helper to initialize the common fields of struct gendisk
such as major, first_minor, minors, disk_name, private_data, and ops.
This initialization is spread all over the block drivers. This avoids
code repetation of inialization code of gendisk in current block drivers
and any future ones.

-ck

Chaitanya Kulkarni (18):
  block: add and use init disk helper
  nfblock: use init disk helper
  amiflop: use init disk helper
  brd: use init disk helper
  drbd: use init disk helper
  floppy: use init disk helper
  loop: use init disk helper
  n64cart: use init disk helper
  nbd: use init disk helper
  pcd: use init disk helper
  pd: use init disk helper
  pf: use init disk helper
  pktcdvd: use init disk helper
  rnbd-clt: use init disk helper
  swim: use init disk helper
  swim3: use init disk helper
  z2ram: use init disk helper
  ubi: use init disk helper

 arch/m68k/emu/nfblock.c        |  8 ++------
 block/genhd.c                  | 13 +++++++++++++
 drivers/block/amiflop.c        |  8 ++------
 drivers/block/ataflop.c        |  8 ++------
 drivers/block/brd.c            |  9 ++-------
 drivers/block/drbd/drbd_main.c |  6 +-----
 drivers/block/floppy.c         |  8 ++------
 drivers/block/loop.c           |  7 ++-----
 drivers/block/n64cart.c        |  4 +---
 drivers/block/nbd.c            |  7 ++-----
 drivers/block/null_blk/main.c  | 12 ++++--------
 drivers/block/paride/pcd.c     |  5 +----
 drivers/block/paride/pd.c      |  8 ++------
 drivers/block/paride/pf.c      |  6 +-----
 drivers/block/pktcdvd.c        |  6 +-----
 drivers/block/rnbd/rnbd-clt.c  |  9 +++------
 drivers/block/swim.c           |  7 ++-----
 drivers/block/swim3.c          |  8 ++------
 drivers/block/z2ram.c          |  5 +----
 drivers/mtd/ubi/block.c        |  6 +-----
 include/linux/blkdev.h         |  5 +++++
 21 files changed, 52 insertions(+), 103 deletions(-)

-- 
2.29.0

