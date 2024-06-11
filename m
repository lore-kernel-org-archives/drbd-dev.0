Return-Path: <BATV+2fedbe304aabaf399917+7597+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2A75A4205D7
	for <drbd-dev@lists.linbit.com>; Tue, 11 Jun 2024 08:23:39 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/26] block: freeze the queue in queue_attr_store
Date: Tue, 11 Jun 2024 07:19:11 +0200
Message-ID: <20240611051929.513387-12-hch@lst.de>
In-Reply-To: <20240611051929.513387-1-hch@lst.de>
References: <20240611051929.513387-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: nvdimm@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, linux-mtd@lists.infradead.org,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yu Kuai <yukuai3@huawei.com>, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, Mike Snitzer <snitzer@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-mmc@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	virtualization@lists.linux.dev, Lars Ellenberg <lars.ellenberg@linbit.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
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

queue_attr_store updates attributes used to control generating I/O, and
can cause malformed bios if changed with I/O in flight.  Freeze the queue
in common code instead of adding it to almost every attribute.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c    | 5 +++--
 block/blk-sysfs.c | 9 ++-------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0d4cd39c3d25da..58b0d6c7cc34d6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4631,13 +4631,15 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	int ret;
 	unsigned long i;
 
+	if (WARN_ON_ONCE(!q->mq_freeze_depth))
+		return -EINVAL;
+
 	if (!set)
 		return -EINVAL;
 
 	if (q->nr_requests == nr)
 		return 0;
 
-	blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	ret = 0;
@@ -4671,7 +4673,6 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	}
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
 
 	return ret;
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f0f9314ab65c61..5c787965b7d09e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -189,12 +189,9 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
 	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
 		return -EINVAL;
 
-	blk_mq_freeze_queue(q);
 	lim = queue_limits_start_update(q);
 	lim.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
 	err = queue_limits_commit_update(q, &lim);
-	blk_mq_unfreeze_queue(q);
-
 	if (err)
 		return err;
 	return ret;
@@ -241,11 +238,9 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 	if (ret < 0)
 		return ret;
 
-	blk_mq_freeze_queue(q);
 	lim = queue_limits_start_update(q);
 	lim.max_user_sectors = max_sectors_kb << 1;
 	err = queue_limits_commit_update(q, &lim);
-	blk_mq_unfreeze_queue(q);
 	if (err)
 		return err;
 	return ret;
@@ -585,13 +580,11 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 	 * ends up either enabling or disabling wbt completely. We can't
 	 * have IO inflight if that happens.
 	 */
-	blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	wbt_set_min_lat(q, val);
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
 
 	return count;
 }
@@ -722,9 +715,11 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (!entry->store)
 		return -EIO;
 
+	blk_mq_freeze_queue(q);
 	mutex_lock(&q->sysfs_lock);
 	res = entry->store(q, page, length);
 	mutex_unlock(&q->sysfs_lock);
+	blk_mq_unfreeze_queue(q);
 	return res;
 }
 
-- 
2.43.0

