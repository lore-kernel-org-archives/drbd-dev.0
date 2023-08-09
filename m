Return-Path: <ruanjinjie@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5CB8A42019F
	for <drbd-dev@lists.linbit.com>;
	Wed,  9 Aug 2023 03:32:11 +0200 (CEST)
Message-ID: <ee32b802-91a8-f7a8-cf2a-e17de1aef9a9@huawei.com>
Date: Wed, 9 Aug 2023 09:32:08 +0800
MIME-Version: 1.0
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <20230808090111.2420717-1-ruanjinjie@huawei.com>
	<5e560155-b2a4-e5bd-d22e-0e44a5a85f43@kernel.dk>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <5e560155-b2a4-e5bd-d22e-0e44a5a85f43@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Drbd-dev] [PATCH -next] drbd: Use helper put_drbd_dev() and
	get_drbd_dev()
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



On 2023/8/9 1:36, Jens Axboe wrote:
> On 8/8/23 3:01 AM, Ruan Jinjie wrote:
>> The drbd_destroy_device() arg of this code is already duplicated
>> 18 times, use helper function put_drbd_dev() to release drbd_device
>> and related resources instead of open coding it to help improve
>> code readability a bit.
>>
>> And add get_drbd_dev() helper function to be symmetrical with it.
>>
>> No functional change involved.
> 
> IMHO this just makes the code harder to read. You're not adding a
> helper, all it does is call the same get/put parts. Why not just keep
> it as-is then?

Sorry, I misunderstood the meaning of a helper.I'll learn more about
what other helper patches are doing. It's okay to keep it as it is.

> 
