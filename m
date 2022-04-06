Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com
	[209.85.166.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 15C18420FDD
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 21:08:53 +0200 (CEST)
Received: by mail-io1-f44.google.com with SMTP id p21so4169846ioj.4
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 12:08:53 -0700 (PDT)
Message-ID: <9b6492fd-8367-a9f7-b2c4-1d8853cb7a77@kernel.dk>
Date: Wed, 6 Apr 2022 13:08:51 -0600
MIME-Version: 1.0
Content-Language: en-US
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/3] DRBD fixes for Linux 5.18
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

On 4/6/22 1:04 PM, Christoph Böhmwalder wrote:
> Assortment of more relevant fixes for DRBD to go into 5.18.
> 
> Christoph Böhmwalder (1):
>   drbd: set QUEUE_FLAG_STABLE_WRITES
> 
> Lv Yunlong (1):
>   drbd: Fix five use after free bugs in get_initial_state
> 
> Xiaomeng Tong (1):
>   drbd: fix an invalid memory access caused by incorrect use of list
>     iterator
> 
>  drivers/block/drbd/drbd_int.h          |  8 ++---
>  drivers/block/drbd/drbd_main.c         |  7 ++---
>  drivers/block/drbd/drbd_nl.c           | 41 ++++++++++++++++----------
>  drivers/block/drbd/drbd_state.c        | 18 +++++------
>  drivers/block/drbd/drbd_state_change.h |  8 ++---
>  5 files changed, 45 insertions(+), 37 deletions(-)

Applied, thanks.

-- 
Jens Axboe

