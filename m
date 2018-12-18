Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 66914101AC67
	for <drbd-dev@lists.linbit.com>; Tue, 18 Dec 2018 10:27:16 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id g67so1983086wmd.2
	for <drbd-dev@lists.linbit.com>; Tue, 18 Dec 2018 01:27:16 -0800 (PST)
Date: Tue, 18 Dec 2018 10:22:02 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <20181218092202.GJ5026@soda.linbit>
References: <20181002171447.10765-1-natechancellor@gmail.com>
	<20181004200912.32348-1-natechancellor@gmail.com>
	<20181217172401.GA30635@flashbox>
	<0110d874-7595-1786-77e3-e2b0daec2327@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0110d874-7595-1786-77e3-e2b0daec2327@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2] drbd: Avoid Clang warning about pointless
 switch statment
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

On Mon, Dec 17, 2018 at 10:29:38AM -0700, Jens Axboe wrote:
> > Hi Lars and Philipp,
> > 
> > Could you please make sure that this patch and the other one I sent make
> > it into 4.21/5.0? I am not sure when you were planning on sending the
> > pull request to Jens that you mentioned in the other thread but I've
> > noticed most maintainers typically send their requests for the impending
> > merge window around -rc7 or so and I wanted to make sure it was on your
> > radar.

I'm sorry.
From my point of view, "fixing the pointless switch" is just "pointless",
so it (again) fell through.  I get it that it is important to others,
and getting rid of Clang warnings is a good thing.  So sorry again.

> It needs to get here now, but drbd hasn't really sent anything in for
> about a year,

Last actual fix was 2018-06-25 64dafbc9530c drbd: fix access after free
so almost six month, yes.

> so I'm starting to doubt how maintained it is at this
> point.

Oh, it is maintained.  It is just happens to be "stable".
We don't add new features there,
and I'm currently not aware of any misbehavior.

I'll prepare a pull request containing this,
the other Clang warning patch from Nathan,
and possibly other small stuff that accumulated,
if I can find any, and send that out later today.

Thanks for the reminder,

    Lars

