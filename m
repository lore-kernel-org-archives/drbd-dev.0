Return-Path: <yukuai1@huaweicloud.com>
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8863042032E
	for <drbd-dev@lists.linbit.com>; Wed, 28 Feb 2024 02:38:23 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tkxnh6BRKz4f3kJv
	for <drbd-dev@lists.linbit.com>; Wed, 28 Feb 2024 09:38:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3A22D1A0D84
	for <drbd-dev@lists.linbit.com>; Wed, 28 Feb 2024 09:38:20 +0800 (CST)
Subject: Re: [PATCH 04/16] md: add queue limit helpers
To: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
References: <20240226103004.281412-1-hch@lst.de>
	<20240226103004.281412-5-hch@lst.de>
	<6eb1741e-f336-bfb1-6549-21374ee667fc@huaweicloud.com>
	<20240227143618.GA13570@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e97d9a41-3e9e-0673-cbdd-466cb52d9f3f@huaweicloud.com>
Date: Wed, 28 Feb 2024 09:38:19 +0800
MIME-Version: 1.0
In-Reply-To: <20240227143618.GA13570@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Song Liu <song@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, "yukuai \(C\)" <yukuai3@huawei.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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

ÔÚ 2024/02/27 22:36, Christoph Hellwig Ð´µÀ:
> On Mon, Feb 26, 2024 at 07:38:17PM +0800, Yu Kuai wrote:
>> Any reason to use blk_mq_freeze/unfreeze_queue ? I don't think this is
>> meaningful for raid, this only wait for IO submission, not IO done.
>>
>> raid should already handle concurrent IO with reshape, so I think this
>> can just be removed.
> 
> We can't just change limits under the driver if I/Os are being sumitted.
> That is one of the points of the whole queue limits exercises.
> 

Agree with this, it's just these apis can't gurantee this in raid, there
could still be IO inflight, perhaps you can use:

mddev_suspend(mddev)
...
mddev_resume(mddev)

Thanks,
Kuai

> .
> 

