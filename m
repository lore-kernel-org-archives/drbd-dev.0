Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 25CD11011C0C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 1FAB51B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:14 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZZfgKALNA0qs for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:14 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 026E51B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:14 +0200 (CEST)
Resent-Message-ID: <20120810203313.GE31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EF99B100542F
	for <drbd-dev@lists.linbit.com>; Tue,  7 Aug 2012 00:09:07 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so2275323pbb.27
	for <drbd-dev@lists.linbit.com>; Mon, 06 Aug 2012 15:09:05 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com
Date: Mon,  6 Aug 2012 15:08:29 -0700
Message-Id: <1344290921-25154-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, neilb@suse.de, Kent Overstreet <koverstreet@google.com>,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v5 00/12] Block cleanups
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Various cleanups for the generic block layer - the patches should be pretty
self explanatory.

CHANGES SINCE LAST VERSION:

Review feedback - should all be noted in the patch descriptions. Fixed
retarded rebase conflicts. Added some acked-bys.

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
 drivers/block/pktcdvd.c             |   73 +++-------
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
 fs/bio.c                            |  259 +++++++++++++++++++++++------------
 fs/exofs/ore.c                      |    5 +-
 include/linux/bio.h                 |   37 ++---
 include/linux/blk_types.h           |   12 ++-
 20 files changed, 256 insertions(+), 401 deletions(-)

-- 
1.7.7.3

