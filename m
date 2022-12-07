Return-Path: <yukuai1@huaweicloud.com>
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com
	[45.249.212.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 52E0842178C
	for <drbd-dev@lists.linbit.com>; Wed,  7 Dec 2022 14:09:14 +0100 (CET)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NRyKc2058z4f3pBt
	for <drbd-dev@lists.linbit.com>; Wed,  7 Dec 2022 21:09:08 +0800 (CST)
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
References: <20221206181536.13333-1-gulam.mohamed@oracle.com>
	<936a498b-19fe-36d5-ff32-817f153e57e3@huaweicloud.com>
	<Y5AFX4sxLRLV4uSt@T590>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <aadfc6d2-ad04-279c-a1d6-7f634d0b2c99@huaweicloud.com>
Date: Wed, 7 Dec 2022 21:09:08 +0800
MIME-Version: 1.0
In-Reply-To: <Y5AFX4sxLRLV4uSt@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

在 2022/12/07 11:15, Ming Lei 写道:
> On Wed, Dec 07, 2022 at 10:19:08AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2022/12/07 2:15, Gulam Mohamed 写道:
>>> Use ktime to change the granularity of IO accounting in block layer from
>>> milli-seconds to nano-seconds to get the proper latency values for the
>>> devices whose latency is in micro-seconds. After changing the granularity
>>> to nano-seconds the iostat command, which was showing incorrect values for
>>> %util, is now showing correct values.
>>
>> This patch didn't correct the counting of io_ticks, just make the
>> error accounting from jiffies(ms) to ns. The problem that util can be
>> smaller or larger still exist.
> 
> Agree.
> 
>>
>> However, I think this change make sense consider that error margin is
>> much smaller, and performance overhead should be minimum.
>>
>> Hi, Ming, how do you think?
> 
> I remembered that ktime_get() has non-negligible overhead, is there any
> test data(iops/cpu utilization) when running fio or t/io_uring on
> null_blk with this patch?

Yes, testing with null_blk is necessary, we don't want any performance
regression.

BTW, I thought it's fine because it's already used for tracking io
latency.
> 
> 
> Thanks,
> Ming
> 
> 
> .
> 

