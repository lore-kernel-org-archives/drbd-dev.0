Return-Path: <BATV+3075c4dbfe213c24d6b2+7491+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8076842010D
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 12:26:06 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 04/16] md: add queue limit helpers
Date: Mon, 26 Feb 2024 11:29:52 +0100
Message-Id: <20240226103004.281412-5-hch@lst.de>
In-Reply-To: <20240226103004.281412-1-hch@lst.de>
References: <20240226103004.281412-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, drbd-dev@lists.linbit.com
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

Add a few helpers that wrap the block queue limits API for use in MD.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/md/md.h |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 75266c34b1f99b..23823823f80c6b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5699,6 +5699,43 @@ static const struct kobj_type md_ktype = {
 
 int mdp_major = 0;
 
+/* stack the limit for all rdevs into lim */
+void mddev_stack_rdev_limits(struct mddev *mddev, struct queue_limits *lim)
+{
+	struct md_rdev *rdev;
+
+	rdev_for_each(rdev, mddev) {
+		queue_limits_stack_bdev(lim, rdev->bdev, rdev->data_offset,
+					mddev->gendisk->disk_name);
+	}
+}
+EXPORT_SYMBOL_GPL(mddev_stack_rdev_limits);
+
+/* apply the extra stacking limits from a new rdev into mddev */
+int mddev_stack_new_rdev(struct mddev *mddev, struct md_rdev *rdev)
+{
+	struct queue_limits lim = queue_limits_start_update(mddev->queue);
+
+	queue_limits_stack_bdev(&lim, rdev->bdev, rdev->data_offset,
+				mddev->gendisk->disk_name);
+	return queue_limits_commit_update(mddev->queue, &lim);
+}
+EXPORT_SYMBOL_GPL(mddev_stack_new_rdev);
+
+/* update the optimal I/O size after a reshape */
+void mddev_update_io_opt(struct mddev *mddev, unsigned int nr_stripes)
+{
+	struct queue_limits lim;
+	int ret;
+
+	blk_mq_freeze_queue(mddev->queue);
+	lim = queue_limits_start_update(mddev->queue);
+	lim.io_opt = lim.io_min * nr_stripes;
+	ret = queue_limits_commit_update(mddev->queue, &lim);
+	blk_mq_unfreeze_queue(mddev->queue);
+}
+EXPORT_SYMBOL_GPL(mddev_update_io_opt);
+
 static void mddev_delayed_delete(struct work_struct *ws)
 {
 	struct mddev *mddev = container_of(ws, struct mddev, del_work);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 8d881cc597992f..25b19614aa3239 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -860,6 +860,9 @@ void md_autostart_arrays(int part);
 int md_set_array_info(struct mddev *mddev, struct mdu_array_info_s *info);
 int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info);
 int do_md_run(struct mddev *mddev);
+void mddev_stack_rdev_limits(struct mddev *mddev, struct queue_limits *lim);
+int mddev_stack_new_rdev(struct mddev *mddev, struct md_rdev *rdev);
+void mddev_update_io_opt(struct mddev *mddev, unsigned int nr_stripes);
 
 extern const struct block_device_operations md_fops;
 
-- 
2.39.2

