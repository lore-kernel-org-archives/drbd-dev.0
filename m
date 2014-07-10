Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 24ACB101E050
	for <drbd-dev@lists.linbit.com>; Thu, 10 Jul 2014 11:53:30 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 10 Jul 2014 11:53:29 +0200
Message-ID: <2397073.C8BSPuutsL@fat-tyre>
In-Reply-To: <53BE57CA.9020807@kernel.dk>
References: <1404933512-5166-1-git-send-email-philipp.reisner@linbit.com>
	<1404933512-5166-2-git-send-email-philipp.reisner@linbit.com>
	<53BE57CA.9020807@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: fix regression 'out of mem,
	failed to invoke fence-peer helper'
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

Am Donnerstag, 10. Juli 2014, 11:07:22 schrieb Jens Axboe:
> On 2014-07-09 21:18, Philipp Reisner wrote:
> > From: Lars Ellenberg <lars.ellenberg@linbit.com>
> > 
> > Since linux kernel 3.13, kthread_run() internally uses
> > wait_for_completion_killable().  We sometimes may use kthread_run()
> > while we still have a signal pending, which we used to kick our threads
> > out of potentially blocking network functions, causing kthread_run() to
> > mistake that as a new fatal signal and fail.
> > 
> > Fix: flush_signals() before kthread_run().
> 
> Applied - should this have been marked stable, if it affects 3..13+ kernels?

Yes, you are right. It should go to the stable kernels since 3.13 as
well.

What is the correct way for me to mark it as stable when sending a patch?

-phil

