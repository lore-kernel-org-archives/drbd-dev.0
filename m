Return-Path: <jinji.z.zhong@gmail.com>
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
	[209.85.210.180])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A84C416275D
	for <drbd-dev@lists.linbit.com>; Sun, 26 Oct 2025 02:05:41 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id
	d2e1a72fcca58-77f67ba775aso4238757b3a.3
	for <drbd-dev@lists.linbit.com>; Sat, 25 Oct 2025 18:05:41 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: minchan@kernel.org, senozhatsky@chromium.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
	corbet@lwn.net, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	axboe@kernel.dk, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, akpm@linux-foundation.org, terrelln@fb.com,
	dsterba@suse.com
Subject: [RFC PATCH 2/3] zram: Zram supports per-cgroup compression priority
Date: Sun, 26 Oct 2025 01:05:09 +0000
Message-ID: <0eef2265014bf9806eeaf5a00c9632958668c257.1761439133.git.jinji.z.zhong@gmail.com>
In-Reply-To: <cover.1761439133.git.jinji.z.zhong@gmail.com>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: liulu.liu@honor.com, feng.han@honor.com, linux-doc@vger.kernel.org,
	muchun.song@linux.dev, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	jinji zhong <jinji.z.zhong@gmail.com>, zhongjinji@honor.com,
	cgroups@vger.kernel.org, drbd-dev@lists.linbit.com
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

This patch allows zram to get the per-cgroup compression priority,
enabling administrators to select different compression algorithms
for different cgroups.

The feature is enabled by:
echo 1 > /sys/block/zramX/per_cgroup_comp_enable.
---
 drivers/block/zram/zram_drv.c | 74 +++++++++++++++++++++++++++++++----
 drivers/block/zram/zram_drv.h |  2 +
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a43074657531..da79034f2efa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -23,6 +23,7 @@
 #include <linux/buffer_head.h>
 #include <linux/device.h>
 #include <linux/highmem.h>
+#include <linux/memcontrol.h>
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/string.h>
@@ -1223,6 +1224,7 @@ static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 		kfree(zram->comp_algs[prio]);
 
 	zram->comp_algs[prio] = alg;
+	zram->comp_algs_flag |= (1 << prio);
 }
 
 static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
@@ -1396,7 +1398,7 @@ static ssize_t comp_algorithm_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_MULTI_COMP
-static ssize_t recomp_algorithm_show(struct device *dev,
+static ssize_t multi_comp_algorithm_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
@@ -1405,7 +1407,7 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 	u32 prio;
 
 	down_read(&zram->init_lock);
-	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
+	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
 		if (!zram->comp_algs[prio])
 			continue;
 
@@ -1416,7 +1418,7 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 	return sz;
 }
 
-static ssize_t recomp_algorithm_store(struct device *dev,
+static ssize_t multi_comp_algorithm_store(struct device *dev,
 				      struct device_attribute *attr,
 				      const char *buf,
 				      size_t len)
@@ -1450,12 +1452,43 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	if (!alg)
 		return -EINVAL;
 
-	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
+	if (prio < ZRAM_PRIMARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
 	ret = __comp_algorithm_store(zram, prio, alg);
 	return ret ? ret : len;
 }
+
+static ssize_t per_cgroup_comp_enable_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u64 val;
+	ssize_t ret = -EINVAL;
+
+	if (kstrtoull(buf, 10, &val))
+		return ret;
+
+	down_read(&zram->init_lock);
+	zram->per_cgroup_comp_enable = val;
+	up_read(&zram->init_lock);
+	ret = len;
+
+	return ret;
+}
+
+static ssize_t per_cgroup_comp_enable_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	bool val;
+	struct zram *zram = dev_to_zram(dev);
+
+	down_read(&zram->init_lock);
+	val = zram->per_cgroup_comp_enable;
+	up_read(&zram->init_lock);
+
+	return sysfs_emit(buf, "%d\n", val);
+}
 #endif
 
 static ssize_t compact_store(struct device *dev,
@@ -1840,9 +1873,30 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	return 0;
 }
 
+static inline bool is_comp_priority_valid(struct zram *zram, int prio)
+{
+	return zram->comp_algs_flag & (1 << prio);
+}
+
+static inline int get_comp_priority(struct zram *zram, struct page *page)
+{
+	int prio;
+
+	if (!zram->per_cgroup_comp_enable)
+		return ZRAM_PRIMARY_COMP;
+
+	prio = get_cgroup_comp_priority(page);
+	if (unlikely(!is_comp_priority_valid(zram, prio))) {
+		WARN_ON_ONCE(1);
+		return ZRAM_PRIMARY_COMP;
+	}
+	return prio;
+}
+
 static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 {
 	int ret = 0;
+	int prio;
 	unsigned long handle;
 	unsigned int comp_len;
 	void *mem;
@@ -1856,9 +1910,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	if (same_filled)
 		return write_same_filled_page(zram, element, index);
 
-	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
+	prio = get_comp_priority(zram, page);
+	zstrm = zcomp_stream_get(zram->comps[prio]);
 	mem = kmap_local_page(page);
-	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
+	ret = zcomp_compress(zram->comps[prio], zstrm,
 			     mem, &comp_len);
 	kunmap_local(mem);
 
@@ -1894,6 +1949,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zram_free_page(zram, index);
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, comp_len);
+	zram_set_priority(zram, index, prio);
 	zram_slot_unlock(zram, index);
 
 	/* Update stats */
@@ -2612,7 +2668,8 @@ static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
-static DEVICE_ATTR_RW(recomp_algorithm);
+static DEVICE_ATTR_RW(multi_comp_algorithm);
+static DEVICE_ATTR_RW(per_cgroup_comp_enable);
 static DEVICE_ATTR_WO(recompress);
 #endif
 static DEVICE_ATTR_WO(algorithm_params);
@@ -2639,8 +2696,9 @@ static struct attribute *zram_disk_attrs[] = {
 #endif
 	&dev_attr_debug_stat.attr,
 #ifdef CONFIG_ZRAM_MULTI_COMP
-	&dev_attr_recomp_algorithm.attr,
+	&dev_attr_multi_comp_algorithm.attr,
 	&dev_attr_recompress.attr,
+	&dev_attr_per_cgroup_comp_enable.attr,
 #endif
 	&dev_attr_algorithm_params.attr,
 	NULL,
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 6cee93f9c0d0..34ae0c3a9130 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -120,11 +120,13 @@ struct zram {
 	 */
 	u64 disksize;	/* bytes */
 	const char *comp_algs[ZRAM_MAX_COMPS];
+	u8 comp_algs_flag;
 	s8 num_active_comps;
 	/*
 	 * zram is claimed so open request will be failed
 	 */
 	bool claim; /* Protected by disk->open_mutex */
+	bool per_cgroup_comp_enable;
 #ifdef CONFIG_ZRAM_WRITEBACK
 	struct file *backing_dev;
 	spinlock_t wb_limit_lock;
-- 
2.48.1

