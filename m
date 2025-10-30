Return-Path: <zhongjinji@honor.com>
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3FCB81608F1
	for <drbd-dev@lists.linbit.com>; Thu, 30 Oct 2025 10:38:28 +0100 (CET)
From: zhongjinji <zhongjinji@honor.com>
To: <tj@kernel.org>
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Date: Thu, 30 Oct 2025 17:22:58 +0800
Message-ID: <20251030092258.2576-1-zhongjinji@honor.com>
In-Reply-To: <aP-Ymcsoyls04jov@slm.duckdns.org>
References: <aP-Ymcsoyls04jov@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-doc@vger.kernel.org, roman.gushchin@linux.dev, mhocko@kernel.org,
	liulu.liu@honor.com, shakeel.butt@linux.dev,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com,
	corbet@lwn.net, jinji.z.zhong@gmail.com,
	senozhatsky@chromium.org, linux-block@vger.kernel.org,
	terrelln@fb.com, dsterba@suse.com, cgroups@vger.kernel.org,
	lars.ellenberg@linbit.com, axboe@kernel.dk, feng.han@honor.com,
	linux-mm@kvack.org, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, minchan@kernel.org,
	mkoutny@suse.com, hannes@cmpxchg.org, zhongjinji@honor.com,
	akpm@linux-foundation.org
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

> Hello,
> 
> On Sun, Oct 26, 2025 at 01:05:07AM +0000, jinji zhong wrote:
> > This patch introduces a per-cgroup compression priority mechanism,
> > where different compression priorities map to different algorithms.
> > This allows administrators to select appropriate compression
> > algorithms on a per-cgroup basis.
> 
> I don't think it makes sense to tie this to cgroups. Is there something
> preventing this from following the process hierarchy?
> Thanks.
Hello, Tejun,

There is also a layer of page tables between the process and the page,
so making it follow the process hierarchy would be complicated.
But you make a good point; it may indeed be unnecessary to introduce
a separate per-cgroup compression priority. As Nhat suggested,
we could try reusing the per-cgroup swap priority.

> -- 
> tejun
