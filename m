Return-Path: <tj@kernel.org>
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CA987160952
	for <drbd-dev@lists.linbit.com>; Mon, 27 Oct 2025 17:16:49 +0100 (CET)
Date: Mon, 27 Oct 2025 06:06:49 -1000
From: Tejun Heo <tj@kernel.org>
To: jinji zhong <jinji.z.zhong@gmail.com>
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Message-ID: <aP-Ymcsoyls04jov@slm.duckdns.org>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761439133.git.jinji.z.zhong@gmail.com>
Cc: linux-doc@vger.kernel.org, roman.gushchin@linux.dev,
	philipp.reisner@linbit.com, linux-mm@kvack.org,
	shakeel.butt@linux.dev, drbd-dev@lists.linbit.com,
	corbet@lwn.net, senozhatsky@chromium.org,
	linux-block@vger.kernel.org, terrelln@fb.com, dsterba@suse.com,
	cgroups@vger.kernel.org, mhocko@kernel.org,
	akpm@linux-foundation.org, axboe@kernel.dk, feng.han@honor.com,
	liulu.liu@honor.com, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, minchan@kernel.org,
	mkoutny@suse.com, hannes@cmpxchg.org, zhongjinji@honor.com,
	lars.ellenberg@linbit.com
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

Hello,

On Sun, Oct 26, 2025 at 01:05:07AM +0000, jinji zhong wrote:
> This patch introduces a per-cgroup compression priority mechanism,
> where different compression priorities map to different algorithms.
> This allows administrators to select appropriate compression
> algorithms on a per-cgroup basis.

I don't think it makes sense to tie this to cgroups. Is there something
preventing this from following the process hierarchy?

Thanks.

-- 
tejun
