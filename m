Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
	[209.85.128.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AEF2E420632
	for <drbd-dev@lists.linbit.com>; Mon,  5 Jun 2023 11:30:13 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
	5b1f17b1804b1-3f6e4554453so40103465e9.3
	for <drbd-dev@lists.linbit.com>; Mon, 05 Jun 2023 02:30:13 -0700 (PDT)
Message-ID: <2135eb9d-b673-1a0d-6698-d73de60fa00d@linbit.com>
Date: Mon, 5 Jun 2023 11:29:11 +0200
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
References: <20230601151646.1386867-1-hch@lst.de>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20230601151646.1386867-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: stop defining __KERNEL_SYSCALLS__
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

Am 01.06.23 um 17:16 schrieb Christoph Hellwig:
> __KERNEL_SYSCALLS__ hasn't been needed since Linux 2.6.19 so stop
> defining it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_main.c     | 1 -
>  drivers/block/drbd/drbd_receiver.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 83987e7a5ef275..54223f64610a05 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -37,7 +37,6 @@
>  #include <linux/notifier.h>
>  #include <linux/kthread.h>
>  #include <linux/workqueue.h>
> -#define __KERNEL_SYSCALLS__
>  #include <linux/unistd.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/signal.h>
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 8c2bc47de4735e..0c9f54197768d6 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -27,7 +27,6 @@
>  #include <uapi/linux/sched/types.h>
>  #include <linux/sched/signal.h>
>  #include <linux/pkt_sched.h>
> -#define __KERNEL_SYSCALLS__
>  #include <linux/unistd.h>
>  #include <linux/vmalloc.h>
>  #include <linux/random.h>

Looks right.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
