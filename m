Return-Path: <martin.petersen@oracle.com>
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
	[205.220.165.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D1BC51622B4
	for <drbd-dev@lists.linbit.com>; Mon, 25 Aug 2025 23:44:30 +0200 (CEST)
To: Zhang Yi <yi.zhang@huaweicloud.com>
Subject: Re: [PATCH 0/2] Fix the initialization of
	max_hw_wzeroes_unmap_sectors for stacking drivers
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250825083320.797165-1-yi.zhang@huaweicloud.com> (Zhang Yi's
	message of "Mon, 25 Aug 2025 16:33:18 +0800")
Message-ID: <yq1zfbnp480.fsf@ca-mkp.ca.oracle.com>
References: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
Date: Mon, 25 Aug 2025 15:54:22 -0400
Content-Type: text/plain
MIME-Version: 1.0
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, martin.petersen@oracle.com,
	john.g.garry@oracle.com, yangerkun@huawei.com,
	yi.zhang@huawei.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	yukuai3@huawei.com, hch@lst.de, drbd-dev@lists.linbit.com
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


Zhang,

> This series fixes the initialization of max_hw_wzeroes_unmap_sectors
> in queue_limits for all md raid and drbd drivers, preventing
> blk_validate_limits() failures on underlying devices that support the
> unmap write zeroes command.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
