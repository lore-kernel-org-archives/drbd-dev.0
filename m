Return-Path: <yukuai1@huaweicloud.com>
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com
	[45.249.212.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3CD7616090F
	for <drbd-dev@lists.linbit.com>; Wed, 10 Sep 2025 10:31:51 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMDSQ6tl3zYQvcM
	for <drbd-dev@lists.linbit.com>; Wed, 10 Sep 2025 16:31:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 75FAF1A1798
	for <drbd-dev@lists.linbit.com>; Wed, 10 Sep 2025 16:31:49 +0800 (CST)
Subject: Re: [PATCH 1/2] md: init queue_limits->max_hw_wzeroes_unmap_sectors
	parameter
To: John Garry <john.g.garry@oracle.com>, Zhang Yi
	<yi.zhang@huaweicloud.com>, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, drbd-dev@lists.linbit.com
References: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
	<20250825083320.797165-2-yi.zhang@huaweicloud.com>
	<5b0fd2a0-dffc-4f51-bdff-746e9bd611bd@oracle.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <05249654-3088-d3e1-570d-79f58019377c@huaweicloud.com>
Date: Wed, 10 Sep 2025 16:31:47 +0800
MIME-Version: 1.0
In-Reply-To: <5b0fd2a0-dffc-4f51-bdff-746e9bd611bd@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, martin.petersen@oracle.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
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

Hi,

在 2025/09/02 20:25, John Garry 写道:
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index 408c26398321..35c6498b4917 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -3211,6 +3211,7 @@ static int raid1_set_limits(struct mddev *mddev)
>>       md_init_stacking_limits(&lim);
>>       lim.max_write_zeroes_sectors = 0;
>> +    lim.max_hw_wzeroes_unmap_sectors = 0;
> 
> It would be better if we documented why we cannot support this on 
> raid1/10, yet we can on raid0.
> 
> I am looking through the history of why max_write_zeroes_sectors is set 
> to zero. I have gone as far back as 5026d7a9b, and this tells us that 
> the retry mechanism for WRITE SAME causes an issue where mirrors are 
> offlined (and so we disabled the support); and this was simply copied 
> for write zeroes in 3deff1a70.

Yes, we don't support it for now, and I think it is not too hard to
support write zeros, and finaly to support unmap zeros. BTW, raid5
discard is in the same suituation.

However, I feel this is not related to this set, perhaps a seperate
patch to add comments, I can accept that.

Thanks,
Kuai

