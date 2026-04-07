Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
	[209.85.128.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D99A9160849
	for <drbd-dev@lists.linbit.com>; Tue,  7 Apr 2026 13:03:16 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
	5b1f17b1804b1-4888375f735so44526055e9.3
	for <drbd-dev@lists.linbit.com>; Tue, 07 Apr 2026 04:03:16 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:03:14 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: David Carlier <devnexen@gmail.com>
Subject: Re: [PATCH v3] drbd: use get_random_u64() where appropriate
Message-ID: <adTj5DBxjUjVkx82@localhost.localdomain>
References: <20260405154704.4610-1-devnexen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260405154704.4610-1-devnexen@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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

On Sun, Apr 05, 2026 at 04:47:04PM +0100, David Carlier wrote:
>Use the typed random integer helpers instead of
>get_random_bytes() when filling a single integer variable.
>The helpers return the value directly, require no pointer
>or size argument, and better express intent.
>
>Signed-off-by: David Carlier <devnexen@gmail.com>
>---
> drivers/block/drbd/drbd_main.c | 4 ++--
> drivers/block/drbd/drbd_nl.c   | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)

Maybe I just missed it, but v1 and v2 of this don't seem to exist?
Anyway, the patch itself looks good, thanks.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
