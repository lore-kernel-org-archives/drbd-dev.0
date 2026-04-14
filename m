Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
	[209.85.128.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 23F7516087D
	for <drbd-dev@lists.linbit.com>; Tue, 14 Apr 2026 14:09:02 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
	5b1f17b1804b1-488a29e6110so59902205e9.3
	for <drbd-dev@lists.linbit.com>; Tue, 14 Apr 2026 05:09:02 -0700 (PDT)
Date: Tue, 14 Apr 2026 14:08:58 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Message-ID: <ad4ox7ibZoiW-tje@localhost.localdomain>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
	<20260407173356.873887-3-christoph.boehmwalder@linbit.com>
	<20260412125502.3f8ff576@kernel.org>
	<adzVUdf74CVk2DwJ@localhost.localdomain>
	<20260413104939.5ef4d9dc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413104939.5ef4d9dc@kernel.org>
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

On Mon, Apr 13, 2026 at 10:49:39AM -0700, Jakub Kicinski wrote:
>On Mon, 13 Apr 2026 13:48:32 +0200 Christoph Böhmwalder wrote:
>> >Can we just commit the code they output and leave the YNL itself be?
>> >Every single legacy family has some weird quirks the point of YNL
>> >is to get rid of them, not support them all..
>>
>> Fair enough, we could also do that. Though the question then becomes
>> whether we want to keep the YAML spec for the "drbd" family (patch 3 of
>> this series) in Documentation/.
>>
>> I would argue it makes sense to keep it around somewhere so that the old
>> family is somehow documented, but obviously that yaml file won't work
>> with the unmodified generator.
>
>To be clear (correct me if I misunderstood) it looked like we would be
>missing out on "automating" things, so extra work would still need to
>be done in the C code / manually written headers. But pure YNL (eg
>Python or Rust) client _would_ work? They could generate correct
>requests and parse responses, right?

I haven't tested this, but yes, a regular YNL client should work with
this spec. The new flags only influence kernel codegen, so a client
that doesn't know about them could still construct valid messages and
parse responses.

However, if we drop patch 2 completely, the new flags won't be in the
genetlink-legacy schema either, so schema validation would fail when
trying to generate.

>If yes, keeping it makes sense. FWIW all the specs we have for "old"
>networking families (routing etc) also don't replace any kernel code.
>They are purely to enable user space libraries in various languages.
>Whether having broad languages support for drbd or you just have one
>well known user space stack - I dunno.

Well, one of the main motivations for porting the current "drbd" family
to YNL is to get rid of the genl_magic infrastructure. We intend to add
a new modernized "drbd2" family, which will be fully YNL-based from the
start.
But we still need to support the current family via a compat path, and
I would much rather have two YNL-based families than one genl_magic and
one YNL-based. Carrying both sounds like a nightmare.

So the spec proposed in this series would never actually be used to
generate a userspace client, if that's what you're asking. We would
continue to use the current libgenl-based approach, with some userspace
compat shims to make it work with YNL. Then, when "drbd2" comes along,
we could "do things properly".

Might also be worth to mention that we are also experimenting with
Rust-based userspace utilities at the moment, so once we have "drbd2",
there will be a real benefit to having multi-language support.

So I'm fine with whichever route you want to take here, as long as
it enables us to move away from genl_magic.

If we decide to carry the "drbd" spec in-tree, that would then pretty
much only be for documentation purposes. Otherwise there would be
generated code where the spec it was generated from is non-existant,
which may be surprising.

>
>> Maybe keep it, but with a comment at the top that notes that
>> - this family is deprecated and "frozen",
>> - the spec is only for documentation purposes, and
>> - the spec doesn't work with the upstream parser?
>
>The past point needs a clarification, I guess..
