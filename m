Return-Path: <sagigrim@gmail.com>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 16248420323
	for <drbd-dev@lists.linbit.com>; Sun, 25 Dec 2022 12:40:27 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id z10so8193909wrh.10
	for <drbd-dev@lists.linbit.com>; Sun, 25 Dec 2022 03:40:27 -0800 (PST)
Message-ID: <1d0eb8e4-a91f-4635-bac7-9bc6cefbeff0@grimberg.me>
Date: Sun, 25 Dec 2022 13:40:23 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Gulam Mohamed <gulam.mohamed@oracle.com>, linux-block@vger.kernel.org
References: <20221221040506.1174644-1-gulam.mohamed@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221221040506.1174644-1-gulam.mohamed@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: nvdimm@lists.linux.dev, shminderjit.singh@oracle.com,
	linux-kernel@vger.kernel.org, song@kernel.org,
	dm-devel@redhat.com, ira.weiny@intel.com, agk@redhat.com,
	drbd-dev@lists.linbit.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, konrad.wilk@oracle.com,
	joe.jin@oracle.com, kent.overstreet@gmail.com, ngupta@vflare.org,
	kch@nvidia.com, senozhatsky@chromium.org, snitzer@kernel.org,
	colyli@suse.de, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org, dan.j.williams@intel.com,
	axboe@kernel.dk, martin.petersen@oracle.com,
	rajesh.sivaramasubramaniom@oracle.com,
	philipp.reisner@linbit.com, junxiao.bi@oracle.com,
	minchan@kernel.org, lars.ellenberg@linbit.com
Subject: Re: [Drbd-dev] [PATCH for-6.2/block V3 1/2] block: Data type
 conversion for IO accounting
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



On 12/21/22 06:05, Gulam Mohamed wrote:
> Change the data type of start and end time IO accounting variables in,
> block layer, from "unsigned long" to "u64". This is to enable nano-seconds
> granularity, in next commit, for the devices whose latency is less than
> milliseconds.
> 
> Changes from V2 to V3
> =====================
> 1. Changed all the required variables data-type to u64 as part of this
>     first patch
> 2. Create a new setting '2' for iostats in sysfs in next patch
> 3. Change the code to get the ktime values when iostat=2 in next patch
> 
> Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> ---
>   block/blk-core.c              | 24 ++++++++++++------------
>   block/blk.h                   |  2 +-
>   drivers/block/drbd/drbd_int.h |  2 +-
>   drivers/block/zram/zram_drv.c |  4 ++--
>   drivers/md/bcache/request.c   | 10 +++++-----
>   drivers/md/dm-core.h          |  2 +-
>   drivers/md/dm.c               |  2 +-
>   drivers/md/md.h               |  2 +-
>   drivers/md/raid1.h            |  2 +-
>   drivers/md/raid10.h           |  2 +-
>   drivers/md/raid5.c            |  2 +-
>   drivers/nvdimm/btt.c          |  2 +-
>   drivers/nvdimm/pmem.c         |  2 +-
>   include/linux/blk_types.h     |  2 +-
>   include/linux/blkdev.h        | 12 ++++++------
>   include/linux/part_stat.h     |  2 +-

nvme-mpath now also has stats, so struct nvme_request should also be
updated.
