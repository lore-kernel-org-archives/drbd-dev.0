Return-Path: <axboe@kernel.dk>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
	[209.85.214.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4F7B8101E041
	for <drbd-dev@lists.linbit.com>; Mon,  2 Jul 2018 16:22:56 +0200 (CEST)
Received: by mail-it0-f68.google.com with SMTP id u4-v6so12380883itg.0
	for <drbd-dev@lists.linbit.com>; Mon, 02 Jul 2018 07:22:56 -0700 (PDT)
To: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>
References: <20180625093952.20220-1-lars.ellenberg@linbit.com>
	<20180702112703.GA10994@soda.linbit>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4a49baa0-f1fb-a593-ae11-443c8385494b@kernel.dk>
Date: Mon, 2 Jul 2018 08:22:10 -0600
MIME-Version: 1.0
In-Reply-To: <20180702112703.GA10994@soda.linbit>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [PATCH] drbd: fix access after free
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

On 7/2/18 5:27 AM, Lars Ellenberg wrote:
> Jens, I had hoped you'd apply this "oneliner" into 4.18 already?
> Did you miss it?

I did miss it, applied it now, thanks.

-- 
Jens Axboe

