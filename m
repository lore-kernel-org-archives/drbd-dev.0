Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
	[209.85.208.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9251D420667
	for <drbd-dev@lists.linbit.com>; Fri,  9 Sep 2022 09:57:34 +0200 (CEST)
Received: by mail-ed1-f46.google.com with SMTP id q21so1273147edc.9
	for <drbd-dev@lists.linbit.com>; Fri, 09 Sep 2022 00:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220908211337.17090-1-veggiemike@sourceruckus.org>
	<20220908211337.17090-2-veggiemike@sourceruckus.org>
In-Reply-To: <20220908211337.17090-2-veggiemike@sourceruckus.org>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Fri, 9 Sep 2022 09:57:23 +0200
Message-ID: <CAGNP_+VfjTkF57HJAk1-MEmJbGbcjVeUEX702awJo+mUE29uuw@mail.gmail.com>
To: Michael D Labriola <veggiemike@sourceruckus.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 1/3] drbd: remove WRITE_SAME support
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Michael,

Thanks for the patch!

> This commit mimics upstream commit a34592ff6b78, which removes all the
> WRITE_SAME code because "REQ_OP_WRITE_SAME was only ever submitted by
> the legacy Linux zeroing code, which has switched to use
> REQ_OP_WRITE_ZEROES long ago."  WRITE_SAME was then removed from Linux
> 5.18.

This is an interesting case. If we remove all the write-same code like
this, then we either need to add it back in via compat, or we lose a
feature. I think it is OK to lose the feature on 5.18+ kernels, since
the rest of the kernel does not use it any more. On older kernels this
might break real use cases.

There is also the case where our peer is running an older kernel and
we are running 5.18+. I think we should worry about that after
deciding what to do with peers that run the same kernel.

I've added Lars to CC because he is more familiar with the historical
changes in this area.

Note: If we do remove the feature entirely, we should stop advertising
the feature flag DRBD_FF_WSAME so that the peer knows that we do not
support it.

Best regards,
Joel
