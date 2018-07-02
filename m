Return-Path: <axboe@kernel.dk>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
	[209.85.223.194])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5723B1013806
	for <drbd-dev@lists.linbit.com>; Mon,  2 Jul 2018 23:11:07 +0200 (CEST)
Received: by mail-io0-f194.google.com with SMTP id q19-v6so8583246ioh.11
	for <drbd-dev@lists.linbit.com>; Mon, 02 Jul 2018 14:11:07 -0700 (PDT)
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20180702174902.GA18713@embeddedor.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d776672f-3173-037e-81fc-5c2619177682@kernel.dk>
Date: Mon, 2 Jul 2018 15:11:03 -0600
MIME-Version: 1.0
In-Reply-To: <20180702174902.GA18713@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: mark expected switch fall-throughs
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 7/2/18 11:49 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Warning level 2 was used in this case: -Wimplicit-fallthrough=2

Applied, thanks.

-- 
Jens Axboe

