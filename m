Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EB6CB1005431
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id D60A61B4369
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:33 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zp7uV6vop27V for <drbd-dev@lists.linbit.com>;
	Thu, 26 Jul 2012 11:35:33 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id B26B41B4368
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:33 +0200 (CEST)
Resent-Message-ID: <20120726093533.GK29767@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7435810000EC
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2012 22:11:52 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so146142pbb.27
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2012 13:11:50 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com
Date: Tue, 24 Jul 2012 13:11:17 -0700
Message-Id: <1343160689-12378-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com, tj@kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v4 00/12] Block cleanups
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

CHANGES SINCE LAST VERSION:

Split off the "make generic_make_request() handle arbitrary size bios" - this
patch series now just kills bi_destructor and reworks bio splitting.

Split out the "rework bio splitting" patch based on Boaz's feedback - now I've
got one patch that introduces the new bio_split() and another that rewrites
bio_pair_split(), which makes the patches much more readable.

Going to try and finish off the rest of the patches that get rid of
merge_bvec_fn, but that'll be a separate patch series.

Kent Overstreet (12):
  block: Generalized bio pool freeing
  dm: Use bioset's front_pad for dm_rq_clone_bio_info
  block: Add bio_reset()
  pktcdvd: Switch to bio_kmalloc()
  block: Kill bi_destructor
  block: Add an explicit bio flag for bios that own their bvec
  block: Rename bio_split() -> bio_pair_split()
  block: Introduce new bio_split()
  block: Rework bio_pair_split()
  block: Add bio_clone_kmalloc()
  block: Add bio_clone_bioset()
  block: Only clone bio vecs that are in use

 Documentation/block/biodoc.txt      |    5 -
 block/blk-core.c                    |   10 +-
 drivers/block/drbd/drbd_main.c      |   13 +--
 drivers/block/drbd/drbd_req.c       |   18 +--
 drivers/block/osdblk.c              |    3 +-
 drivers/block/pktcdvd.c             |  121 ++++++-----------
 drivers/block/rbd.c                 |    8 +-
 drivers/md/dm-crypt.c               |    9 --
 drivers/md/dm-io.c                  |   11 --
 drivers/md/dm.c                     |   60 ++-------
 drivers/md/linear.c                 |    6 +-
 drivers/md/md.c                     |   44 +------
 drivers/md/raid0.c                  |    8 +-
 drivers/md/raid10.c                 |   23 +---
 drivers/target/target_core_iblock.c |    9 --
 fs/bio-integrity.c                  |   44 ------
 fs/bio.c                            |  264 ++++++++++++++++++++++++-----------
 fs/exofs/ore.c                      |    5 +-
 include/linux/bio.h                 |   37 ++---
 include/linux/blk_types.h           |    9 +-
 20 files changed, 281 insertions(+), 426 deletions(-)

-- 
1.7.7.3

