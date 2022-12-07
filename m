Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com
	[209.85.166.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B662642177D
	for <drbd-dev@lists.linbit.com>; Wed,  7 Dec 2022 18:22:13 +0100 (CET)
Received: by mail-io1-f43.google.com with SMTP id o189so6519458iof.0
	for <drbd-dev@lists.linbit.com>; Wed, 07 Dec 2022 09:22:13 -0800 (PST)
Message-ID: <b8deb6fa-8a09-c1af-278f-24e66afe367d@kernel.dk>
Date: Wed, 7 Dec 2022 10:22:09 -0700
MIME-Version: 1.0
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>
References: <20221206181536.13333-1-gulam.mohamed@oracle.com>
	<936a498b-19fe-36d5-ff32-817f153e57e3@huaweicloud.com>
	<Y5AFX4sxLRLV4uSt@T590>
	<aadfc6d2-ad04-279c-a1d6-7f634d0b2c99@huaweicloud.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aadfc6d2-ad04-279c-a1d6-7f634d0b2c99@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
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
	linux-raid@vger.kernel.org, martin.petersen@oracle.com,
	philipp.reisner@linbit.com, junxiao.bi@oracle.com,
	minchan@kernel.org, lars.ellenberg@linbit.com
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

On 12/7/22 6:09 AM, Yu Kuai wrote:
> Hi,
> 
> 在 2022/12/07 11:15, Ming Lei 写道:
>> On Wed, Dec 07, 2022 at 10:19:08AM +0800, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2022/12/07 2:15, Gulam Mohamed 写道:
>>>> Use ktime to change the granularity of IO accounting in block layer from
>>>> milli-seconds to nano-seconds to get the proper latency values for the
>>>> devices whose latency is in micro-seconds. After changing the granularity
>>>> to nano-seconds the iostat command, which was showing incorrect values for
>>>> %util, is now showing correct values.
>>>
>>> This patch didn't correct the counting of io_ticks, just make the
>>> error accounting from jiffies(ms) to ns. The problem that util can be
>>> smaller or larger still exist.
>>
>> Agree.
>>
>>>
>>> However, I think this change make sense consider that error margin is
>>> much smaller, and performance overhead should be minimum.
>>>
>>> Hi, Ming, how do you think?
>>
>> I remembered that ktime_get() has non-negligible overhead, is there any
>> test data(iops/cpu utilization) when running fio or t/io_uring on
>> null_blk with this patch?
> 
> Yes, testing with null_blk is necessary, we don't want any performance
> regression.

null_blk is fine as a substitute, but I'd much rather run this on my
test bench with actual IO and devices.

> BTW, I thought it's fine because it's already used for tracking io
> latency.

Reading a nsec timestamp is a LOT more expensive than reading jiffies,
which is essentially free. If you look at the amount of work that's
gone into minimizing ktime_get() for the fast path in the IO stack,
then that's a testament to that.

So that's a very bad assumption, and definitely wrong.

-- 
Jens Axboe


