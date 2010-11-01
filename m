Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0765410595B2
	for <drbd-dev@lists.linbit.com>; Tue,  2 Nov 2010 11:38:34 +0100 (CET)
Resent-Message-ID: <20101102103834.GE4340@barkeeper1-xen.linbit>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DC2A110593B6
	for <drbd-dev@lists.linbit.com>; Mon,  1 Nov 2010 17:16:25 +0100 (CET)
From: Tejun Heo <tj@kernel.org>
To: axboe@kernel.dk, hch@infradead.org, linux-kernel@vger.kernel.org,
	petero2@telia.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
	jack@suse.cz, akpm@linux-foundation.org, adilger.kernel@dilger.ca,
	tytso@mit.edu, mfasheh@suse.com, joel.becker@oracle.com,
	aelder@sgi.com, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
	neilb@suse.de, leochen@broadcom.com, sbranden@broadcom.com,
	chris.mason@oracle.com, swhiteho@redhat.com, shaggy@linux.vnet.ibm.com,
	joern@logfs.org, konishi.ryusuke@lab.ntt.co.jp,
	reiserfs-devel@vger.kernel.org, viro@zeniv.linux.org.uk
Date: Mon,  1 Nov 2010 17:15:26 +0100
Message-Id: <1288628129-12811-3-git-send-email-tj@kernel.org>
In-Reply-To: <1288628129-12811-1-git-send-email-tj@kernel.org>
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Subject: [Drbd-dev] [PATCH 2/5] btrfs: close_bdev_exclusive() should use the
	same @flags as the matching open_bdev_exclusive()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

In the failure path of __btrfs_open_devices(), close_bdev_exclusive()
is called with @flags which doesn't match the one used during
open_bdev_exclusive().  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Chris Mason <chris.mason@oracle.com>
---
 fs/btrfs/volumes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cc04dc1..d395962 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -638,7 +638,7 @@ static int __btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 error_brelse:
 		brelse(bh);
 error_close:
-		close_bdev_exclusive(bdev, FMODE_READ);
+		close_bdev_exclusive(bdev, flags);
 error:
 		continue;
 	}
-- 
1.7.1

