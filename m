Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 33FE51057FB2
	for <drbd-dev@lists.linbit.com>; Thu, 20 Apr 2017 17:20:44 +0200 (CEST)
Received: by mail-wm0-f46.google.com with SMTP id m123so40678045wma.0
	for <drbd-dev@lists.linbit.com>; Thu, 20 Apr 2017 08:20:44 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	p60sm8000240wrc.66.2017.04.20.08.20.43
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Apr 2017 08:20:43 -0700 (PDT)
Resent-Message-ID: <20170420152038.GB10794@soda.linbit>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3162A1057FCC
	for <drbd-dev@lists.linbit.com>; Thu, 20 Apr 2017 07:44:55 +0200 (CEST)
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 20 Apr 2017 15:38:48 +1000
Message-ID: <149266645258.27388.14083229348123176454.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, Kent Overstreet <kent.overstreet@gmail.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>, Roger Pau Monné <roger.pau@citrix.com>, ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/10] block: assorted cleanup for bio splitting
	and cloning.
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

This series contains more work towards getting rid of the bioset work
queues and generally improving the splitting and cloning of bios.

The first three patches are similar to ones that I sent previously.
They have been rebased on the current block for-next tree and improved
a little.  Specifically I no longer change all instances of
bioset_create() to bioset_create_rescued().  Instead I only change
those which cannot easily be shown to not need changing.

The next patch fixes some issues with bounce.c.  Most significantly it
used to be called after blk_queue_split(), but now it is called
before.  This means that it can no longer assume that the
bio has been split if it contained more than BIO_MAX_PAGES.

Most of the rest change a number of bio_clone() calls to
bio_clone_fast() as that is often what is needed.  bio_clone() does
not work with bios larger than BIO_MAX_PAGES, bio_clone_fast() does.

Finally we remove bio_clone() (which is no longer used) and stop
blk_bio_segment_split() from splitting after BIO_MAX_PAGES, as that
is no longer necessary.

---

NeilBrown (11):
      blk: remove bio_set arg from blk_queue_split()
      blk: make the bioset rescue_workqueue optional.
      blk: use non-rescuing bioset for q->bio_split.
      block: Improvements to bounce-buffer handling
      rbd: use bio_clone_fast() instead of bio_clone()
      drbd: use bio_clone_fast() instead of bio_clone()
      pktcdvd: use bio_clone_fast() instead of bio_clone()
      xen-blkfront: remove bio splitting.
      bcache: use kmalloc to allocate bio in bch_data_verify()
      block: remove bio_clone() and all references.
      block: don't check for BIO_MAX_PAGES in blk_bio_segment_split()


 Documentation/block/biodoc.txt |    2 +
 block/bio.c                    |   30 +++++++++++++++++++---
 block/blk-core.c               |    2 +
 block/blk-merge.c              |   31 +++--------------------
 block/blk-mq.c                 |    2 +
 block/bounce.c                 |   27 +++++++++++++++++++-
 drivers/block/drbd/drbd_int.h  |    3 ++
 drivers/block/drbd/drbd_main.c |    9 +++++++
 drivers/block/drbd/drbd_req.c  |    2 +
 drivers/block/drbd/drbd_req.h  |    2 +
 drivers/block/pktcdvd.c        |   14 ++++++++--
 drivers/block/ps3vram.c        |    2 +
 drivers/block/rbd.c            |   16 +++++++++++-
 drivers/block/rsxx/dev.c       |    2 +
 drivers/block/umem.c           |    2 +
 drivers/block/xen-blkfront.c   |   54 ++--------------------------------------
 drivers/block/zram/zram_drv.c  |    2 +
 drivers/lightnvm/rrpc.c        |    2 +
 drivers/md/bcache/debug.c      |    2 +
 drivers/md/bcache/super.c      |    4 +--
 drivers/md/dm-crypt.c          |    2 +
 drivers/md/dm-io.c             |    2 +
 drivers/md/dm.c                |    5 ++--
 drivers/md/md.c                |    4 +--
 drivers/s390/block/dcssblk.c   |    2 +
 drivers/s390/block/xpram.c     |    2 +
 include/linux/bio.h            |    7 +----
 include/linux/blkdev.h         |    3 +-
 28 files changed, 121 insertions(+), 116 deletions(-)

--
Signature

