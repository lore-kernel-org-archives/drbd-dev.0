Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com
	[209.85.166.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5C1CC160655
	for <drbd-dev@lists.linbit.com>; Wed, 17 Sep 2025 16:21:14 +0200 (CEST)
Received: by mail-io1-f51.google.com with SMTP id
	ca18e2360f4ac-890e5bb3100so138987639f.0
	for <drbd-dev@lists.linbit.com>; Wed, 17 Sep 2025 07:21:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	drbd-dev@lists.linbit.com, Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
References: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
Subject: Re: (subset) [PATCH v2 0/2] Fix the initialization of
	max_hw_wzeroes_unmap_sectors for stacking drivers
Message-Id: <175811887192.378805.895284774096542580.b4-ty@kernel.dk>
Date: Wed, 17 Sep 2025 08:21:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: pmenzel@molgen.mpg.de, martin.petersen@oracle.com, john.g.garry@oracle.com,
	yangerkun@huawei.com, yi.zhang@huawei.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	yukuai3@huawei.com, hch@lst.de
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


On Wed, 10 Sep 2025 19:11:05 +0800, Zhang Yi wrote:
> Changes since v1:
>  - Improve commit messages in patch 1 by adding a simple reproduction
>    case as Paul suggested and explaining the implementation differences
>    between RAID 0 and RAID 1/10/5, no code changes.
> 
> v1: https://lore.kernel.org/linux-block/20250825083320.797165-1-yi.zhang@huaweicloud.com/
> 
> [...]

Applied, thanks!

[2/2] drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
      commit: 027a7a9c07d0d759ab496a7509990aa33a4b689c

Best regards,
-- 
Jens Axboe



