Return-Path: <BATV+335b74d913dda7e264a9+6766+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DBCC742178F
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2022 12:32:34 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  3 Mar 2022 14:32:19 +0300
Message-Id: <20220303113223.326220-2-hch@lst.de>
In-Reply-To: <20220303113223.326220-1-hch@lst.de>
References: <20220303113223.326220-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
	drbd-dev@lists.linbit.com, Philipp Reisner <philipp.reisner@linbit.com>,
	Kees Cook <keescook@chromium.org>
Subject: [Drbd-dev] [PATCH 1/5] block: stop using bdevname in
	bdev_write_inode
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

Use the %pg format specifier to save on stack consuption and code size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index a3632317c8aae..b4389f10ee7de 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -54,12 +54,10 @@ static void bdev_write_inode(struct block_device *bdev)
 	while (inode->i_state & I_DIRTY) {
 		spin_unlock(&inode->i_lock);
 		ret = write_inode_now(inode, true);
-		if (ret) {
-			char name[BDEVNAME_SIZE];
+		if (ret)
 			pr_warn_ratelimited("VFS: Dirty inode writeback failed "
-					    "for block device %s (err=%d).\n",
-					    bdevname(bdev, name), ret);
-		}
+					    "for block device %pg (err=%d).\n",
+					    bdev, ret);
 		spin_lock(&inode->i_lock);
 	}
 	spin_unlock(&inode->i_lock);
-- 
2.30.2

