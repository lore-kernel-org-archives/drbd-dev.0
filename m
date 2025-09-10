Return-Path: <john.g.garry@oracle.com>
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
	[205.220.165.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 519E716090F
	for <drbd-dev@lists.linbit.com>; Wed, 10 Sep 2025 11:01:48 +0200 (CEST)
Message-ID: <7956f88a-310c-48b1-9252-23d843d932df@oracle.com>
Date: Wed, 10 Sep 2025 10:01:26 +0100
Subject: Re: [PATCH 1/2] md: init queue_limits->max_hw_wzeroes_unmap_sectors
	parameter
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, drbd-dev@lists.linbit.com
References: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
	<20250825083320.797165-2-yi.zhang@huaweicloud.com>
	<5b0fd2a0-dffc-4f51-bdff-746e9bd611bd@oracle.com>
	<70c56bd4-89b0-41b8-8ac5-c38ac97319ca@huaweicloud.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
In-Reply-To: <70c56bd4-89b0-41b8-8ac5-c38ac97319ca@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Cc: axboe@kernel.dk, martin.petersen@oracle.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, hch@lst.de
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

On 10/09/2025 09:55, Zhang Yi wrote:
>> It would be better if we documented why we cannot support this on raid1/10, yet we can on raid0.
>>
>> I am looking through the history of why max_write_zeroes_sectors is set to zero. I have gone as far back as 5026d7a9b, and this tells us that the retry mechanism for WRITE SAME causes an issue where mirrors are offlined (and so we disabled the support); and this was simply copied for write zeroes in 3deff1a70.
> Yes, as discussed with Kuai, it's better to add TODO comments for
> RAID 1, 10, and 5 for now, and we can support them by properly
> propagating unsupported errors to the upper layers. I can send out
> a separate patch to add this comment.

Sure, adding a comment would be good, detailing the technical challenge 
in supporting it.

For now, this series should go in ASAP.
