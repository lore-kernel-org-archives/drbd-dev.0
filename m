Return-Path: <christoph.lechleitner@iteg.at>
Received: from mxi.iteg.at (mxi.iteg.at [185.35.182.175])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 49EAB1056478
	for <drbd-dev@lists.linbit.com>; Tue,  8 Nov 2016 15:09:03 +0100 (CET)
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, drbd-dev@lists.linbit.com,
	philipp.reisner@linbit.com, viro@zeniv.linux.org.uk,
	Richard Weinberger <richard@nod.at>, wolfgang.glas@iteg.at
References: <1478601789-15060-1-git-send-email-richard@nod.at>
	<1478601789-15060-1-git-send-email-richard@nod.at>
From: Christoph Lechleitner <christoph.lechleitner@iteg.at>
Message-ID: <43450517-c3c5-bbcb-8d9b-cbe2a0b25542@iteg.at>
Date: Tue, 8 Nov 2016 15:03:08 +0100
MIME-Version: 1.0
In-Reply-To: <1478601789-15060-1-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix kernel_sendmsg() usage
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

Am 2016-11-08 um 14:43 schrieb Lars Ellenberg:
> From 3a5859e696178e31a25e65de58c461046fc52beb Mon Sep 17 00:00:00 2001
> From: Richard Weinberger <richard@nod.at>
> Date: Tue, 8 Nov 2016 11:43:09 +0100
> Subject: [PATCH] drbd: Fix kernel_sendmsg() usage - potential NULL deref
> drbd: Fix kernel_sendmsg() usage - potential NULL deref

> Even with this error exposed, to trigger the bug, we would need to have
> an environment (config or otherwise) causing us to not use sendpage()
> for larger transfers, a flaky connection, and have it fail "just at the
> right time".  Apparently that was unlikely enough for most, so this went
> unnoticed for years.

Our drbd configuration was created some 8 years ago.
Maybe I should have read more migration tips when upgrading again and
again, sorry ;-)

But a 30cm Cat6 cable directly connecting 2 dedicated ethernet ports
should not match the term "flaky connection".

FYI:
I co-own the company that hired Richard to track down this bug, that
repeatedly (~15 times) forced us to hard-reset servers hosting tens of
virtual root servers for our customers.

Regards, Christoph Lechleitner

