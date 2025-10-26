Return-Path: <jinji.z.zhong@gmail.com>
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
	[209.85.210.170])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8622C162762
	for <drbd-dev@lists.linbit.com>; Sun, 26 Oct 2025 02:05:48 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
	d2e1a72fcca58-7a23208a0c2so2614265b3a.0
	for <drbd-dev@lists.linbit.com>; Sat, 25 Oct 2025 18:05:48 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: minchan@kernel.org, senozhatsky@chromium.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
	corbet@lwn.net, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	axboe@kernel.dk, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, akpm@linux-foundation.org, terrelln@fb.com,
	dsterba@suse.com
Subject: [RFC PATCH 3/3] Doc: Update documentation for per-cgroup compression
	priority
Date: Sun, 26 Oct 2025 01:05:10 +0000
Message-ID: <25cab6bc87a6cd69983e2fa0908441bc37015c98.1761439133.git.jinji.z.zhong@gmail.com>
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

This patch updates the documentation, describing the newly
introduced per-cgroup compression priority mechanism.
---
 Documentation/admin-guide/blockdev/zram.rst | 18 ++++++++++++++----
 Documentation/admin-guide/cgroup-v2.rst     |  7 +++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 3e273c1bb749..de4ab060f664 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -452,12 +452,12 @@ using more effective algorithm and, hence, reduce zsmalloc memory usage.
 With CONFIG_ZRAM_MULTI_COMP, zram supports up to 4 compression algorithms:
 one primary and up to 3 secondary ones. Primary zram compressor is explained
 in "3) Select compression algorithm", secondary algorithms are configured
-using recomp_algorithm device attribute.
+using multi_comp_algorithm device attribute.
 
 Example:::
 
 	#show supported recompression algorithms
-	cat /sys/block/zramX/recomp_algorithm
+	cat /sys/block/zramX/multi_comp_algorithm
 	#1: lzo lzo-rle lz4 lz4hc [zstd]
 	#2: lzo lzo-rle lz4 [lz4hc] zstd
 
@@ -468,10 +468,10 @@ Alternative compression algorithm's priority is provided during algorithms
 configuration:::
 
 	#select zstd recompression algorithm, priority 1
-	echo "algo=zstd priority=1" > /sys/block/zramX/recomp_algorithm
+	echo "algo=zstd priority=1" > /sys/block/zramX/multi_comp_algorithm
 
 	#select deflate recompression algorithm, priority 2
-	echo "algo=deflate priority=2" > /sys/block/zramX/recomp_algorithm
+	echo "algo=deflate priority=2" > /sys/block/zramX/multi_comp_algorithm
 
 Another device attribute that CONFIG_ZRAM_MULTI_COMP enables is recompress,
 which controls recompression.
@@ -524,6 +524,16 @@ This can be achieved by providing a `algo` or `priority` parameter:::
 	#use zstd algorithm only (if zstd was registered under priority 1)
 	echo "type=huge priority=1" > /sys/block/zramX/recompress
 
+per-cgroup compression algorithms
+-------------
+With CONFIG_ZRAM_MULTI_COMP, zram can compress pages using the compression
+algorithm determined by the cgroup. It will get the compression priority from
+the cgroup and use the corresponding compression algorithm to compress the page.
+
+To use the feature, admin should enable per-cgroup compression via::
+
+	echo 1 > /sys/block/zramX/per_cgroup_comp_enable
+
 memory tracking
 ===============
 
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0e6c67ac585a..1706d8f0d225 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1871,6 +1871,13 @@ The following nested keys are defined.
 	higher than the limit for an extended period of time.  This
 	reduces the impact on the workload and memory management.
 
+  memory.swap.compress_priority
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "0".
+
+	swap compress priority for the cgroup. Different compression
+	priorities mean different compression algorithms.
+
   memory.zswap.current
 	A read-only single value file which exists on non-root
 	cgroups.
-- 
2.48.1

