Return-Path: <ming.lei@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1BC4442096D
	for <drbd-dev@lists.linbit.com>; Thu,  8 Dec 2022 01:37:14 +0100 (CET)
Date: Thu, 8 Dec 2022 08:36:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Message-ID: <Y5ExoZ+7Am6Nm8+h@T590>
References: <20221207223204.22459-1-gulam.mohamed@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207223204.22459-1-gulam.mohamed@oracle.com>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, song@kernel.org,
	dm-devel@redhat.com, ira.weiny@intel.com, agk@redhat.com,
	drbd-dev@lists.linbit.com, dave.jiang@intel.com,
	minchan@kernel.org, vishal.l.verma@intel.com,
	konrad.wilk@oracle.com, joe.jin@oracle.com,
	kent.overstreet@gmail.com, ngupta@vflare.org, kch@nvidia.com,
	senozhatsky@chromium.org, snitzer@kernel.org, colyli@suse.de,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	dan.j.williams@intel.com, ming.lei@redhat.com, axboe@kernel.dk,
	linux-raid@vger.kernel.org, martin.petersen@oracle.com,
	philipp.reisner@linbit.com, junxiao.bi@oracle.com,
	lars.ellenberg@linbit.com
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

On Wed, Dec 07, 2022 at 10:32:04PM +0000, Gulam Mohamed wrote:
> As per the review comment from Jens Axboe, I am re-sending this patch
> against "for-6.2/block".
> 
> 
> Use ktime to change the granularity of IO accounting in block layer from
> milli-seconds to nano-seconds to get the proper latency values for the
> devices whose latency is in micro-seconds. After changing the granularity
> to nano-seconds the iostat command, which was showing incorrect values for
> %util, is now showing correct values.

Please add the theory behind why using nano-seconds can get correct accounting.

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
> 
> fio command
> -----------
> [global]
> bs=128K
> iodepth=1
> direct=1
> ioengine=libaio
> group_reporting
> time_based
> runtime=90
> thinktime=1ms
> numjobs=1
> name=raw-write
> rw=randrw
> ignore_error=EIO:EIO
> [job1]
> filename=/dev/nvme0n1
> 
> Correct values after kernel changes:
> ====================================
> iostat output
> -------------
> iostat -d /dev/nvme0n1 -x 1
> 
> Device            r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
> nvme0n1              0.08    0.05   0.06   128.00   128.00   0.07   6.50
> 
> Device            r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
> nvme0n1              0.08    0.06   0.06   128.00   128.00   0.07   6.30
> 
> Device            r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
> nvme0n1              0.06    0.05   0.06   128.00   128.00   0.06   5.70
> 
> From fio
> --------
> Read Latency: clat (usec): min=32, max=2335, avg=79.54, stdev=29.95
> Write Latency: clat (usec): min=38, max=130, avg=57.76, stdev= 3.25

Can you explain a bit why the above %util is correct?

BTW, %util is usually not important for SSDs, please see 'man iostat':

     %util
            Percentage of elapsed time during which I/O requests were issued to the device (bandwidth  uti‐
            lization for the device). Device saturation occurs when this value is close to 100% for devices
            serving requests serially.  But for devices serving requests in parallel, such as  RAID  arrays
            and modern SSDs, this number does not reflect their performance limits.


Thanks, 
Ming

