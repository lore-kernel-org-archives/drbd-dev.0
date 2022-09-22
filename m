Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
	[209.85.216.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2BC754210D5
	for <drbd-dev@lists.linbit.com>; Thu, 22 Sep 2022 03:45:25 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
	x1-20020a17090ab00100b001fda21bbc90so662969pjq.3
	for <drbd-dev@lists.linbit.com>; Wed, 21 Sep 2022 18:45:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
	Gaosheng Cui <cuigaosheng1@huawei.com>, philipp.reisner@linbit.com
In-Reply-To: <20220920015216.782190-1-cuigaosheng1@huawei.com>
References: <20220920015216.782190-1-cuigaosheng1@huawei.com>
Message-Id: <166381112404.39678.3870348207045502610.b4-ty@kernel.dk>
Date: Wed, 21 Sep 2022 19:45:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/2] Remove orphan declarations for drbd
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

On Tue, 20 Sep 2022 09:52:14 +0800, Gaosheng Cui wrote:
> This series contains a few cleanup patches, to remove a orphan
> declaration which has been removed and some useless comments. Thanks!
> 
> Gaosheng Cui (2):
>   drbd: remove orphan _req_may_be_done() declaration
>   block/drbd: remove useless comments in receive_DataReply()
> 
> [...]

Applied, thanks!

[1/2] drbd: remove orphan _req_may_be_done() declaration
      commit: a437df5f8bbc6b52231bbeaef8b4052698c9007a
[2/2] block/drbd: remove useless comments in receive_DataReply()
      commit: 7f0c1afeacfcb4c32173b5a120ec0a362b79bd71

Best regards,
-- 
Jens Axboe


