Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
	[209.85.208.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BD159162276
	for <drbd-dev@lists.linbit.com>; Tue, 18 Nov 2025 11:51:04 +0100 (CET)
Received: by mail-ed1-f50.google.com with SMTP id
	4fb4d7f45d1cf-64175dfc338so10022409a12.0
	for <drbd-dev@lists.linbit.com>; Tue, 18 Nov 2025 02:51:04 -0800 (PST)
Message-ID: <11f8aaaa-b5de-44dc-9263-5bdb506923ac@linbit.com>
Date: Tue, 18 Nov 2025 11:51:02 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drbd: turn bitmap I/O comments into regular block comments
To: Sukrut Heroorkar <hsukrut3@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20251118090753.390818-1-hsukrut3@gmail.com>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20251118090753.390818-1-hsukrut3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: shuah@kernel.org, david.hunter.linux@gmail.com
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

Am 18.11.25 um 10:07 schrieb Sukrut Heroorkar:
> W=1 build warns because the bitmap I/O comments use '/**', which
> marks them as kernel-doc comments even though these functions do not
> document an external API.
> 
> Convert these comments to regular block comments so kernel-doc no
> longer parses them.
> 
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> ---
> See: https://lore.kernel.org/all/20251117172557.355797-1-hsukrut3@gmail.com/t/
> 
>  drivers/block/drbd/drbd_bitmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thanks.

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

