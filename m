Return-Path: <agruenba@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 783541627A1
	for <drbd-dev@lists.linbit.com>; Wed,  4 Mar 2026 20:10:43 +0100 (CET)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/4] simple bio cleanups
Date: Wed,  4 Mar 2026 20:04:05 +0100
Message-ID: <20260304190424.291743-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
Cc: dm-devel@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	drbd-dev@lists.linbit.com
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

Jens,

here are some simple bio related cleanups.  Any thoughts?  Can those go
in via your tree?

Thanks,
Andreas

Andreas Gruenbacher (4):
  block: consecutive blk_status_t error codes
  block: get rid of blk_status_to_{errno,str} inconsistency
  bio: rename bio_chain arguments
  bio: use bio_io_error more often

 block/bio.c                   | 22 +++++++++++-----------
 block/blk-core.c              |  5 +----
 block/fops.c                  |  3 +--
 drivers/block/drbd/drbd_int.h |  3 +--
 drivers/md/bcache/bcache.h    |  3 +--
 drivers/md/bcache/request.c   |  6 ++----
 drivers/md/dm-mpath.c         |  3 +--
 drivers/md/dm-writecache.c    |  3 +--
 fs/f2fs/segment.c             |  3 +--
 include/linux/blk_types.h     |  2 +-
 10 files changed, 21 insertions(+), 32 deletions(-)

-- 
2.52.0

