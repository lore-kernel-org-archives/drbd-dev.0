Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C0CEA1011BFF
	for <drbd-dev@lists.linbit.com>; Fri, 26 Apr 2019 11:29:08 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id b1so3507480wru.3
	for <drbd-dev@lists.linbit.com>; Fri, 26 Apr 2019 02:29:08 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Fri, 26 Apr 2019 11:29:06 +0200
Message-ID: <4867162.iqFBJbCNh0@fat-tyre>
In-Reply-To: <95efb6b1-4f0c-e965-2977-5c8c85e04567@i-love.sakura.ne.jp>
References: <00660ec7-ef62-e376-2e2c-71e42f2f649b@i-love.sakura.ne.jp>
	<3329030.LK3q2FzS93@fat-tyre>
	<95efb6b1-4f0c-e965-2977-5c8c85e04567@i-love.sakura.ne.jp>
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

Am Donnerstag, 25. April 2019, 16:12:54 CEST schrieb Tetsuo Handa:
> On 2019/04/25 22:51, Philipp Reisner wrote:
> >> What happens if nobody volunteers a page when current thread is
> >> calling new_or_recycle_send_buffer_page() ? In other words, may I ask
> >> the reason why GFP_NOIO is safe here?
> >=20
> > We always have one buffer page allocated. When the previous send_page()
> > finishes this buffer page gets recycled (it's page count drops to 1).
> > If the system has free memory for DRBD we are happy to use a new page
> > as the next buffer page, speeding up things, as we do not need to wait
> > for previous data to be finally sent.
> > It is guaranteed that we make progress here. Either because we get
> > memory (a) or because the previous buffer becomes reusable (b).
>=20
> Then, I think that using GFP_NOIO here is NOT safe because
> alloc_page(GFP_NOIO) can't return NULL even if the previous buffer's page
> count dropped to 1 because current thread will keep looping inside
> __alloc_pages_nodemask() due to 'The "too small to fail" memory-allocation
> rule' after current thread once reached alloc_page(GFP_NOIO).
>=20
> If you guarantee that page count drops to 1 by waiting for the previous
> send_page() to finish, GFP_NOWAIT | __GFP_NOWARN or GFP_NOIO |
> __GFP_NORETRY | __GFP_NOWARN should be used instead of GFP_NOIO |
> __GFP_NOWARN.

Ack. Do you want to send a patch that turns the current master into
GFP_NOIO | __GFP_NORETRY | __GFP_NOWARN
?

I will ack and apply it.

cheers.
=2D-=20
LINBIT | Keeping The Digital World Running

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.



