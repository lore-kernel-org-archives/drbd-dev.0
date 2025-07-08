Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com
	[209.85.166.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 86CE116095D
	for <drbd-dev@lists.linbit.com>; Tue,  8 Jul 2025 20:00:17 +0200 (CEST)
Received: by mail-io1-f41.google.com with SMTP id
	ca18e2360f4ac-875ce3c8e24so170593539f.1
	for <drbd-dev@lists.linbit.com>; Tue, 08 Jul 2025 11:00:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20250627095728.800688-1-christoph.boehmwalder@linbit.com>
References: <20250627095728.800688-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: add missing kref_get in handle_write_conflicts
Message-Id: <175199761446.1185853.16712742207654241158.b4-ty@kernel.dk>
Date: Tue, 08 Jul 2025 12:00:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Lars Ellenberg <lars@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sarah Newman <srn@prgmr.com>, Lars Ellenberg <lars.ellenberg@linbit.com>,
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


On Fri, 27 Jun 2025 11:57:28 +0200, Christoph Böhmwalder wrote:
> With `two-primaries` enabled, DRBD tries to detect "concurrent" writes
> and handle write conflicts, so that even if you write to the same sector
> simultaneously on both nodes, they end up with the identical data once
> the writes are completed.
> 
> In handling "superseeded" writes, we forgot a kref_get,
> resulting in a premature drbd_destroy_device and use after free,
> and further to kernel crashes with symptoms.
> 
> [...]

Applied, thanks!

[1/1] drbd: add missing kref_get in handle_write_conflicts
      commit: 00c9c9628b49e368d140cfa61d7df9b8922ec2a8

Best regards,
-- 
Jens Axboe



