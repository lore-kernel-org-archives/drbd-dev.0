Return-Path: <axboe@kernel.dk>
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
	[209.85.210.176])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BDE7E42018E
	for <drbd-dev@lists.linbit.com>; Wed,  6 Sep 2023 15:33:20 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
	d2e1a72fcca58-68a4dab8172so733469b3a.0
	for <drbd-dev@lists.linbit.com>; Wed, 06 Sep 2023 06:33:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20230906133034.948817-1-christoph.boehmwalder@linbit.com>
References: <20230906133034.948817-1-christoph.boehmwalder@linbit.com>
Message-Id: <169400719806.700937.1715411703006180940.b4-ty@kernel.dk>
Date: Wed, 06 Sep 2023 07:33:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: David Howells <dhowells@redhat.com>,
	Serguei Ivantsov <manowar@gsc-game.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Linux regression tracking <regressions@leemhuis.info>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: swap bvec_set_page len and offset
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


On Wed, 06 Sep 2023 15:30:34 +0200, Christoph Böhmwalder wrote:
> bvec_set_page has the following signature:
> 
> static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
> 		unsigned int len, unsigned int offset)
> 
> However, the usage in DRBD swaps the len and offset parameters. This
> leads to a bvec with length=0 instead of the intended length=4096, which
> causes sock_sendmsg to return -EIO.
> 
> [...]

Applied, thanks!

[1/1] drbd: swap bvec_set_page len and offset
      commit: 4b9c2edaf7282d60e069551b4b28abc2932cd3e3

Best regards,
-- 
Jens Axboe



