Return-Path: <kuba@kernel.org>
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AC651162338
	for <drbd-dev@lists.linbit.com>; Sun, 12 Apr 2026 22:01:44 +0200 (CEST)
Date: Sun, 12 Apr 2026 12:55:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Message-ID: <20260412125502.3f8ff576@kernel.org>
In-Reply-To: <20260407173356.873887-3-christoph.boehmwalder@linbit.com>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
	<20260407173356.873887-3-christoph.boehmwalder@linbit.com>
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

On Tue,  7 Apr 2026 19:33:54 +0200 Christoph B=C3=B6hmwalder wrote:
> The new flags in the genetlink-legacy spec that are required for
> existing consumers to keep working are:
>=20
>   "default": a literal value or C define that sets the default value
>   for an attribute, consumed by set_defaults().
>=20
>   "required": if true, from_attrs() returns an error when this
>   attribute is missing from the request message.
>=20
>   "nla-policy-type": can be used to override the NLA type used in
>   policy arrays. This is needed when the semantic type differs from
>   the wire type for backward compatibility: genl_magic maps s32 fields
>   to NLA_U32/nla_get_u32, and existing userspace might depend on this
>   encoding. The immediate motivation is DRBD, whose genl spec
>   definition predates the addition of signed types in genl. However,
>   this is a generic issue that potentially affects multiple families:
>   for example, nftables has NFTA_HOOK_PRIORITY as s32 in the spec but
>   NLA_U32 in the actual kernel policy.

The series doesn't apply for me (neither to Linus's tree nor=20
to networking trees), so I didn't experiment with this code.

Are the new code gen additions purely for the kernel?
Can we just commit the code they output and leave the YNL itself be?
Every single legacy family has some weird quirks the point of YNL
is to get rid of them, not support them all..
