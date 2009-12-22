Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (0122700014.0.fullrate.dk [95.166.99.235])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 96DE31072E90
	for <drbd-dev@lists.linbit.com>; Tue, 22 Dec 2009 10:22:53 +0100 (CET)
Date: Tue, 22 Dec 2009 10:13:07 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20091222091307.GJ4489@kernel.dk>
References: <200912220027.nBM0Rrsj005415@imap1.linux-foundation.org>
	<200912221007.50695.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200912221007.50695.philipp.reisner@linbit.com>
Cc: akpm@linux-foundation.org, roel.kluin@gmail.com, drbd-dev@lists.linbit.com
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

On Tue, Dec 22 2009, Philipp Reisner wrote:
> Am Dienstag, 22. Dezember 2009 01:27:52 schrieb akpm@linux-foundation.org:
> > From: Roel Kluin <roel.kluin@gmail.com>
> > 
> > rsp->count is unsigned so the test does not work.
> > 
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> [...]
> 
> This patch is on its way upstream
> See http://git.kernel.dk/?p=linux-2.6-block.git;a=commit;h=49829ea74f790d3be2e803a617e714f5b9a5ed50
> 
> and in the DRBD tree for old kernels...
> http://git.drbd.org/?p=drbd-8.3.git;a=commit;h=f1cb8ce303a26e4763bbfb32660643322f4e228d

Indeed, it's been in my for-linus/next for a while, I'm guessing Andrew
just hasn't updated his sources for some days.

-- 
Jens Axboe

