Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
	[209.85.216.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E98DE421788
	for <drbd-dev@lists.linbit.com>; Thu,  8 Dec 2022 00:08:37 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
	t11-20020a17090a024b00b0021932afece4so2857392pje.5
	for <drbd-dev@lists.linbit.com>; Wed, 07 Dec 2022 15:08:37 -0800 (PST)
Message-ID: <abaa2003-4ddf-5ef9-d62c-1708a214609d@kernel.dk>
Date: Wed, 7 Dec 2022 16:08:33 -0700
MIME-Version: 1.0
Content-Language: en-US
To: Gulam Mohamed <gulam.mohamed@oracle.com>, linux-block@vger.kernel.org
References: <20221207223204.22459-1-gulam.mohamed@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221207223204.22459-1-gulam.mohamed@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: nvdimm@lists.linux.dev, philipp.reisner@linbit.com, song@kernel.org,
	dm-devel@redhat.com, ira.weiny@intel.com, agk@redhat.com,
	drbd-dev@lists.linbit.com, dave.jiang@intel.com,
	minchan@kernel.org, vishal.l.verma@intel.com, joe.jin@oracle.com,
	kent.overstreet@gmail.com, ngupta@vflare.org, kch@nvidia.com,
	konrad.wilk@oracle.com, snitzer@kernel.org, colyli@suse.de,
	linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	dan.j.williams@intel.com, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, junxiao.bi@oracle.com,
	senozhatsky@chromium.org, lars.ellenberg@linbit.com
Subject: Re: [Drbd-dev] [RFC for-6.2/block V2] block: Change the granularity
 of io ticks from ms to ns
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

On 12/7/22 3:32?PM, Gulam Mohamed wrote:
> As per the review comment from Jens Axboe, I am re-sending this patch
> against "for-6.2/block".
> 
> 
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

My default peak testing runs at 122M IOPS. That's also the peak IOPS of
the devices combined, and with iostats disabled. If I enabled iostats,
then the performance drops to 112M IOPS. It's no longer device limited,
that's a drop of about 8.2%.

Adding this patch, and with iostats enabled, performance is at 91M IOPS.
That's a ~25% drop from no iostats, and a ~19% drop from the iostats we
have now...

Here's what I'd like to see changed:

- Split the patch up. First change all the types from unsigned long to
  u64, that can be done while retaining jiffies.

- Add an iostats == 2 setting, which enables this higher resolution
  mode. We'd still default to 1, lower granularity iostats enabled.

I think that's cleaner than one big patch, and means that patch 1 should
not really have any noticeable changes. That's generally how I like to
get things split. With that, then I think there could be a way to get
this included.

-- 
Jens Axboe

