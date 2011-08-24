Return-Path: <kyle@moffetthome.net>
Received: from mail-wy0-f182.google.com (mail-wy0-f182.google.com
	[74.125.82.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6F2651055FBC
	for <drbd-dev@lists.linbit.com>; Wed, 24 Aug 2011 21:32:47 +0200 (CEST)
Received: by wyh15 with SMTP id 15so2016125wyh.27
	for <drbd-dev@lists.linbit.com>; Wed, 24 Aug 2011 12:32:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOJsxLHNeZq-kOy2UorOTia7AO3UmfpaWm6gfx3WeW7J6F4hEw@mail.gmail.com>
References: <201108241641.42676.philipp.reisner@linbit.com>
	<CAGZ=bq+A1ExZYRnuBBwfAq7Ez37mpBtT1_T91AWcchDBZ3iqPw@mail.gmail.com>
	<4E552E9C.2000104@kernel.dk>
	<201108241949.43716.philipp.reisner@linbit.com>
	<4E553ABF.3030904@kernel.dk>
	<CAOJsxLHNeZq-kOy2UorOTia7AO3UmfpaWm6gfx3WeW7J6F4hEw@mail.gmail.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Wed, 24 Aug 2011 15:32:26 -0400
Message-ID: <CAGZ=bqLhcjzPDdb8mkGf5MbwqjrA_3ETLDe9Xiv-Wq2GnTgaUw@mail.gmail.com>
To: Pekka Enberg <penberg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org
Subject: Re: [Drbd-dev] [GIT PULL] drbd-8.4 for mainline
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 24, 2011 at 14:16, Pekka Enberg <penberg@kernel.org> wrote:
> On Wed, Aug 24, 2011 at 8:54 PM, Jens Axboe <axboe@kernel.dk> wrote:
>> So, please do this right. The email you sent is perfect for a 0/N header
>> email, then each patch must follow as a reply to that. There's git
>> send-email to help you with this. If you haven't used it before, I'd
>> advise you to do a dry-run or two to your own email address to ensure
>> that it produces the right result. When it does, then send it off to
>> lkml and myself. Then I too will see reviews and have a better chance of
>> judging whether this is mergeable now or not.
>
> Another thing: there's roughly 500 commit in the pull request. Please
> don't send all of them at the same time if you want people to take a
> look at them.

Clearly you've been developing DRBD 8.4 for quite a while; it will save you
a lot of time overall in the future to submit patches as soon as you have
each one ready for review.

You should be merging functional and code improvements continuously
into every release window, instead of batching them up and submitting
500 at a time.

Cheers,
Kyle Moffett
