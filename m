Return-Path: <shakeel.butt@linux.dev>
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
	[91.218.175.185])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EA4B31626D9
	for <drbd-dev@lists.linbit.com>; Mon, 27 Oct 2025 18:35:31 +0100 (CET)
Date: Mon, 27 Oct 2025 10:29:06 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: jinji zhong <jinji.z.zhong@gmail.com>
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Message-ID: <k6jwua5rlkds7dxomwvxotwtjq4hauyevvyoxd5hjz733k7kk5@mmezlradxhpu>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761439133.git.jinji.z.zhong@gmail.com>
Cc: linux-doc@vger.kernel.org, roman.gushchin@linux.dev, mhocko@kernel.org,
	linux-mm@kvack.org, drbd-dev@lists.linbit.com, corbet@lwn.net,
	senozhatsky@chromium.org, linux-block@vger.kernel.org,
	terrelln@fb.com, dsterba@suse.com, cgroups@vger.kernel.org,
	akpm@linux-foundation.org, axboe@kernel.dk, feng.han@honor.com,
	liulu.liu@honor.com, muchun.song@linux.dev,
	philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	minchan@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
	tj@kernel.org, zhongjinji@honor.com, lars.ellenberg@linbit.com
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

Hi Jinji,

On Sun, Oct 26, 2025 at 01:05:07AM +0000, jinji zhong wrote:
> Hello everyone,
> 
> On Android, different applications have varying tolerance for
> decompression latency. Applications with higher tolerance for
> decompression latency are better suited for algorithms like ZSTD,
> which provides high compression ratio but slower decompression
> speed. Conversely, applications with lower tolerance for
> decompression latency can use algorithms like LZ4 or LZO that
> offer faster decompression but lower compression ratios. For example,
> lightweight applications (with few anonymous pages) or applications
> without foreground UI typically have higher tolerance for decompression
> latency.
> 
> Similarly, in memory allocation slow paths or under high CPU
> pressure, using algorithms with faster compression speeds might
> be more appropriate.
> 
> This patch introduces a per-cgroup compression priority mechanism,
> where different compression priorities map to different algorithms.
> This allows administrators to select appropriate compression
> algorithms on a per-cgroup basis.
> 
> Currently, this patch is experimental and we would greatly
> appreciate community feedback. I'm uncertain whether obtaining
> compression priority via get_cgroup_comp_priority in zram is the
> best approach. While this implementation is convenient, it seems
> somewhat unusual. Perhaps the next step should be to pass
> compression priority through page->private.
> 

Setting aside the issues in the implementation (like changing
compression algorithm of a cgroup while it already has some memory
compressed using older algo), I don't think memcg interface is the right
way to go about it. We usually add interfaces to memcg that have
hierarchical semantics.

Anyways if you want to have this feature, I think BPF might be the way
to get this flexibility without introducing any stable API and then you
can experiment and evaluate if this really helps.
