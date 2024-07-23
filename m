Return-Path: <axboe@kernel.dk>
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
	[209.85.215.176])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 99EED420657
	for <drbd-dev@lists.linbit.com>; Tue, 23 Jul 2024 15:31:54 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
	41be03b00d2f7-6c386a3ac43so70051a12.0
	for <drbd-dev@lists.linbit.com>; Tue, 23 Jul 2024 06:31:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Simon Horman <horms@kernel.org>
In-Reply-To: <20240723-drbd-doc-v1-1-a04d9b7a9688@kernel.org>
References: <20240723-drbd-doc-v1-1-a04d9b7a9688@kernel.org>
Subject: Re: [PATCH] drbd: Add peer_device to Kernel doc
Message-Id: <172174151190.171540.3359811072031639762.b4-ty@kernel.dk>
Date: Tue, 23 Jul 2024 07:31:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, Andreas Gruenbacher <agruen@kernel.org>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
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


On Tue, 23 Jul 2024 10:41:52 +0100, Simon Horman wrote:
> Add missing documentation of peer_device parameter to Kernel doc.
> 
> These parameters were added in commit 8164dd6c8ae1 ("drbd: Add peer
> device parameter to whole-bitmap I/O handlers")
> 
> Flagged by W=1 builds.
> 
> [...]

Applied, thanks!

[1/1] drbd: Add peer_device to Kernel doc
      commit: b8a4518b5c2d1164f9bb2e586733a658c5239adf

Best regards,
-- 
Jens Axboe



