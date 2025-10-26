Return-Path: <jinji.z.zhong@gmail.com>
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
	[209.85.210.170])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D4CB016094D
	for <drbd-dev@lists.linbit.com>; Sun, 26 Oct 2025 02:05:23 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
	d2e1a72fcca58-79ef9d1805fso3728838b3a.1
	for <drbd-dev@lists.linbit.com>; Sat, 25 Oct 2025 18:05:23 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: minchan@kernel.org, senozhatsky@chromium.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
	corbet@lwn.net, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	axboe@kernel.dk, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, akpm@linux-foundation.org, terrelln@fb.com,
	dsterba@suse.com
Subject: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Date: Sun, 26 Oct 2025 01:05:07 +0000
Message-ID: <cover.1761439133.git.jinji.z.zhong@gmail.com>
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

Hello everyone,

On Android, different applications have varying tolerance for
decompression latency. Applications with higher tolerance for
decompression latency are better suited for algorithms like ZSTD,
which provides high compression ratio but slower decompression
speed. Conversely, applications with lower tolerance for
decompression latency can use algorithms like LZ4 or LZO that
offer faster decompression but lower compression ratios. For example,
lightweight applications (with few anonymous pages) or applications
without foreground UI typically have higher tolerance for decompression
latency.

Similarly, in memory allocation slow paths or under high CPU
pressure, using algorithms with faster compression speeds might
be more appropriate.

This patch introduces a per-cgroup compression priority mechanism,
where different compression priorities map to different algorithms.
This allows administrators to select appropriate compression
algorithms on a per-cgroup basis.

Currently, this patch is experimental and we would greatly
appreciate community feedback. I'm uncertain whether obtaining
compression priority via get_cgroup_comp_priority in zram is the
best approach. While this implementation is convenient, it seems
somewhat unusual. Perhaps the next step should be to pass
compression priority through page->private.

jinji zhong (3):
  mm/memcontrol: Introduce per-cgroup compression priority
  zram: Zram supports per-cgroup compression priority
  Doc: Update documentation for per-cgroup compression priority

 Documentation/admin-guide/blockdev/zram.rst | 18 +++--
 Documentation/admin-guide/cgroup-v2.rst     |  7 ++
 drivers/block/zram/zram_drv.c               | 74 ++++++++++++++++++---
 drivers/block/zram/zram_drv.h               |  2 +
 include/linux/memcontrol.h                  | 19 ++++++
 mm/memcontrol.c                             | 31 +++++++++
 6 files changed, 139 insertions(+), 12 deletions(-)

-- 
2.48.1

