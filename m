Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
	[209.85.216.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8FF45422112
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2022 20:47:02 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id l6so17712420pjj.0
	for <drbd-dev@lists.linbit.com>; Wed, 09 Nov 2022 11:47:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
References: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
Message-Id: <166802322035.66062.9382027641082128277.b4-ty@kernel.dk>
Date: Wed, 09 Nov 2022 12:47:00 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] [PATCH 0/3] Miscellaneous DRBD updates for 6.2
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

On Wed, 9 Nov 2022 14:34:50 +0100, Christoph Böhmwalder wrote:
> Here are some various updates for DRBD.
> The first two are related to the handling of discards in DRBD, and the
> third is a resend of [0].
> 
> [0] https://lore.kernel.org/all/20221024142424.25877-1-christoph.boehmwalder@linbit.com/
> 
> Christoph Böhmwalder (2):
>   drbd: use blk_queue_max_discard_sectors helper
>   drbd: Store op in drbd_peer_request
> 
> [...]

Applied, thanks!

[1/3] drbd: use blk_queue_max_discard_sectors helper
      commit: 258bea6388ac93f34561fd91064232d14e174bff
[2/3] drbd: disable discard support if granularity > max
      commit: 21b87a7d7564751590e3a38dfb243f9a0bbedbd2
[3/3] drbd: Store op in drbd_peer_request
      commit: ce668b6d68f9ddf76022b1c403b444f5a21cbc0f

Best regards,
-- 
Jens Axboe


