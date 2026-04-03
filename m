Return-Path: <axboe@kernel.dk>
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
	[209.85.167.174])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B3913160871
	for <drbd-dev@lists.linbit.com>; Fri,  3 Apr 2026 03:30:38 +0200 (CEST)
Received: by mail-oi1-f174.google.com with SMTP id
	5614622812f47-4670464029eso890480b6e.2
	for <drbd-dev@lists.linbit.com>; Thu, 02 Apr 2026 18:30:38 -0700 (PDT)
Message-ID: <ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
Date: Thu, 2 Apr 2026 19:30:35 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 00/20] DRBD 9 rework
To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
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

On 3/27/26 4:38 PM, Christoph Böhmwalder wrote:
> As discussed (context: [0]), here is the first version of our DRBD 9
> rework series, intended for for-next via for-7.1/drbd.

Will you fixup the kerneldoc (nits) and the assigned-but-not-read
issues and send out a new version? Also looks this series doesn't
actually apply to for-7.1/block, patch 12 fails.

-- 
Jens Axboe

