Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
	[209.85.221.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5AC6E420667
	for <drbd-dev@lists.linbit.com>; Wed, 21 Sep 2022 12:33:26 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id r7so9157090wrm.2
	for <drbd-dev@lists.linbit.com>; Wed, 21 Sep 2022 03:33:26 -0700 (PDT)
Message-ID: <677922df-1674-a872-4bc6-e9c874ee4e46@linbit.com>
Date: Wed, 21 Sep 2022 12:33:23 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Gaosheng Cui <cuigaosheng1@huawei.com>
References: <20220920015216.782190-1-cuigaosheng1@huawei.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220920015216.782190-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, lars.ellenberg@linbit.com,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/2] Remove orphan declarations for drbd
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

Am 20.09.22 um 03:52 schrieb Gaosheng Cui:
> This series contains a few cleanup patches, to remove a orphan
> declaration which has been removed and some useless comments. Thanks!
> 
> Gaosheng Cui (2):
>   drbd: remove orphan _req_may_be_done() declaration
>   block/drbd: remove useless comments in receive_DataReply()
> 
>  drivers/block/drbd/drbd_receiver.c | 3 ---
>  drivers/block/drbd/drbd_req.h      | 2 --
>  2 files changed, 5 deletions(-)
> 

Both patches look good to me, thanks.

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

PS: I think trivial fixes like this are important, but they also create
additional maintenance burden. So if you have more of these in the
future, maybe save them up and submit them all at once (maybe even in a
single patch if they are related). Thanks!

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
