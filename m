Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D0A61105643D
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:52:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C24EE3F76EA
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:52:56 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id BxSEKUPFk0en for <drbd-dev@lists.linbit.com>;
	Tue,  5 Apr 2016 14:52:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A33853F76F6
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:52:56 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t5Gz5DiED6kW for <drbd-dev@lists.linbit.com>;
	Tue,  5 Apr 2016 14:52:56 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 6C8663F76EA
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:52:56 +0200 (CEST)
Resent-Message-ID: <20160405125256.GX3078@soda.linbit>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 94DAC105644B
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 13:58:14 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id r187so1166022pfr.2
	for <drbd-dev@lists.linbit.com>; Tue, 05 Apr 2016 04:58:14 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue,  5 Apr 2016 19:56:45 +0800
Message-Id: <1459857443-20611-1-git-send-email-tom.leiming@gmail.com>
Cc: Boaz Harrosh <boaz@plexistor.com>, Jan Kara <jack@suse.cz>,
	Mike Snitzer <snitzer@redhat.com>, NeilBrown <neilb@suse.de>,
	Ming Lei <tom.leiming@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Oleg Drokin <green@linuxhacker.ru>, Keith Busch <keith.busch@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	"open list:DEVICE-MAPPER  LVM" <dm-devel@redhat.com>,
	"open list:TARGET SUBSYSTEM" <target-devel@vger.kernel.org>,
	Miklos Szeredi <mszeredi@suse.cz>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>,
	"open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
	"open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	Minchan Kim <minchan@kernel.org>, Jarod Wilson <jarod@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Ming Lin <ming.l@ssi.samsung.com>, James Simmons <jsimmons@infradead.org>,
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
	"moderated list:STAGING - LUSTRE PARALLEL FILESYSTEM"
	<lustre-devel@lists.lustre.org>, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	"open list:BCACHE BLOCK LAYER CACHE" <linux-bcache@vger.kernel.org>,
	Hannes Reinecke <hare@suse.de>, "John L. Hammond" <john.hammond@intel.com>,
	Omar Sandoval <osandov@osandov.com>,
	"open list:SOFTWARE RAID Multiple Disks SUPPORT"
	<linux-raid@vger.kernel.org>, Andreas Dilger <andreas.dilger@intel.com>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	Jiri Kosina <jkosina@suse.cz>, NeilBrown <neilb@suse.com>,
	"open list:LogFS" <logfs@logfs.org>,
	Mike Rapoport <mike.rapoport@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
	Frank Zago <fzago@cray.com>, Al Viro <viro@zeniv.linux.org.uk>
Subject: [Drbd-dev] [PATCH 00/27] block: cleanup direct access on .bi_vcnt &
	.bi_io_vec
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

Hi Guys,

It is always not a good practice to access bio->bi_vcnt and
bio->bi_io_vec from drivers directly. Also this kind of direct
access will cause trouble when converting to multipage bvecs.

The 1st patch introduces the following 4 bio helpers which can be
used inside drivers for avoiding direct access to .bi_vcnt and .bi_io_vec.

	bio_pages()
	bio_is_full()
	bio_get_base_vec()
	bio_set_vec_table()

Both bio_pages() and bio_is_full() can be easy to convert to
multipage bvecs.

For bio_get_base_vec() and bio_set_vec_table(), they are often used
during initializing a new bio or in case of single bvec bio. With the
two new helpers, it becomes quite easy to audit access to .bi_io_vec
and .bi_vcnt.

Most of the other patches use the 4 helpers to clean up most of direct
access to .bi_vcnt and .bi_io_vec from drivers, except for MD and btrfs,
which two subsystems will be done in the future. 

Also bio_add_page() is used in floppy, dm-crypt and fs/logfs to
avoiding direct access to .bi_vcnt & .bi_io_vec.

Thanks,
Ming

Ming Lei (27):
  block: bio: introduce 4 helpers for cleanup
  block: drbd: use bio_get_base_vec() to retrieve the 1st bvec
  block: drbd: remove impossible failure handling
  block: loop: use bio_get_base_vec() to retrive bvec table
  block: pktcdvd: use bio_get_base_vec() to retrive bvec table
  block: floppy: use bio_set_vec_table()
  block: floppy: use bio_add_page()
  staging: lustre: avoid to use bio->bi_vcnt directly
  target: use bio_is_full()
  bcache: debug: avoid to access .bi_io_vec directly
  bcache: io.c: use bio_set_vec_table
  bcache: journal.c: use bio_set_vec_table()
  bcache: movinggc: use bio_set_vec_table()
  bcache: writeback: use bio_set_vec_table()
  bcache: super: use bio_set_vec_table()
  bcache: super: use bio_get_base_vec
  dm: crypt: use bio_add_page()
  dm: dm-io.c: use bio_get_base_vec()
  dm: dm.c: replace 'bio->bi_vcnt == 1' with !bio_multiple_segments
  dm: dm-bufio.c: use bio_set_vec_table()
  fs: logfs: use bio_set_vec_table()
  fs: logfs: convert to bio_add_page() in sync_request()
  fs: logfs: use bio_add_page() in __bdev_writeseg()
  fs: logfs: use bio_add_page() in do_erase()
  fs: logfs: remove unnecesary check
  kernel/power/swap.c: use bio_get_base_vec()
  mm: page_io.c: use bio_get_base_vec()

 drivers/block/drbd/drbd_bitmap.c            |   4 +-
 drivers/block/drbd/drbd_receiver.c          |  14 +---
 drivers/block/floppy.c                      |   9 +--
 drivers/block/loop.c                        |   5 +-
 drivers/block/pktcdvd.c                     |   3 +-
 drivers/md/bcache/debug.c                   |  11 ++-
 drivers/md/bcache/io.c                      |   3 +-
 drivers/md/bcache/journal.c                 |   3 +-
 drivers/md/bcache/movinggc.c                |   6 +-
 drivers/md/bcache/super.c                   |  28 +++++---
 drivers/md/bcache/writeback.c               |   4 +-
 drivers/md/dm-bufio.c                       |   3 +-
 drivers/md/dm-crypt.c                       |   8 +--
 drivers/md/dm-io.c                          |   7 +-
 drivers/md/dm.c                             |   3 +-
 drivers/staging/lustre/lustre/llite/lloop.c |   9 +--
 drivers/target/target_core_pscsi.c          |   2 +-
 fs/logfs/dev_bdev.c                         | 107 +++++++++++-----------------
 include/linux/bio.h                         |  28 ++++++++
 kernel/power/swap.c                         |  10 ++-
 mm/page_io.c                                |  18 ++++-
 21 files changed, 156 insertions(+), 129 deletions(-)

-- 
1.9.1

