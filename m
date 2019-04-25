Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C80821028A68
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 16:13:02 +0200 (CEST)
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <00660ec7-ef62-e376-2e2c-71e42f2f649b@i-love.sakura.ne.jp>
	<20190425110255.hrc6xdagdygixpac@rck.sh>
	<9996c784-5710-7afa-ac4e-5d3d63f70c43@i-love.sakura.ne.jp>
	<3329030.LK3q2FzS93@fat-tyre>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <95efb6b1-4f0c-e965-2977-5c8c85e04567@i-love.sakura.ne.jp>
Date: Thu, 25 Apr 2019 23:12:54 +0900
MIME-Version: 1.0
In-Reply-To: <3329030.LK3q2FzS93@fat-tyre>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Roland Kammerer <roland.kammerer@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Avoid GFP_KERNEL allocation from
 alloc_send_buffer()
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

On 2019/04/25 22:51, Philipp Reisner wrote:
>> What happens if nobody volunteers a page when current thread is
>> calling new_or_recycle_send_buffer_page() ? In other words, may I ask
>> the reason why GFP_NOIO is safe here?
> 
> We always have one buffer page allocated. When the previous send_page()
> finishes this buffer page gets recycled (it's page count drops to 1).
> If the system has free memory for DRBD we are happy to use a new page 
> as the next buffer page, speeding up things, as we do not need to wait
> for previous data to be finally sent.
> It is guaranteed that we make progress here. Either because we get
> memory (a) or because the previous buffer becomes reusable (b).

Then, I think that using GFP_NOIO here is NOT safe because alloc_page(GFP_NOIO)
can't return NULL even if the previous buffer's page count dropped to 1 because
current thread will keep looping inside __alloc_pages_nodemask() due to
'The "too small to fail" memory-allocation rule' after current thread once
reached alloc_page(GFP_NOIO).

If you guarantee that page count drops to 1 by waiting for the previous send_page()
to finish, GFP_NOWAIT | __GFP_NOWARN or GFP_NOIO | __GFP_NORETRY | __GFP_NOWARN
should be used instead of GFP_NOIO | __GFP_NOWARN.

Also, GFP_ATOMIC | __GFP_NOWARN would be OK for speeding up things if
at most only a few dozens of pages are allocated here.

