Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 878FE105627D
	for <drbd-dev@lists.linbit.com>; Wed, 24 Aug 2011 20:25:50 +0200 (CEST)
Resent-Message-ID: <20110824182550.GH14479@barkeeper1-xen.linbit>
Received: from mail-yw0-f54.google.com (mail-yw0-f54.google.com
	[209.85.213.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 91E94105627D
	for <drbd-dev@lists.linbit.com>; Wed, 24 Aug 2011 20:23:43 +0200 (CEST)
Received: by ywo32 with SMTP id 32so1599699ywo.27
	for <drbd-dev@lists.linbit.com>; Wed, 24 Aug 2011 11:23:40 -0700 (PDT)
MIME-Version: 1.0
Sender: penberg@gmail.com
In-Reply-To: <4E553ABF.3030904@kernel.dk>
References: <201108241641.42676.philipp.reisner@linbit.com>
	<CAGZ=bq+A1ExZYRnuBBwfAq7Ez37mpBtT1_T91AWcchDBZ3iqPw@mail.gmail.com>
	<4E552E9C.2000104@kernel.dk>
	<201108241949.43716.philipp.reisner@linbit.com>
	<4E553ABF.3030904@kernel.dk>
Date: Wed, 24 Aug 2011 21:16:02 +0300
Message-ID: <CAOJsxLHNeZq-kOy2UorOTia7AO3UmfpaWm6gfx3WeW7J6F4hEw@mail.gmail.com>
From: Pekka Enberg <penberg@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kyle Moffett <kyle@moffetthome.net>, drbd-dev@lists.linbit.com,
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

On Wed, Aug 24, 2011 at 8:54 PM, Jens Axboe <axboe@kernel.dk> wrote:
> So, please do this right. The email you sent is perfect for a 0/N header
> email, then each patch must follow as a reply to that. There's git
> send-email to help you with this. If you haven't used it before, I'd
> advise you to do a dry-run or two to your own email address to ensure
> that it produces the right result. When it does, then send it off to
> lkml and myself. Then I too will see reviews and have a better chance of
> judging whether this is mergeable now or not.

Another thing: there's roughly 500 commit in the pull request. Please
don't send all of them at the same time if you want people to take a
look at them.
