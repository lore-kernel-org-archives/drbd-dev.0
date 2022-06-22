Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
	[209.85.216.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 10CE9420471
	for <drbd-dev@lists.linbit.com>; Thu, 23 Jun 2022 00:33:12 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
	h34-20020a17090a29a500b001eb01527d9eso792405pjd.3
	for <drbd-dev@lists.linbit.com>; Wed, 22 Jun 2022 15:33:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: christoph.boehmwalder@linbit.com
In-Reply-To: <20220622204932.196830-1-christoph.boehmwalder@linbit.com>
References: <20220622204932.196830-1-christoph.boehmwalder@linbit.com>
Message-Id: <165593719059.163762.1120892404181433441.b4-ty@kernel.dk>
Date: Wed, 22 Jun 2022 16:33:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, lars.ellenberg@linbit.com,
	philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: bm_page_async_io: fix spurious bitmap
	"IO error" on large volumes
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

On Wed, 22 Jun 2022 22:49:32 +0200, Christoph Böhmwalder wrote:
> From: Lars Ellenberg <lars.ellenberg@linbit.com>
> 
> We usually do all our bitmap IO in units of PAGE_SIZE.
> 
> With very small or oddly sized external meta data, or with
> PAGE_SIZE != 4k, it can happen that our last on-disk bitmap page
> is not fully PAGE_SIZE aligned, so we may need to adjust the size
> of the IO.
> 
> [...]

Applied, thanks!

[1/1] drbd: bm_page_async_io: fix spurious bitmap "IO error" on large volumes
      commit: 66923326b519bbc4ebcb5275645b58427f801824

Best regards,
-- 
Jens Axboe


