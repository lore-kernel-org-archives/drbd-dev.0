Return-Path: <BATV+0324f78733eae8ed4bec+6220+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E6C6F4250FE
	for <drbd-dev@lists.linbit.com>; Thu,  3 Sep 2020 08:02:04 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  3 Sep 2020 07:41:04 +0200
Message-Id: <20200903054104.228829-10-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 9/9] vsprintf: use bd_partno in bdev_name
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

No need to go through the hd_struct to find the partition number.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/vsprintf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index afb9521ddf9197..14c9a6af1b239a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -940,13 +940,13 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
 
 	hd = bdev->bd_disk;
 	buf = string(buf, end, hd->disk_name, spec);
-	if (bdev->bd_part->partno) {
+	if (bdev->bd_partno) {
 		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1])) {
 			if (buf < end)
 				*buf = 'p';
 			buf++;
 		}
-		buf = number(buf, end, bdev->bd_part->partno, spec);
+		buf = number(buf, end, bdev->bd_partno, spec);
 	}
 	return buf;
 }
-- 
2.28.0

