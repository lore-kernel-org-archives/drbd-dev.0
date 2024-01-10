Return-Path: <Markus.Elfring@web.de>
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4F3EE420139
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jan 2024 12:45:37 +0100 (CET)
Message-ID: <71cd2c67-99a4-4173-8f0f-065fd864f8ba@web.de>
Date: Wed, 10 Jan 2024 12:40:24 +0100
MIME-Version: 1.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
	<33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
In-Reply-To: <33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [Drbd-dev] [PATCH 0/3] lru_cache: Adjustments for lc_create()
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

> Date: Wed, 29 Mar 2023 15:30:23 +0200
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (3):
>   Return directly after a failed kzalloc()
>   Improve two size determinations
>   Improve exception handling
>
>  lib/lru_cache.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)


Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/33226beb-4fe2-3da5-5d69-a33e683dec57@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00110.html

Regards,
Markus
