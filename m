Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (0122700014.0.fullrate.dk [95.166.99.235])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2D44A10565B6
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jun 2011 10:13:45 +0200 (CEST)
Message-ID: <4E0C3037.6040905@kernel.dk>
Date: Thu, 30 Jun 2011 10:13:43 +0200
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <201106291714.57384.philipp.reisner@linbit.com>
	<4E0B6B85.5090202@kernel.dk>
	<201106301008.32832.philipp.reisner@linbit.com>
In-Reply-To: <201106301008.32832.philipp.reisner@linbit.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD minor fixes for 3.0-rc6
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2011-06-30 10:08, Philipp Reisner wrote:
> Am Mittwoch, 29. Juni 2011, 20:14:29 schrieb Jens Axboe:
>> On 2011-06-29 17:14, Philipp Reisner wrote:
>>> The following changes since commit a1c15c59feee36267c43142a41152fbf7402afb6:
>>>   loop: handle on-demand devices correctly (2011-05-24 16:48:55 +0200)
>>>
>>> are available in the git repository at:
>>>   git://git.drbd.org/linux-2.6-drbd.git for-jens
>>
>> This looks way too big for -rc6. Take another look at the list and
>> re-send with what is absolutely crucial this late in the cycle, please.
> 
> Hi Jens,
> 
> I categorised them into three branches:
> for-3.0-important, for-3.0-non-important-trivia and for-3.0-non-trivial-cosmetic.
> 
> Please consider to pull the first one, eventually the second one. (The third
> one is only there for sake of completeness, to document that this patch will
> be scheduled for the next merge window)

I have pulled your for-3.0-important branch, looks fine. I'm not pulling
any non-important or trivia for 3.0, so both of the latter branches will
have to wait for 3.1. But do send me pull request for them, might as
well queue it up now since it'll soon be merge time again.

-- 
Jens Axboe

