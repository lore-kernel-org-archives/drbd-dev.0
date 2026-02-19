Return-Path: <axboe@kernel.dk>
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
	[209.85.161.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3F69016087D
	for <drbd-dev@lists.linbit.com>; Thu, 19 Feb 2026 16:22:22 +0100 (CET)
Received: by mail-oo1-f41.google.com with SMTP id
	006d021491bc7-679aebf4e56so557953eaf.3
	for <drbd-dev@lists.linbit.com>; Thu, 19 Feb 2026 07:22:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20260112170412.741013-2-thorsten.blum@linux.dev>
References: <20260112170412.741013-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] drbd: Replace deprecated strcpy with strscpy
Message-Id: <177151454067.556009.8199495060801939828.b4-ty@kernel.dk>
Date: Thu, 19 Feb 2026 08:22:20 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Mon, 12 Jan 2026 18:04:12 +0100, Thorsten Blum wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  No functional changes.
> 
> 

Applied, thanks!

[1/1] drbd: Replace deprecated strcpy with strscpy
      commit: 81b1f046ff8a5ad5da2c970cff354b61dfa1d6b1

Best regards,
-- 
Jens Axboe



