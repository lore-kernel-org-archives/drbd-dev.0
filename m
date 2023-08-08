Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com
	[209.85.166.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 375F042032F
	for <drbd-dev@lists.linbit.com>; Tue,  8 Aug 2023 19:36:53 +0200 (CEST)
Received: by mail-io1-f43.google.com with SMTP id
	ca18e2360f4ac-790b9d7d643so69338339f.1
	for <drbd-dev@lists.linbit.com>; Tue, 08 Aug 2023 10:36:53 -0700 (PDT)
Message-ID: <5e560155-b2a4-e5bd-d22e-0e44a5a85f43@kernel.dk>
Date: Tue, 8 Aug 2023 11:36:51 -0600
MIME-Version: 1.0
Content-Language: en-US
To: Ruan Jinjie <ruanjinjie@huawei.com>, linux-block@vger.kernel.org,
	drbd-dev@lists.linbit.com, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <20230808090111.2420717-1-ruanjinjie@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230808090111.2420717-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
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

On 8/8/23 3:01 AM, Ruan Jinjie wrote:
> The drbd_destroy_device() arg of this code is already duplicated
> 18 times, use helper function put_drbd_dev() to release drbd_device
> and related resources instead of open coding it to help improve
> code readability a bit.
> 
> And add get_drbd_dev() helper function to be symmetrical with it.
> 
> No functional change involved.

IMHO this just makes the code harder to read. You're not adding a
helper, all it does is call the same get/put parts. Why not just keep
it as-is then?

-- 
Jens Axboe


