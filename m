Return-Path: <yukuai1@huaweicloud.com>
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com
	[45.249.212.56])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 695181622F4
	for <drbd-dev@lists.linbit.com>; Tue, 26 Aug 2025 03:00:53 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9pp73HcyzKHNNW
	for <drbd-dev@lists.linbit.com>; Tue, 26 Aug 2025 08:44:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 157871A0D9C
	for <drbd-dev@lists.linbit.com>; Tue, 26 Aug 2025 08:44:31 +0800 (CST)
Subject: Re: [PATCH 0/2] Fix the initialization of
	max_hw_wzeroes_unmap_sectors for stacking drivers
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, drbd-dev@lists.linbit.com
References: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <18a92f4f-e4e8-4b61-79b1-1b1f116af5fa@huaweicloud.com>
Date: Tue, 26 Aug 2025 08:44:29 +0800
MIME-Version: 1.0
In-Reply-To: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, martin.petersen@oracle.com, john.g.garry@oracle.com,
	yangerkun@huawei.com, yi.zhang@huawei.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	"yukuai \(C\)" <yukuai3@huawei.com>, hch@lst.de
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

ÔÚ 2025/08/25 16:33, Zhang Yi Ð´µÀ:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Hello,
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
>    md: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
>    drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
> 
>   drivers/block/drbd/drbd_nl.c | 1 +
>   drivers/md/md-linear.c       | 1 +
>   drivers/md/raid0.c           | 1 +
>   drivers/md/raid1.c           | 1 +
>   drivers/md/raid10.c          | 1 +
>   drivers/md/raid5.c           | 1 +
>   6 files changed, 6 insertions(+)
> 

For this set
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Thanks

