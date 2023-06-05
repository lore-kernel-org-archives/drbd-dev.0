Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
	[209.85.216.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A84424203B3
	for <drbd-dev@lists.linbit.com>; Mon,  5 Jun 2023 19:22:02 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
	98e67ed59e1d1-256918803baso1030181a91.1
	for <drbd-dev@lists.linbit.com>; Mon, 05 Jun 2023 10:22:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20230601151646.1386867-1-hch@lst.de>
References: <20230601151646.1386867-1-hch@lst.de>
Message-Id: <168598571992.2504.2085169404981858004.b4-ty@kernel.dk>
Date: Mon, 05 Jun 2023 11:21:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, drbd-dev@lists.linbit.com
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


On Thu, 01 Jun 2023 17:16:46 +0200, Christoph Hellwig wrote:
> __KERNEL_SYSCALLS__ hasn't been needed since Linux 2.6.19 so stop
> defining it.
> 
> 

Applied, thanks!

[1/1] drbd: stop defining __KERNEL_SYSCALLS__
      commit: d519df00938eed652fc041ff4e07b2b38a4ad3bc

Best regards,
-- 
Jens Axboe



