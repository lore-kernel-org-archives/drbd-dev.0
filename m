Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
	[209.85.218.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id ED5C24210D4
	for <drbd-dev@lists.linbit.com>; Fri,  9 Sep 2022 10:19:03 +0200 (CEST)
Received: by mail-ej1-f42.google.com with SMTP id go34so2283614ejc.2
	for <drbd-dev@lists.linbit.com>; Fri, 09 Sep 2022 01:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220908211337.17090-1-veggiemike@sourceruckus.org>
	<20220908211337.17090-3-veggiemike@sourceruckus.org>
In-Reply-To: <20220908211337.17090-3-veggiemike@sourceruckus.org>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Fri, 9 Sep 2022 10:18:52 +0200
Message-ID: <CAGNP_+UVojhL-zpJY_atDE=3v3pd=j-SsKVCR-xXFW9geAEKkg@mail.gmail.com>
To: Michael D Labriola <veggiemike@sourceruckus.org>
Content-Type: text/plain; charset="UTF-8"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/3] drbd: remove reliance on bdi congestion
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

> A serries of commits between 5.17 and 5.18 removed inode_congested()
> and all it's related functions because "No bdi reports congestion any
> more, so this always returns 'false'".
>
> This commit just returns false in both places bdi_congested() was
> called... which probably isn't the best long-term fix.

I suspect this is the best we can do in both cases. Perhaps with a
comment explaining why we just return false. The alternative would be
to invent some kind of heuristic to guess whether the backing device
is congested. That sounds like an intractable problem.

It would be interesting to know since when "No bdi reports congestion
any more". That would tell us how long we need to keep the compat
code.

It would also be interesting to know whether any real user depends on
this at all, but we'll never know that.

Please go ahead and add the compat code.

Thanks,
Joel
