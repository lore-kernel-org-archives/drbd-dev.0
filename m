Return-Path: <jinji.z.zhong@gmail.com>
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
	[209.85.210.169])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 94B15160973
	for <drbd-dev@lists.linbit.com>; Sun, 26 Oct 2025 02:05:32 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
	d2e1a72fcca58-78af743c232so3184916b3a.1
	for <drbd-dev@lists.linbit.com>; Sat, 25 Oct 2025 18:05:32 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: minchan@kernel.org, senozhatsky@chromium.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
	corbet@lwn.net, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	axboe@kernel.dk, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, akpm@linux-foundation.org, terrelln@fb.com,
	dsterba@suse.com
Subject: [RFC PATCH 1/3] mm/memcontrol: Introduce per-cgroup compression
	priority
Date: Sun, 26 Oct 2025 01:05:08 +0000
Message-ID: <18d8e6b876ea3ae98bff710474423a9a530f4a8a.1761439133.git.jinji.z.zhong@gmail.com>
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

On Android, applications have varying tolerance for decompression speed.
Background and lightweight applications tolerate slower decompression
better than large, foreground applications. They are suitable for
algorithms like ZSTD, which has a high compression ratio but slower
decompression. Other applications may prefer algorithms with faster
decompression.

This patch introduces a per-cgroup compression priority mechanism.
Different compression priorities map to different algorithms. This
allows administrators to select the appropriate compression algorithm
on a per-cgroup basis.
---
 include/linux/memcontrol.h | 19 +++++++++++++++++++
 mm/memcontrol.c            | 31 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 873e510d6f8d..a91670b8c469 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -228,6 +228,9 @@ struct mem_cgroup {
 
 	int swappiness;
 
+	/* The priority of the compression algorithm used by the cgroup. */
+	int comp_priority;
+
 	/* memory.events and memory.events.local */
 	struct cgroup_file events_file;
 	struct cgroup_file events_local_file;
@@ -523,6 +526,22 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
 	return memcg;
 }
 
+#define DEF_COMP_PRIORITY 0
+
+/*
+* get_cgroup_comp_priority - Get the compression priority of the memcg
+* @page: Pointer to the page.
+* Returns the compression priority of the memcg the page belongs to.
+*/
+static inline int get_cgroup_comp_priority(struct page *page)
+{
+	struct mem_cgroup *memcg = folio_memcg(page_folio(page));
+	if (!memcg)
+		return DEF_COMP_PRIORITY;
+
+	return memcg->comp_priority;
+}
+
 /*
  * folio_memcg_kmem - Check if the folio has the memcg_kmem flag set.
  * @folio: Pointer to the folio.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4deda33625f4..436cbc8ddcc2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5356,6 +5356,31 @@ static int swap_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int swap_comp_priority_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	seq_printf(m, "%d\n", READ_ONCE(memcg->comp_priority));
+	return 0;
+}
+
+static ssize_t swap_comp_priority_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int comp_priority;
+	ssize_t parse_ret = kstrtoint(strstrip(buf), 10, &comp_priority);
+
+	if (parse_ret)
+		return parse_ret;
+
+	if (comp_priority < 0)
+		return -EINVAL;
+
+	WRITE_ONCE(memcg->comp_priority, comp_priority);
+	return nbytes;
+}
+
 static struct cftype swap_files[] = {
 	{
 		.name = "swap.current",
@@ -5388,6 +5413,12 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+	{
+		.name = "swap.comp_priority",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_comp_priority_show,
+		.write = swap_comp_priority_write,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.48.1

