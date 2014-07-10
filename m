Return-Path: <axboe@kernel.dk>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
	[74.125.82.171]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9DC66101AC75
	for <drbd-dev@lists.linbit.com>; Thu, 10 Jul 2014 12:05:44 +0200 (CEST)
Received: by mail-we0-f171.google.com with SMTP id q58so8824141wes.16
	for <drbd-dev@lists.linbit.com>; Thu, 10 Jul 2014 03:05:43 -0700 (PDT)
Message-ID: <53BE57CA.9020807@kernel.dk>
Date: Thu, 10 Jul 2014 11:07:22 +0200
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org
References: <1404933512-5166-1-git-send-email-philipp.reisner@linbit.com>
	<1404933512-5166-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404933512-5166-2-git-send-email-philipp.reisner@linbit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
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

On 2014-07-09 21:18, Philipp Reisner wrote:
> From: Lars Ellenberg <lars.ellenberg@linbit.com>
>
> Since linux kernel 3.13, kthread_run() internally uses
> wait_for_completion_killable().  We sometimes may use kthread_run()
> while we still have a signal pending, which we used to kick our threads
> out of potentially blocking network functions, causing kthread_run() to
> mistake that as a new fatal signal and fail.
>
> Fix: flush_signals() before kthread_run().

Applied - should this have been marked stable, if it affects 3..13+ kernels?

-- 
Jens Axboe

