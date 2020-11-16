Return-Path: <BATV+29a21e8ca386e11a5a78+6294+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 86C554207E9
	for <drbd-dev@lists.linbit.com>; Mon, 16 Nov 2020 17:31:43 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 16 Nov 2020 15:57:29 +0100
Message-Id: <20201116145809.410558-39-hch@lst.de>
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
	xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Subject: [Drbd-dev] [PATCH 38/78] block: rework requesting modules for
	unclaimed devices
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

Instead of reusing the ranges in bdev_map, add a new helper that is
called if no ranges was found.  This is a first step to unpeel and
eventually remove the complex ranges structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/genhd.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 2a20372756625e..8391e7d83a6920 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1028,6 +1028,13 @@ static ssize_t disk_badblocks_store(struct device *dev,
 	return badblocks_store(disk->bb, page, len, 0);
 }
 
+static void request_gendisk_module(dev_t devt)
+{
+	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
+		/* Make old-style 2.4 aliases work */
+		request_module("block-major-%d", MAJOR(devt));
+}
+
 static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
 {
 	struct kobject *kobj;
@@ -1052,6 +1059,14 @@ static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
 		probe = p->probe;
 		best = p->range - 1;
 		*partno = dev - p->dev;
+
+		if (!probe) {
+			mutex_unlock(&bdev_map_lock);
+			module_put(owner);
+			request_gendisk_module(dev);
+			goto retry;
+		}
+
 		if (p->lock && p->lock(dev, data) < 0) {
 			module_put(owner);
 			continue;
@@ -1290,15 +1305,6 @@ static const struct seq_operations partitions_op = {
 };
 #endif
 
-
-static struct kobject *base_probe(dev_t devt, int *partno, void *data)
-{
-	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
-		/* Make old-style 2.4 aliases work */
-		request_module("block-major-%d", MAJOR(devt));
-	return NULL;
-}
-
 static void bdev_map_init(void)
 {
 	struct bdev_map *base;
@@ -1310,7 +1316,6 @@ static void bdev_map_init(void)
 
 	base->dev = 1;
 	base->range = ~0 ;
-	base->probe = base_probe;
 	for (i = 0; i < 255; i++)
 		bdev_map[i] = base;
 }
-- 
2.29.2

