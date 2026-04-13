Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
	[209.85.221.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1C5F616094D
	for <drbd-dev@lists.linbit.com>; Mon, 13 Apr 2026 13:48:34 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
	ffacd0b85a97d-43d74086e5bso907486f8f.0
	for <drbd-dev@lists.linbit.com>; Mon, 13 Apr 2026 04:48:34 -0700 (PDT)
Date: Mon, 13 Apr 2026 13:48:32 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Message-ID: <adzVUdf74CVk2DwJ@localhost.localdomain>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
	<20260407173356.873887-3-christoph.boehmwalder@linbit.com>
	<20260412125502.3f8ff576@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412125502.3f8ff576@kernel.org>
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

On Sun, Apr 12, 2026 at 12:55:02PM -0700, Jakub Kicinski wrote:
>On Tue,  7 Apr 2026 19:33:54 +0200 Christoph Böhmwalder wrote:
>> The new flags in the genetlink-legacy spec that are required for
>> existing consumers to keep working are:
>>
>>   "default": a literal value or C define that sets the default value
>>   for an attribute, consumed by set_defaults().
>>
>>   "required": if true, from_attrs() returns an error when this
>>   attribute is missing from the request message.
>>
>>   "nla-policy-type": can be used to override the NLA type used in
>>   policy arrays. This is needed when the semantic type differs from
>>   the wire type for backward compatibility: genl_magic maps s32 fields
>>   to NLA_U32/nla_get_u32, and existing userspace might depend on this
>>   encoding. The immediate motivation is DRBD, whose genl spec
>>   definition predates the addition of signed types in genl. However,
>>   this is a generic issue that potentially affects multiple families:
>>   for example, nftables has NFTA_HOOK_PRIORITY as s32 in the spec but
>>   NLA_U32 in the actual kernel policy.
>
>The series doesn't apply for me (neither to Linus's tree nor
>to networking trees), so I didn't experiment with this code.

It's based on for-7.1/block in Jens' tree because there are some
prerequisite commits on there that haven't made it to master yet.

If required, I can also send the net-specific patches based on another
tree, just thought it made sense to keep it all together to have the
whole context in one place.

>Are the new code gen additions purely for the kernel?

Yes. The DRBD userspace utilities re-use the kernel headers and manually
construct messages using libgenl, so we can just do the same for the
legacy family.

>Can we just commit the code they output and leave the YNL itself be?
>Every single legacy family has some weird quirks the point of YNL
>is to get rid of them, not support them all..

Fair enough, we could also do that. Though the question then becomes
whether we want to keep the YAML spec for the "drbd" family (patch 3 of
this series) in Documentation/.

I would argue it makes sense to keep it around somewhere so that the old
family is somehow documented, but obviously that yaml file won't work
with the unmodified generator.

Maybe keep it, but with a comment at the top that notes that
- this family is deprecated and "frozen",
- the spec is only for documentation purposes, and
- the spec doesn't work with the upstream parser?

Thoughts?
