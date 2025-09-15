Return-Path: <john.g.garry@oracle.com>
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
	[205.220.165.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0B341160655
	for <drbd-dev@lists.linbit.com>; Mon, 15 Sep 2025 12:43:53 +0200 (CEST)
Message-ID: <370ca2e5-a4b2-4b5d-9fd1-a931dc2d1a6b@oracle.com>
Date: Mon, 15 Sep 2025 11:43:05 +0100
Subject: Re: [PATCH v2 0/2] Fix the initialization of
	max_hw_wzeroes_unmap_sectors for stacking drivers
To: Zhang Yi <yi.zhang@huaweicloud.com>, axboe@kernel.dk,
	linux-raid@vger.kernel.org
References: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
	<c7dd117e-6e3e-4b2d-a890-20f5c4bade2f@huaweicloud.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
In-Reply-To: <c7dd117e-6e3e-4b2d-a890-20f5c4bade2f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Cc: pmenzel@molgen.mpg.de, martin.petersen@oracle.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, linux-kernel@vger.kernel.org,
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

On 12/09/2025 07:16, Zhang Yi wrote:
> Hi, Jens!
> 
> Can you take this patch set through the linux-block tree?


md raid maintainers,

please try to get this picked up ASAP. As things stand, all these RAID 
personalities will be broken for 6.17 on drives supporting/reporting 
write zeroes.

Thanks

> 
> Thanks,
> Yi.
> 
> On 9/10/2025 7:11 PM, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Changes since v1:
>>   - Improve commit messages in patch 1 by adding a simple reproduction
>>     case as Paul suggested and explaining the implementation differences
>>     between RAID 0 and RAID 1/10/5, no code changes.
>>
>> v1: https://urldefense.com/v3/__https://lore.kernel.org/linux-block/20250825083320.797165-1-yi.zhang@huaweicloud.com/__;!!ACWV5N9M2RV99hQ!JAN4eq3ePrspeto0Hn7563lg3392Lh44jM1oTbgxbDoClxVOh5B73QhGD53f9tiLxuxfJCr51PyAP55COV2TTZAt$
>>
>> This series fixes the initialization of max_hw_wzeroes_unmap_sectors in
>> queue_limits for all md raid and drbd drivers, preventing
>> blk_validate_limits() failures on underlying devices that support the
>> unmap write zeroes command.
>>
>> Best regards,
>> Yi.
>>
>> Zhang Yi (2):
>>    md: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
>>    drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
>>
>>   drivers/block/drbd/drbd_nl.c | 1 +
>>   drivers/md/md-linear.c       | 1 +
>>   drivers/md/raid0.c           | 1 +
>>   drivers/md/raid1.c           | 1 +
>>   drivers/md/raid10.c          | 1 +
>>   drivers/md/raid5.c           | 1 +
>>   6 files changed, 6 insertions(+)
>>
> 
> 

