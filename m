Return-Path: <kuba@kernel.org>
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9F7991621BE
	for <drbd-dev@lists.linbit.com>; Mon, 13 Apr 2026 19:49:52 +0200 (CEST)
Date: Mon, 13 Apr 2026 10:49:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Message-ID: <20260413104939.5ef4d9dc@kernel.org>
In-Reply-To: <adzVUdf74CVk2DwJ@localhost.localdomain>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
	<20260407173356.873887-3-christoph.boehmwalder@linbit.com>
	<20260412125502.3f8ff576@kernel.org>
	<adzVUdf74CVk2DwJ@localhost.localdomain>
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

On Mon, 13 Apr 2026 13:48:32 +0200 Christoph B=C3=B6hmwalder wrote:
> >Can we just commit the code they output and leave the YNL itself be?
> >Every single legacy family has some weird quirks the point of YNL
> >is to get rid of them, not support them all.. =20
>=20
> Fair enough, we could also do that. Though the question then becomes
> whether we want to keep the YAML spec for the "drbd" family (patch 3 of
> this series) in Documentation/.
>=20
> I would argue it makes sense to keep it around somewhere so that the old
> family is somehow documented, but obviously that yaml file won't work
> with the unmodified generator.

To be clear (correct me if I misunderstood) it looked like we would be
missing out on "automating" things, so extra work would still need to
be done in the C code / manually written headers. But pure YNL (eg
Python or Rust) client _would_ work? They could generate correct
requests and parse responses, right?

If yes, keeping it makes sense. FWIW all the specs we have for "old"
networking families (routing etc) also don't replace any kernel code.
They are purely to enable user space libraries in various languages.
Whether having broad languages support for drbd or you just have one
well known user space stack - I dunno.=20

> Maybe keep it, but with a comment at the top that notes that
> - this family is deprecated and "frozen",
> - the spec is only for documentation purposes, and
> - the spec doesn't work with the upstream parser?

The past point needs a clarification, I guess..
