Return-Path: <tom.leiming@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8E9691056469
	for <drbd-dev@lists.linbit.com>; Fri, 11 Nov 2016 13:06:14 +0100 (CET)
Received: by mail-pf0-f196.google.com with SMTP id n85so2395019pfi.3
	for <drbd-dev@lists.linbit.com>; Fri, 11 Nov 2016 04:06:14 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Fri, 11 Nov 2016 20:05:28 +0800
Message-Id: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
Cc: Mike Snitzer <snitzer@redhat.com>, Ming Lei <tom.leiming@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"open list:NVM EXPRESS TARGET DRIVER" <linux-nvme@lists.infradead.org>,
	Keith Busch <keith.busch@intel.com>,
	"open list:DEVICE-MAPPER  LVM" <dm-devel@redhat.com>,
	"open list:TARGET SUBSYSTEM" <target-devel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>,
	Hannes Reinecke <hare@suse.com>,
	"open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Mike Christie <mchristi@redhat.com>,
	Guoqing Jiang <gqjiang@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>, Coly Li <colyli@suse.de>,
	"open list:SOFTWARE RAID Multiple Disks SUPPORT"
	<linux-raid@vger.kernel.org>,
	"open list:BCACHE BLOCK LAYER CACHE" <linux-bcache@vger.kernel.org>,
	linux-block@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"open list:LogFS" <logfs@logfs.org>,
	Zheng Liu <wenqing.lz@taobao.com>, linux-fsdevel@vger.kernel.org,
	Eric Wheeler <git@linux.ewheeler.net>
Subject: [Drbd-dev] [PATCH 00/12] block: cleanup direct access to bvec table
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

This patchset cleans up direct access to bvec table.

The 1st patch passes bvec table to bio_init(), so that
direct access to bvec table in bio initialization is avoided.

For other patches, most of them uses bio_add_page()
to replace hardcode style of adding page to bvec,
and others avoids to access bio->bi_vcnt.

The most special one is to use bvec iterator helpers
to implement .get_page/.next_page for dm-io.c

One big motivation is to prepare for supporting multipage
bvec, but this patchset is one good cleanup too even not
for that purpose.

Thanks,
Ming

Ming Lei (12):
  block: bio: pass bvec table to bio_init()
  block: drbd: remove impossible failure handling
  block: floppy: use bio_add_page()
  target: avoid to access .bi_vcnt directly
  bcache: debug: avoid to access .bi_io_vec directly
  dm: crypt: use bio_add_page()
  dm: use bvec iterator helpers to implement .get_page and .next_page
  dm: dm.c: replace 'bio->bi_vcnt == 1' with !bio_multiple_segments
  fs: logfs: convert to bio_add_page() in sync_request()
  fs: logfs: use bio_add_page() in __bdev_writeseg()
  fs: logfs: use bio_add_page() in do_erase()
  fs: logfs: remove unnecesary check

 block/bio.c                        |   8 ++-
 drivers/block/drbd/drbd_receiver.c |  14 +----
 drivers/block/floppy.c             |  10 ++--
 drivers/md/bcache/debug.c          |  11 ++--
 drivers/md/bcache/io.c             |   4 +-
 drivers/md/bcache/journal.c        |   4 +-
 drivers/md/bcache/movinggc.c       |   6 +--
 drivers/md/bcache/request.c        |   2 +-
 drivers/md/bcache/super.c          |  12 ++---
 drivers/md/bcache/writeback.c      |   5 +-
 drivers/md/dm-bufio.c              |   4 +-
 drivers/md/dm-crypt.c              |   8 +--
 drivers/md/dm-io.c                 |  34 ++++++++----
 drivers/md/dm-rq.c                 |   7 ++-
 drivers/md/dm.c                    |   2 +-
 drivers/md/multipath.c             |   2 +-
 drivers/md/raid5-cache.c           |   2 +-
 drivers/md/raid5.c                 |   9 +---
 drivers/nvme/target/io-cmd.c       |   4 +-
 drivers/target/target_core_pscsi.c |   8 +--
 fs/logfs/dev_bdev.c                | 106 +++++++++++++------------------------
 include/linux/bio.h                |   3 +-
 22 files changed, 107 insertions(+), 158 deletions(-)

-- 
2.7.4

