Return-Path: <axboe@kernel.dk>
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
	[209.85.160.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1BC321627C2
	for <drbd-dev@lists.linbit.com>; Tue,  7 Apr 2026 14:27:56 +0200 (CEST)
Received: by mail-oa1-f53.google.com with SMTP id
	586e51a60fabf-40ee9b945d5so4042983fac.0
	for <drbd-dev@lists.linbit.com>; Tue, 07 Apr 2026 05:27:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	David Carlier <devnexen@gmail.com>
In-Reply-To: <20260405154704.4610-1-devnexen@gmail.com>
References: <20260405154704.4610-1-devnexen@gmail.com>
Subject: Re: [PATCH v3] drbd: use get_random_u64() where appropriate
Message-Id: <177556487454.160102.7876439561425068141.b4-ty@b4>
Date: Tue, 07 Apr 2026 06:27:54 -0600
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


On Sun, 05 Apr 2026 16:47:04 +0100, David Carlier wrote:
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.

Applied, thanks!

[1/1] drbd: use get_random_u64() where appropriate
      commit: fa0cac9a515877fad856c860ad51107b86ed6c4f

Best regards,
-- 
Jens Axboe



