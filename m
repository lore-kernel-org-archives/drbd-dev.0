Return-Path: <ard@kwaak.net>
Received: from mail.kwaak.net (gw-cistron.kwaak.net [62.216.22.210])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1D7762D9EA8A
	for <drbd-dev@lists.linbit.com>; Fri, 26 Jan 2007 15:42:52 +0100 (CET)
Received: from ard by mail.kwaak.net with local (Exim 4.50) id 1HAS9X-0008CZ-0m
	for drbd-dev@lists.linbit.com; Fri, 26 Jan 2007 15:34:07 +0100
Date: Fri, 26 Jan 2007 15:34:07 +0100
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] oopses in 2.6.19.1
Message-ID: <20070126143407.GF9639@kwaak.net>
References: <20070110123116.GX15730@kwaak.net>
	<20070111171205.GC15730@kwaak.net>
	<20070111180322.GD15730@kwaak.net>
	<200701151806.20526.philipp.reisner@linbit.com>
	<20070116103749.GD9639@kwaak.net> <20070125174523.GD9639@kwaak.net>
	<20070125213210.GK7738@soda.linbit>
	<20070126142857.GE9639@kwaak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070126142857.GE9639@kwaak.net>
From: Ard van Breemen <ard@kwaak.net>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jan 26, 2007 at 03:28:57PM +0100,  wrote:
> > second, there is drbd 8.0.0 already.
> > though, there have not been any interesting changes in this area since revision 2695,
> > which you apparently use.
> Allright, I will try it again :-)
> now At revision 2715.
Just to make sure: Although the banner says 2695, it really is
2715 according to svn.
I always forget to make drbd/drbd_buildtag.c
(Which currently insist on being 2713 )

Anyway: on to the next test ;-)
