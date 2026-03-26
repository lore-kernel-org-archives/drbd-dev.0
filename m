Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
	[209.85.128.48])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6E38B160878
	for <drbd-dev@lists.linbit.com>; Thu, 26 Mar 2026 15:25:58 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
	5b1f17b1804b1-48538c5956bso9387845e9.0
	for <drbd-dev@lists.linbit.com>; Thu, 26 Mar 2026 07:25:58 -0700 (PDT)
Message-ID: <d7c66265-5df2-40c9-830e-57df5924b271@linbit.com>
Date: Thu, 26 Mar 2026 15:25:53 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] drbd: A few bug fixes
To: Ethan Tidmore <ethantidmore06@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
References: <20260317232318.18923-1-ethantidmore06@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260317232318.18923-1-ethantidmore06@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
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

On 3/18/26 00:23, Ethan Tidmore wrote:
> Here are 4 bug fixes found with Smatch.
> 
> Ethan Tidmore (4):
>    drbd: Fix out-of-bounds access
>    drbd: Fix variable dereference before check
>    drbd: Add missing error code in drbd_main.c
>    drbd: Add check for error pointer
> 
>   drivers/block/drbd/drbd_main.c     | 1 +
>   drivers/block/drbd/drbd_nl.c       | 2 +-
>   drivers/block/drbd/drbd_receiver.c | 2 +-
>   drivers/block/drbd/drbd_req.c      | 4 +++-
>   4 files changed, 6 insertions(+), 3 deletions(-)
> 

Thanks, these all look good.
I'll squash them into the DRDB9 series to keep the history clean.

Regards,
Christoph
