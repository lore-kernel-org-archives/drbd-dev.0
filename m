Return-Path: <axboe@kernel.dk>
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5C9F5421741
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2022 09:49:03 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id b5so13925497wrr.5
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2022 00:49:03 -0700 (PDT)
Message-ID: <1b305cd1-90a2-e881-5b15-bb05b470c7c4@kernel.dk>
Date: Mon, 12 Sep 2022 01:48:55 -0600
MIME-Version: 1.0
To: Gaosheng Cui <cuigaosheng1@huawei.com>, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com
References: <20220911092645.3218009-1-cuigaosheng1@huawei.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220911092645.3218009-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/11/22 3:26 AM, Gaosheng Cui wrote:
> w_start_resync has been removed since
> commit ac0acb9e39ac ("drbd: use drbd_device_post_work()
> in more places"), so remove it.

Applied, but please also cc linux-block or other lists that manage
kernel patches in the future. You can't use lore/b4/lei with patches
that are only on some driver private list.

-- 
Jens Axboe
