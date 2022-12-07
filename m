Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
	[209.85.166.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 17F0042096D
	for <drbd-dev@lists.linbit.com>; Wed,  7 Dec 2022 18:08:53 +0100 (CET)
Received: by mail-io1-f46.google.com with SMTP id d123so6712375iof.6
	for <drbd-dev@lists.linbit.com>; Wed, 07 Dec 2022 09:08:53 -0800 (PST)
Message-ID: <eaf4f9a8-dfc6-402e-4a1a-732034d1512d@kernel.dk>
Date: Wed, 7 Dec 2022 10:08:50 -0700
MIME-Version: 1.0
To: Gulam Mohamed <gulam.mohamed@oracle.com>, linux-block@vger.kernel.org
References: <20221206181536.13333-1-gulam.mohamed@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221206181536.13333-1-gulam.mohamed@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: nvdimm@lists.linux.dev, philipp.reisner@linbit.com, song@kernel.org,
	dm-devel@redhat.com, ira.weiny@intel.com, agk@redhat.com,
	drbd-dev@lists.linbit.com, dave.jiang@intel.com,
	minchan@kernel.org, vishal.l.verma@intel.com,
	kent.overstreet@gmail.com, ngupta@vflare.org, kch@nvidia.com,
	konrad.wilk@oracle.com, snitzer@kernel.org, colyli@suse.de,
	linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	dan.j.williams@intel.com, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, junxiao.bi@oracle.com,
	senozhatsky@chromium.org, lars.ellenberg@linbit.com
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

On 12/6/22 11:15?AM, Gulam Mohamed wrote:
> Use ktime to change the granularity of IO accounting in block layer from
> milli-seconds to nano-seconds to get the proper latency values for the
> devices whose latency is in micro-seconds. After changing the granularity
> to nano-seconds the iostat command, which was showing incorrect values for
> %util, is now showing correct values.
> 
> We did not work on the patch to drop the logic for
> STAT_PRECISE_TIMESTAMPS yet. Will do it if this patch is ok.
> 
> The iostat command was run after starting the fio with following command
> on an NVME disk. For the same fio command, the iostat %util was showing
> ~100% for the disks whose latencies are in the range of microseconds.
> With the kernel changes (granularity to nano-seconds), the %util was
> showing correct values. Following are the details of the test and their
> output:

As mentioned, this will most likely have a substantial performance
impact. I'd test it, but your patch is nowhere near applying to the
current block tree. Please resend it against for-6.2/block so it can
get tested.

-- 
Jens Axboe

