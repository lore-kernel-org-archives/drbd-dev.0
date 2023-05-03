Return-Path: <axboe@kernel.dk>
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
	[209.85.166.169])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 401A94203AB
	for <drbd-dev@lists.linbit.com>; Wed,  3 May 2023 17:39:51 +0200 (CEST)
Received: by mail-il1-f169.google.com with SMTP id
	e9e14a558f8ab-33110a36153so693555ab.0
	for <drbd-dev@lists.linbit.com>; Wed, 03 May 2023 08:39:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20230503121937.17232-1-christoph.boehmwalder@linbit.com>
References: <20230503121937.17232-1-christoph.boehmwalder@linbit.com>
Message-Id: <168312838868.941317.975898202413701616.b4-ty@kernel.dk>
Date: Wed, 03 May 2023 09:39:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Christoph Hellwig <hch@infradead.org>, Thomas Voegtle <tv@lio96.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: correctly submit flush bio on barrier
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


On Wed, 03 May 2023 14:19:37 +0200, Christoph Böhmwalder wrote:
> When we receive a flush command (or "barrier" in DRBD), we currently use
> a REQ_OP_FLUSH with the REQ_PREFLUSH flag set.
> 
> The correct way to submit a flush bio is by using a REQ_OP_WRITE without
> any data, and set the REQ_PREFLUSH flag.
> 
> Since commit b4a6bb3a67aa ("block: add a sanity check for non-write
> flush/fua bios"), this triggers a warning in the block layer, but this
> has been broken for quite some time before that.
> 
> [...]

Applied, thanks!

[1/1] drbd: correctly submit flush bio on barrier
      commit: 3899d94e3831ee07ea6821c032dc297aec80586a

Best regards,
-- 
Jens Axboe



