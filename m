Return-Path: <cuigaosheng1@huawei.com>
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 81CE44210D9
	for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2022 09:59:10 +0200 (CEST)
To: Jens Axboe <axboe@kernel.dk>, <philipp.reisner@linbit.com>,
	<lars.ellenberg@linbit.com>, <christoph.boehmwalder@linbit.com>
References: <20220911092645.3218009-1-cuigaosheng1@huawei.com>
	<1b305cd1-90a2-e881-5b15-bb05b470c7c4@kernel.dk>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <299c2cf9-f46f-3d53-e4b1-1064e55ebcf9@huawei.com>
Date: Mon, 12 Sep 2022 15:59:07 +0800
MIME-Version: 1.0
In-Reply-To: <1b305cd1-90a2-e881-5b15-bb05b470c7c4@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block/drbd: remove unused w_start_resync
	declaration
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


> Applied, but please also cc linux-block or other lists that manage
> kernel patches in the future. You can't use lore/b4/lei with patches
> that are only on some driver private list.

Thanks,I will cc other list that manage kernel patches in the future.

在 2022/9/12 15:48, Jens Axboe 写道:
> On 9/11/22 3:26 AM, Gaosheng Cui wrote:
>> w_start_resync has been removed since
>> commit ac0acb9e39ac ("drbd: use drbd_device_post_work()
>> in more places"), so remove it.
> Applied, but please also cc linux-block or other lists that manage
> kernel patches in the future. You can't use lore/b4/lei with patches
> that are only on some driver private list.
>
