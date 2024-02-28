Return-Path: <yukuai1@huaweicloud.com>
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com
	[45.249.212.56])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D79304202FD
	for <drbd-dev@lists.linbit.com>; Wed, 28 Feb 2024 02:42:13 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tkxt51KNQz4f3kF7
	for <drbd-dev@lists.linbit.com>; Wed, 28 Feb 2024 09:42:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 66CF91A0199
	for <drbd-dev@lists.linbit.com>; Wed, 28 Feb 2024 09:42:10 +0800 (CST)
Subject: Re: [PATCH 06/16] md/raid1: use the atomic queue limit update APIs
To: Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20240226103004.281412-1-hch@lst.de>
	<20240226103004.281412-7-hch@lst.de>
	<b4828284-87ec-693b-e2c3-84bdafcbda65@huaweicloud.com>
	<20240227152609.GA14782@lst.de>
	<CAPhsuW5xaK=WR1RKGpYkSzHW8TOMbUwY-KeTD=kD3otQFZZV0Q@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <19874170-1c9e-de5c-f197-d3b120a47c6d@huaweicloud.com>
Date: Wed, 28 Feb 2024 09:42:07 +0800
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5xaK=WR1RKGpYkSzHW8TOMbUwY-KeTD=kD3otQFZZV0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
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

在 2024/02/28 5:54, Song Liu 写道:
> On Tue, Feb 27, 2024 at 7:26 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Mon, Feb 26, 2024 at 07:29:08PM +0800, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2024/02/26 18:29, Christoph Hellwig 写道:
>>>> Build the queue limits outside the queue and apply them using
>>>> queue_limits_set.  Also remove the bogus ->gendisk and ->queue NULL
>>>> checks in the are while touching it.
>>>
>>> The checking of mddev->gendisk can't be removed, because this is used to
>>> distinguish dm-raid and md/raid. And the same for following patches.
>>
>> Ah.  Well, we should make that more obvious then.  This is what I
>> currently have:
>>
>> http://git.infradead.org/?p=users/hch/block.git;a=shortlog;h=refs/heads/md-blk-limits
>>
>> particularly:
>>
>> http://git.infradead.org/?p=users/hch/block.git;a=commitdiff;h=24b2fd15f57f06629d2254ebec480e1e28b96636
> 
> Yes! I was thinking about something like mddev_is_dm() to make these
> checks less confusing. Thanks!

Yes, this looks good.

Thanks,
Kuai

> 
> Song
> .
> 

