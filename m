Return-Path: <BATV+940d4f53d1157bf1ee93+6480+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 584AE420BA1
	for <drbd-dev@lists.linbit.com>; Fri, 21 May 2021 11:03:31 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jim Paris <jim@jtan.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>, Matias Bjorling <mb@lightnvm.io>,
	Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
	Song Liu <song@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 21 May 2021 07:50:55 +0200
Message-Id: <20210521055116.1053587-6-hch@lst.de>
In-Reply-To: <20210521055116.1053587-1-hch@lst.de>
References: <20210521055116.1053587-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
	linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/26] block: add blk_alloc_disk and
	blk_cleanup_disk APIs
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

Add two new APIs to allocate and free a gendisk including the
request_queue for use with BIO based drivers.  This is to avoid
boilerplate code in drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 35 +++++++++++++++++++++++++++++++++++
 include/linux/genhd.h | 22 ++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index e4974af3d729..6d4ce962866d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1302,6 +1302,25 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 }
 EXPORT_SYMBOL(__alloc_disk_node);
 
+struct gendisk *__blk_alloc_disk(int node)
+{
+	struct request_queue *q;
+	struct gendisk *disk;
+
+	q = blk_alloc_queue(node);
+	if (!q)
+		return NULL;
+
+	disk = __alloc_disk_node(0, node);
+	if (!disk) {
+		blk_cleanup_queue(q);
+		return NULL;
+	}
+	disk->queue = q;
+	return disk;
+}
+EXPORT_SYMBOL(__blk_alloc_disk);
+
 /**
  * put_disk - decrements the gendisk refcount
  * @disk: the struct gendisk to decrement the refcount for
@@ -1319,6 +1338,22 @@ void put_disk(struct gendisk *disk)
 }
 EXPORT_SYMBOL(put_disk);
 
+/**
+ * blk_cleanup_disk - shutdown a gendisk allocated by blk_alloc_disk
+ * @disk: gendisk to shutdown
+ *
+ * Mark the queue hanging off @disk DYING, drain all pending requests, then mark
+ * the queue DEAD, destroy and put it and the gendisk structure.
+ *
+ * Context: can sleep
+ */
+void blk_cleanup_disk(struct gendisk *disk)
+{
+	blk_cleanup_queue(disk->queue);
+	put_disk(disk);
+}
+EXPORT_SYMBOL(blk_cleanup_disk);
+
 static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 {
 	char event[] = "DISK_RO=1";
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index a5443f0b139d..03aa12730634 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -278,6 +278,28 @@ extern void put_disk(struct gendisk *disk);
 
 #define alloc_disk(minors) alloc_disk_node(minors, NUMA_NO_NODE)
 
+/**
+ * blk_alloc_disk - allocate a gendisk structure
+ * @node_id: numa node to allocate on
+ *
+ * Allocate and pre-initialize a gendisk structure for use with BIO based
+ * drivers.
+ *
+ * Context: can sleep
+ */
+#define blk_alloc_disk(node_id)						\
+({									\
+	struct gendisk *__disk = __blk_alloc_disk(node_id);		\
+	static struct lock_class_key __key;				\
+									\
+	if (__disk)							\
+		lockdep_init_map(&__disk->lockdep_map,			\
+			"(bio completion)", &__key, 0);			\
+	__disk;								\
+})
+struct gendisk *__blk_alloc_disk(int node);
+void blk_cleanup_disk(struct gendisk *disk);
+
 int __register_blkdev(unsigned int major, const char *name,
 		void (*probe)(dev_t devt));
 #define register_blkdev(major, name) \
-- 
2.30.2

