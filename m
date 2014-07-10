Return-Path: <axboe@kernel.dk>
Received: from mail-we0-f177.google.com (mail-we0-f177.google.com
	[74.125.82.177]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 43F6E101E051
	for <drbd-dev@lists.linbit.com>; Thu, 10 Jul 2014 11:56:00 +0200 (CEST)
Received: by mail-we0-f177.google.com with SMTP id u56so8576658wes.8
	for <drbd-dev@lists.linbit.com>; Thu, 10 Jul 2014 02:56:00 -0700 (PDT)
Message-ID: <53BE632E.5040408@kernel.dk>
Date: Thu, 10 Jul 2014 11:55:58 +0200
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <1404933512-5166-1-git-send-email-philipp.reisner@linbit.com>
	<1404933512-5166-2-git-send-email-philipp.reisner@linbit.com>
	<53BE57CA.9020807@kernel.dk> <2397073.C8BSPuutsL@fat-tyre>
In-Reply-To: <2397073.C8BSPuutsL@fat-tyre>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2014-07-10 11:53, Philipp Reisner wrote:
> Am Donnerstag, 10. Juli 2014, 11:07:22 schrieb Jens Axboe:
>> On 2014-07-09 21:18, Philipp Reisner wrote:
>>> From: Lars Ellenberg <lars.ellenberg@linbit.com>
>>>
>>> Since linux kernel 3.13, kthread_run() internally uses
>>> wait_for_completion_killable().  We sometimes may use kthread_run()
>>> while we still have a signal pending, which we used to kick our threads
>>> out of potentially blocking network functions, causing kthread_run() to
>>> mistake that as a new fatal signal and fail.
>>>
>>> Fix: flush_signals() before kthread_run().
>>
>> Applied - should this have been marked stable, if it affects 3..13+ kernels?
>
> Yes, you are right. It should go to the stable kernels since 3.13 as
> well.

Alright, we'll have to notify Greg/stable when it goes in.

> What is the correct way for me to mark it as stable when sending a patch?

You just add a:

Cc: stable@kernel.org

where the signed-off-by is. If you know the versions it should be 
applied to, you can add that information as well. For this case, you 
would have done:

Cc: stable@kernel.org # v3.13+

to get it into 3.13 stable and later.

-- 
Jens Axboe

