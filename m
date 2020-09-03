Return-Path: <BATV+0324f78733eae8ed4bec+6220+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2A9CB425102
	for <drbd-dev@lists.linbit.com>; Thu,  3 Sep 2020 08:02:10 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  3 Sep 2020 07:40:58 +0200
Message-Id: <20200903054104.228829-4-hch@lst.de>
In-Reply-To: <20200903054104.228829-1-hch@lst.de>
References: <20200903054104.228829-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/9] md: compare bd_disk instead of bd_contains
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

To check for partitions of the same disk bd_contains works as well, but
bd_disk is way more obvious.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9562ef598ae1f4..3f33562d10d6f5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2322,8 +2322,7 @@ static int match_mddev_units(struct mddev *mddev1, struct mddev *mddev2)
 			    test_bit(Journal, &rdev2->flags) ||
 			    rdev2->raid_disk == -1)
 				continue;
-			if (rdev->bdev->bd_contains ==
-			    rdev2->bdev->bd_contains) {
+			if (rdev->bdev->bd_disk == rdev2->bdev->bd_disk) {
 				rcu_read_unlock();
 				return 1;
 			}
@@ -5944,8 +5943,8 @@ int md_run(struct mddev *mddev)
 		rdev_for_each(rdev, mddev)
 			rdev_for_each(rdev2, mddev) {
 				if (rdev < rdev2 &&
-				    rdev->bdev->bd_contains ==
-				    rdev2->bdev->bd_contains) {
+				    rdev->bdev->bd_disk ==
+				    rdev2->bdev->bd_disk) {
 					pr_warn("%s: WARNING: %s appears to be on the same physical disk as %s.\n",
 						mdname(mddev),
 						bdevname(rdev->bdev,b),
-- 
2.28.0

