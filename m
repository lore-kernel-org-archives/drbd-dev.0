Return-Path: <axboe@kernel.dk>
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com
	[209.85.166.176])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 39056160923
	for <drbd-dev@lists.linbit.com>; Tue, 18 Nov 2025 16:38:44 +0100 (CET)
Received: by mail-il1-f176.google.com with SMTP id
	e9e14a558f8ab-43377ee4825so28110305ab.2
	for <drbd-dev@lists.linbit.com>; Tue, 18 Nov 2025 07:38:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sukrut Heroorkar <hsukrut3@gmail.com>
In-Reply-To: <20251118090753.390818-1-hsukrut3@gmail.com>
References: <20251118090753.390818-1-hsukrut3@gmail.com>
Subject: Re: [PATCH] drbd: turn bitmap I/O comments into regular block comments
Message-Id: <176348032225.300553.3972505243693659876.b4-ty@kernel.dk>
Date: Tue, 18 Nov 2025 08:38:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Tue, 18 Nov 2025 14:37:53 +0530, Sukrut Heroorkar wrote:
> W=1 build warns because the bitmap I/O comments use '/**', which
> marks them as kernel-doc comments even though these functions do not
> document an external API.
> 
> Convert these comments to regular block comments so kernel-doc no
> longer parses them.
> 
> [...]

Applied, thanks!

[1/1] drbd: turn bitmap I/O comments into regular block comments
      commit: 2c6d792d4b7676e2b340df05425330452fee1f40

Best regards,
-- 
Jens Axboe



