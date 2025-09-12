Return-Path: <yi.zhang@huaweicloud.com>
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com
	[45.249.212.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2258C16092C
	for <drbd-dev@lists.linbit.com>; Fri, 12 Sep 2025 08:16:17 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cNPM62RRMzYQvFJ
	for <drbd-dev@lists.linbit.com>; Fri, 12 Sep 2025 14:16:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D602E1A0F22
	for <drbd-dev@lists.linbit.com>; Fri, 12 Sep 2025 14:16:16 +0800 (CST)
Message-ID: <c7dd117e-6e3e-4b2d-a890-20f5c4bade2f@huaweicloud.com>
Date: Fri, 12 Sep 2025 14:16:10 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] Fix the initialization of
	max_hw_wzeroes_unmap_sectors for stacking drivers
To: axboe@kernel.dk
References: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-raid@vger.kernel.org, pmenzel@molgen.mpg.de,
	martin.petersen@oracle.com, john.g.garry@oracle.com,
	yangerkun@huawei.com, yi.zhang@huawei.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, hch@lst.de,
	drbd-dev@lists.linbit.com
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

Hi, Jens!

Can you take this patch set through the linux-block tree?

Thanks,
Yi.

On 9/10/2025 7:11 PM, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Changes since v1:
>  - Improve commit messages in patch 1 by adding a simple reproduction
>    case as Paul suggested and explaining the implementation differences
>    between RAID 0 and RAID 1/10/5, no code changes.
> 
> v1: https://lore.kernel.org/linux-block/20250825083320.797165-1-yi.zhang@huaweicloud.com/
> 
> This series fixes the initialization of max_hw_wzeroes_unmap_sectors in
> queue_limits for all md raid and drbd drivers, preventing
> blk_validate_limits() failures on underlying devices that support the
> unmap write zeroes command.
> 
> Best regards,
> Yi.
> 
> Zhang Yi (2):
>   md: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
>   drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
> 
>  drivers/block/drbd/drbd_nl.c | 1 +
>  drivers/md/md-linear.c       | 1 +
>  drivers/md/raid0.c           | 1 +
>  drivers/md/raid1.c           | 1 +
>  drivers/md/raid10.c          | 1 +
>  drivers/md/raid5.c           | 1 +
>  6 files changed, 6 insertions(+)
> 

