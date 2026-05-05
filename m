Return-Path: <kuba@kernel.org>
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 987791626CE
	for <drbd-dev@lists.linbit.com>; Tue,  5 May 2026 03:02:32 +0200 (CEST)
Date: Mon, 4 May 2026 18:02:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Message-ID: <20260504180230.34ec1561@kernel.org>
In-Reply-To: <afhgQgySpoxXFCn1@localhost.localdomain>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
	<20260407173356.873887-3-christoph.boehmwalder@linbit.com>
	<20260412125502.3f8ff576@kernel.org>
	<adzVUdf74CVk2DwJ@localhost.localdomain>
	<20260413104939.5ef4d9dc@kernel.org>
	<ad4ox7ibZoiW-tje@localhost.localdomain>
	<20260414083548.02f76970@kernel.org>
	<afhgQgySpoxXFCn1@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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

On Mon, 4 May 2026 11:05:55 +0200 Christoph B=C3=B6hmwalder wrote:
> On Tue, Apr 14, 2026 at 08:35:48AM -0700, Jakub Kicinski wrote:
> >On Tue, 14 Apr 2026 14:08:58 +0200 Christoph B=C3=B6hmwalder wrote: =20
> >> But we still need to support the current family via a compat path, and
> >> I would much rather have two YNL-based families than one genl_magic and
> >> one YNL-based. Carrying both sounds like a nightmare.
> >>
> >> So the spec proposed in this series would never actually be used to
> >> generate a userspace client, if that's what you're asking. We would
> >> continue to use the current libgenl-based approach, with some userspace
> >> compat shims to make it work with YNL. Then, when "drbd2" comes along,
> >> we could "do things properly". =20
> >
> >Let's jump to the drbd2 work. =20
>=20
> We have a bit of a chicken-egg situation there.
>=20
> The drbd2 work depends on the DRBD 9 upstreaming series, since the drbd2
> netlink family will use the new DRBD 9 semantics.
> However, the DRBD 9 series depends on the current DRBD module already
> using YNL (or rather, *not* using genl_magic anymore).
>=20
> Our plan is to convert the current family to YNL in-place first, then
> incrementally add the new modern drbd2 family with DRBD 9 semantics in
> another series.
>=20
> How would you prefer to handle the YNL switch? If it makes it easier for
> you, just committing the YNL-generated code without the generator is
> fine for me. The old family is effectively frozen, so that would work.

That could work. Please float a series and CC netdev, we'll review.
