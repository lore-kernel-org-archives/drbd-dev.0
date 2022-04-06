Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
	[209.85.216.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E3A9C420FD0
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 14:35:43 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
	ku13-20020a17090b218d00b001ca8fcd3adeso5627291pjb.2
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 05:35:43 -0700 (PDT)
Message-ID: <e2035fff-01e2-0df7-2508-82b741615519@kernel.dk>
Date: Wed, 6 Apr 2022 06:35:40 -0600
MIME-Version: 1.0
Content-Language: en-US
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <60bf3e8f-9cfb-00d1-5fea-71a72ba93258@linbit.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <60bf3e8f-9cfb-00d1-5fea-71a72ba93258@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD fixes for Linux 5.18
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

On 4/6/22 2:06 AM, Christoph B?hmwalder wrote:
> Hi Jens,
> 
> this is the first batch of DRBD updates, catching up from the last few
> years. These fixes are a bit more substantial, so it would be great if
> they could still go into 5.18.

Thanks for sending these, but you based the repo on my 5.19 branch,
which won't work as pulling your tree will then result in me getting
your 5.18 changes with my 5.19 as well.

As it happens, this is also a problem for your 5.19 based changes. My
for-next branch is not stable, just like linux-next isn't stable. In
terms of shas, not how it runs...

In general, for the block tree, here's what you want to base the changes
on, using 5.18/5.19 as examples as current/next tree.

- If they are bound for 5.18, base them on block-5.18. That branch may
  not exist if nothing is queued up yet, in which case just base them on
  the last -rc1 tag for that series. That'd be 5.18-rc1 in this case.

- If they are bound for 5.19, usually I will have a 5.19 driver and core
  block branch. Base them against for-5.19/drivers. If it doesn't exist,
  previous -rc is a good choice again.

Usually post -rc2 all of the above branches will exist, during merge
window and right after things are a bit more influx and haven't really
settled down yet.

Now, there's also the fact that you're using a non kernel.org git tree.
That's fine, but ideally we'd like you to use signed tags in that case.
But not sure your key has been signed by anyone in the korg ring of
trust? Since I've already seen these patches this isn't a huge concern
for now, but something to get sorted out going forward.

Can you rebase your two pull requests and send them in again? Either
that, or just git send-email the two series, that'll work too. I'm fine
applying series from maintainers like that, it doesn't have to be a git
pull request.

-- 
Jens Axboe

