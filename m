Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B341A100542E
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id A963F1B4262
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:32 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gFWcXpMtUkbc for <drbd-dev@lists.linbit.com>;
	Thu, 24 May 2012 18:15:32 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 8DBB91B40FA
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:32 +0200 (CEST)
Resent-Message-ID: <20120524161532.GP5734@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id ACDE4106DCE1
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 02:11:17 +0200 (CEST)
Received: by mail-pb0-f54.google.com with SMTP id ro2so13655294pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2012 17:11:17 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	dm-devel@redhat.com, linux-fsdevel@vger.kernel.org
Date: Wed, 23 May 2012 17:02:37 -0700
Message-Id: <1337817771-25038-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com, tj@kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 00/14] Block cleanups (for bcache)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is version 2 of this patch series - nothing major, documented a few things
and incorporated various review feedback. Please let me know if there's
anything I missed.

Couple related things in this patch series. This is mostly stuff I did for
bcache, polished/expanded up a bit:

 * Bio pool freeing. This moves freeing of bios allocated from bio pools into
   generic code.

 * Kill bi_destructor. That was Tejun's idea, but it turned out to be easier
   than I expected.

 * Improved bio splitting. This was originally part of bcache, but I pulled it
   out and replaced the existing bio splitting code with it.

 * Closures - this is from bcache. I didn't really need to use it for the next
   patch, but IMO it makes the code a bit more elegant.

 * Make generic_make_request() handle arbitrary size bios. I think this is
   going to enable a lot of cleanups in the future.

   The idea here isn't for generic_make_request() to be doing the splitting in
   practice long term, it's more just an intermediate stage. If this goes in, I
   think a lot of driver code - certainly a lot of virtual block drivers -
   could easily be made to handle arbitrary sized bios, and splitting will only
   happen when a bio is being redirected to two different devices or something
   like that. But this should enable a lot of cleanups without having to change
   every block driver first.

Kent Overstreet (14):
  block: Generalized bio pool freeing
  dm: kill dm_rq_bio_destructor
  block: Add bio_clone_bioset()
  block: Add bio_clone_kmalloc()
  block: Only clone bio vecs that are in use
  block: Add bio_reset()
  pktcdvd: Switch to bio_kmalloc()
  block: Kill bi_destructor
  block: Add an explicit bio flag for bios that own their bvec
  block: Rename bio_split() -> bio_pair_split()
  block: Rework bio splitting
  Closures
  Make generic_make_request handle arbitrarily large bios
  Gut bio_add_page()

 Documentation/block/biodoc.txt      |    5 -
 block/blk-core.c                    |  126 ++++++-
 drivers/block/drbd/drbd_req.c       |   18 +-
 drivers/block/osdblk.c              |    3 +-
 drivers/block/pktcdvd.c             |  121 +++----
 drivers/block/rbd.c                 |   12 +-
 drivers/md/dm-crypt.c               |    9 -
 drivers/md/dm-io.c                  |   11 -
 drivers/md/dm.c                     |   58 +---
 drivers/md/linear.c                 |    6 +-
 drivers/md/md.c                     |   44 +--
 drivers/md/raid0.c                  |    8 +-
 drivers/md/raid10.c                 |   23 +-
 drivers/target/target_core_iblock.c |    9 -
 fs/bio-integrity.c                  |   44 ---
 fs/bio.c                            |  417 ++++++++++++------------
 fs/exofs/ore.c                      |    5 +-
 include/linux/bio.h                 |   42 +--
 include/linux/blk_types.h           |    9 +-
 include/linux/blkdev.h              |    3 +
 include/linux/closure.h             |  614 +++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug                   |    8 +
 lib/Makefile                        |    2 +-
 lib/closure.c                       |  363 +++++++++++++++++++++
 24 files changed, 1433 insertions(+), 527 deletions(-)
 create mode 100644 include/linux/closure.h
 create mode 100644 lib/closure.c

-- 
1.7.9.3.327.g2980b

