Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2810D1028A68
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 15:57:56 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id h4so30481451wre.7
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 06:57:56 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Thu, 25 Apr 2019 15:51:02 +0200
Message-ID: <3329030.LK3q2FzS93@fat-tyre>
In-Reply-To: <9996c784-5710-7afa-ac4e-5d3d63f70c43@i-love.sakura.ne.jp>
References: <00660ec7-ef62-e376-2e2c-71e42f2f649b@i-love.sakura.ne.jp>
	<20190425110255.hrc6xdagdygixpac@rck.sh>
	<9996c784-5710-7afa-ac4e-5d3d63f70c43@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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

Hi Tetsuo,

[...]
> Due to 'The "too small to fail" memory-allocation rule'
> ( https://lwn.net/Articles/627419/ ), I think that this allocation
> would loop forever inside the page allocator until somebody volunteers
> a page because this is called by a kernel thread which won't be killed
> by the OOM killer. That is, __GFP_NOWARN unlikely makes sense.

Without knowing the odds of the kernel allocator (too small to fail) for
me it "feels" right to mark that a failing allocations should not even
be logged. It is not the slightest problem at this point.
=20
> What happens if nobody volunteers a page when current thread is
> calling new_or_recycle_send_buffer_page() ? In other words, may I ask
> the reason why GFP_NOIO is safe here?

We always have one buffer page allocated. When the previous send_page()
finishes this buffer page gets recycled (it's page count drops to 1).
If the system has free memory for DRBD we are happy to use a new page=20
as the next buffer page, speeding up things, as we do not need to wait
for previous data to be finally sent.
It is guaranteed that we make progress here. Either because we get
memory (a) or because the previous buffer becomes reusable (b).

best regards,
 Phil
=2D-=20
LINBIT | Keeping The Digital World Running

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.



