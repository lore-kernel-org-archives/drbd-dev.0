Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
	[209.85.208.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EC7A9420667
	for <drbd-dev@lists.linbit.com>; Fri,  9 Sep 2022 09:59:55 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id 29so1319812edv.2
	for <drbd-dev@lists.linbit.com>; Fri, 09 Sep 2022 00:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220908211337.17090-1-veggiemike@sourceruckus.org>
	<20220908211337.17090-4-veggiemike@sourceruckus.org>
In-Reply-To: <20220908211337.17090-4-veggiemike@sourceruckus.org>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Fri, 9 Sep 2022 09:59:44 +0200
Message-ID: <CAGNP_+UdQatEfaDSpDNTifT9h4AwKe5L1_PpSZ_rffk-viqtiw@mail.gmail.com>
To: Michael D Labriola <veggiemike@sourceruckus.org>
Content-Type: text/plain; charset="UTF-8"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 3/3] drbd: use bio_alloc_clone() instead of
	bio_clone_fast()
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

I believe Christoph has already started work on this one, so I'm
copying him in so that you can discuss it.

Thanks,
Joel
