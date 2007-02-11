Return-Path: <ard@kwaak.net>
Received: from mail.kwaak.net (82-197-200-127.dsl.cambrium.nl [82.197.200.127])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C596F2E05E81
	for <drbd-dev@lists.linbit.com>; Sun, 11 Feb 2007 23:00:15 +0100 (CET)
Received: from ard by mail.kwaak.net with local (Exim 4.50) id 1HGMfu-0008PD-It
	for drbd-dev@lists.linbit.com; Sun, 11 Feb 2007 22:55:58 +0100
Date: Sun, 11 Feb 2007 22:55:58 +0100
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] oopses in 2.6.19.1
Message-ID: <20070211215558.GD21038@kwaak.net>
References: <20070110123116.GX15730@kwaak.net>
	<20070111171205.GC15730@kwaak.net>
	<20070111180322.GD15730@kwaak.net>
	<200701151806.20526.philipp.reisner@linbit.com>
	<20070116103749.GD9639@kwaak.net> <20070125174523.GD9639@kwaak.net>
	<20070125213210.GK7738@soda.linbit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070125213210.GK7738@soda.linbit>
From: Ard van Breemen <ard@kwaak.net>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On Thu, Jan 25, 2007 at 10:32:10PM +0100, Lars Ellenberg wrote:
> first, there is 2.6.19.2 already.

2.6.19.3 included the correct patches.
And since I am running 2.6.19.3 I didn't have any troubles
anymore. (same compiler and such).
Latest svn version doesn't work on 2.6.19.1 (but thanks to Lars's
patches also didn't oops), and that same version compiled for
2.6.19.3 works.

I suspect some NUMA fixes or other NUMA/SMP problems got fixed.

So, I've achieved my goal: syncing 1.2T within 5 hours without
taking the master down. Thanks for all the good work! :-).
