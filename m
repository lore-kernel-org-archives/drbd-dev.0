Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
	[209.85.128.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F2D7C160922
	for <drbd-dev@lists.linbit.com>; Thu, 19 Feb 2026 15:32:25 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
	5b1f17b1804b1-480706554beso11638045e9.1
	for <drbd-dev@lists.linbit.com>; Thu, 19 Feb 2026 06:32:25 -0800 (PST)
Message-ID: <432b20cd-9ef0-4335-b8da-425d9a441c34@linbit.com>
Date: Thu, 19 Feb 2026 15:32:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drbd: Replace deprecated strcpy with strscpy
To: Thorsten Blum <thorsten.blum@linux.dev>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
References: <20260112170412.741013-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260112170412.741013-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/12/26 18:04, Thorsten Blum wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  No functional changes.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/block/drbd/drbd_main.c     | 14 +++++++++-----
>   drivers/block/drbd/drbd_receiver.c |  4 ++--
>   2 files changed, 11 insertions(+), 7 deletions(-)

Looks good, thanks.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
