Return-Path: <axboe@kernel.dk>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4584F4202F6
	for <drbd-dev@lists.linbit.com>; Thu, 28 Nov 2019 18:49:16 +0100 (CET)
Received: by mail-pg1-f195.google.com with SMTP id e6so13176514pgi.11
	for <drbd-dev@lists.linbit.com>; Thu, 28 Nov 2019 09:49:16 -0800 (PST)
To: zhengbin <zhengbin13@huawei.com>, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org
References: <1574910572-42062-1-git-send-email-zhengbin13@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <32174dcc-ada8-ba8e-b000-47ed8e4c725e@kernel.dk>
Date: Thu, 28 Nov 2019 09:41:43 -0800
MIME-Version: 1.0
In-Reply-To: <1574910572-42062-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [PATCH 0/3] drivers/block: Remove unneeded semicolon
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

On 11/27/19 7:09 PM, zhengbin wrote:
> zhengbin (3):
>    drbd: Remove unneeded semicolon
>    block: sunvdc: Remove unneeded semicolon
>    ataflop: Remove unneeded semicolon
> 
>   drivers/block/ataflop.c       | 2 +-
>   drivers/block/drbd/drbd_req.c | 2 +-
>   drivers/block/sunvdc.c        | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Jens Axboe

