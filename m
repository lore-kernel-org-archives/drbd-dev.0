Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:01 +0200
Message-Id: <1314284934-17999-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 005/118] drbd: Endianness convert the constants
	instead of the variables
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Converting the constants happens at compile time.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c |    2 +-
 drivers/block/drbd/drbd_main.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index cf0e63d..0eb17d3 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -407,7 +407,7 @@ static int drbd_al_read_tr(struct drbd_conf *mdev,
 	if (!drbd_md_sync_page_io(mdev, bdev, sector, READ))
 		return -1;
 
-	rv = (be32_to_cpu(b->magic) == DRBD_MAGIC);
+	rv = (b->magic == cpu_to_be32(DRBD_MAGIC));
 
 	for (i = 0; i < AL_EXTENTS_PT + 1; i++)
 		xor_sum ^= be32_to_cpu(b->updates[i].extent);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 2cd132a..f65b8c5 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3729,7 +3729,7 @@ int drbd_md_read(struct drbd_conf *mdev, struct drbd_backing_dev *bdev)
 		goto err;
 	}
 
-	if (be32_to_cpu(buffer->magic) != DRBD_MD_MAGIC) {
+	if (buffer->magic != cpu_to_be32(DRBD_MD_MAGIC)) {
 		dev_err(DEV, "Error while reading metadata, magic not found.\n");
 		rv = ERR_MD_INVALID;
 		goto err;
-- 
1.7.4.1

