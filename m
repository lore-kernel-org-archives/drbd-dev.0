Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 08C991072E9B
	for <drbd-dev@lists.linbit.com>; Tue, 22 Dec 2009 18:33:21 +0100 (CET)
Resent-Message-ID: <20091222173320.GK4717@barkeeper1-xen.linbit>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4A1011072E97
	for <drbd-dev@lists.linbit.com>; Tue, 22 Dec 2009 18:23:05 +0100 (CET)
Date: Tue, 22 Dec 2009 09:22:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jens Axboe <jens.axboe@oracle.com>
Message-Id: <20091222092223.8e44a621.akpm@linux-foundation.org>
In-Reply-To: <20091222091307.GJ4489@kernel.dk>
References: <200912220027.nBM0Rrsj005415@imap1.linux-foundation.org>
	<200912221007.50695.philipp.reisner@linbit.com>
	<20091222091307.GJ4489@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: roel.kluin@gmail.com, Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [patch 5/5] drbd: fix test of unsigned in
	_drbd_fault_random()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, 22 Dec 2009 10:13:07 +0100 Jens Axboe <jens.axboe@oracle.com> wrote:

> On Tue, Dec 22 2009, Philipp Reisner wrote:
> > Am Dienstag, 22. Dezember 2009 01:27:52 schrieb akpm@linux-foundation.org:
> > > From: Roel Kluin <roel.kluin@gmail.com>
> > > 
> > > rsp->count is unsigned so the test does not work.
> > > 
> > > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > [...]
> > 
> > This patch is on its way upstream
> > See http://git.kernel.dk/?p=linux-2.6-block.git;a=commit;h=49829ea74f790d3be2e803a617e714f5b9a5ed50
> > 
> > and in the DRBD tree for old kernels...
> > http://git.drbd.org/?p=drbd-8.3.git;a=commit;h=f1cb8ce303a26e4763bbfb32660643322f4e228d
> 
> Indeed, it's been in my for-linus/next for a while, I'm guessing Andrew
> just hasn't updated his sources for some days.
> 

I pull linux-next every day.

The above patch wasn't in the Dec 19 linux-next, and Stephen won't be
doing another -next until Dec 29.

