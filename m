Return-Path: <ming.lei@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3B43942177D
	for <drbd-dev@lists.linbit.com>; Wed,  7 Dec 2022 04:23:07 +0100 (CET)
Date: Wed, 7 Dec 2022 11:15:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <Y5AFX4sxLRLV4uSt@T590>
References: <20221206181536.13333-1-gulam.mohamed@oracle.com>
	<936a498b-19fe-36d5-ff32-817f153e57e3@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <936a498b-19fe-36d5-ff32-817f153e57e3@huaweicloud.com>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, song@kernel.org,
	dm-devel@redhat.com, ira.weiny@intel.com, agk@redhat.com,
	drbd-dev@lists.linbit.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, konrad.wilk@oracle.com,
	"yukuai \(C\)" <yukuai3@huawei.com>, kent.overstreet@gmail.com,
	ngupta@vflare.org, kch@nvidia.com, senozhatsky@chromium.org,
	Gulam Mohamed <gulam.mohamed@oracle.com>, snitzer@kernel.org,
	colyli@suse.de, linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org, dan.j.williams@intel.com,
	axboe@kernel.dk, linux-raid@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	junxiao.bi@oracle.com, minchan@kernel.org, lars.ellenberg@linbit.com
Subject: Re: [Drbd-dev] [RFC] block: Change the granularity of io ticks from
	ms to ns
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

On Wed, Dec 07, 2022 at 10:19:08AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2022/12/07 2:15, Gulam Mohamed 写道:
> > Use ktime to change the granularity of IO accounting in block layer from
> > milli-seconds to nano-seconds to get the proper latency values for the
> > devices whose latency is in micro-seconds. After changing the granularity
> > to nano-seconds the iostat command, which was showing incorrect values for
> > %util, is now showing correct values.
> 
> This patch didn't correct the counting of io_ticks, just make the
> error accounting from jiffies(ms) to ns. The problem that util can be
> smaller or larger still exist.

Agree.

> 
> However, I think this change make sense consider that error margin is
> much smaller, and performance overhead should be minimum.
> 
> Hi, Ming, how do you think?

I remembered that ktime_get() has non-negligible overhead, is there any
test data(iops/cpu utilization) when running fio or t/io_uring on
null_blk with this patch?


Thanks, 
Ming

