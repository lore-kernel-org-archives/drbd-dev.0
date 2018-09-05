Return-Path: <keescook@chromium.org>
Received: from mail-yw1-f66.google.com (mail-yw1-f66.google.com
	[209.85.161.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 074911011B9A
	for <drbd-dev@lists.linbit.com>; Wed,  5 Sep 2018 18:04:19 +0200 (CEST)
Received: by mail-yw1-f66.google.com with SMTP id p206-v6so2833115ywg.12
	for <drbd-dev@lists.linbit.com>; Wed, 05 Sep 2018 09:04:19 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com.
	[209.85.161.45]) by smtp.gmail.com with ESMTPSA id
	b6-v6sm918675ywb.78.2018.09.05.09.04.16
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Sep 2018 09:04:16 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id y134-v6so2852768ywg.1
	for <drbd-dev@lists.linbit.com>; Wed, 05 Sep 2018 09:04:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180905083320.GA28462@soda.linbit>
References: <20180806233216.GA6037@beast>
	<CAGXu5jKA6_aZpDXB2UurmW5cEGEC7aMcq=qvJGPVAifjnk17ug@mail.gmail.com>
	<CAGXu5jLyynGbnuhwabbViwzvRFzn-Vj5ktYOrypRGj_qk8UvQw@mail.gmail.com>
	<20180905083320.GA28462@soda.linbit>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 5 Sep 2018 09:04:14 -0700
Message-ID: <CAGXu5jL3Pw3s0r1kebQy_9xVDrtNnCqbRTAEqsa_GwK-eAWMkg@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block <linux-block@vger.kernel.org>,
	drbd-dev@lists.linbit.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Drbd-dev] [PATCH v7] drbd: Convert from ahash to shash
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

On Wed, Sep 5, 2018 at 1:33 AM, Lars Ellenberg
<lars.ellenberg@linbit.com> wrote:
> On Tue, Sep 04, 2018 at 08:04:18PM -0700, Kees Cook wrote:
>> On Mon, Sep 3, 2018 at 11:04 PM, Kees Cook <keescook@chromium.org> wrote:
>> > On Mon, Aug 6, 2018 at 4:32 PM, Kees Cook <keescook@chromium.org> wrote:
>> >> In preparing to remove all stack VLA usage from the kernel[1], this
>> >> removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
>> >> the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
>> >> to direct shash. By removing a layer of indirection this both improves
>> >> performance and reduces stack usage. The stack allocation will be made
>> >> a fixed size in a later patch to the crypto subsystem.
>> >>
>> >> The bulk of the lines in this change are simple s/ahash/shash/, but the
>> >> main logic differences are in drbd_csum_ee() and drbd_csum_bio(), which
>> >> externalizes the page walking with k(un)map_atomic() instead of using
>> >> scattergather.
>> >
>> > Hi Lars! How does this look to you? If you can Ack I assume Jens would
>> > be able to take this.
>
> Sure, I should have ACKed it a month ago already.  As I said, I believe
> you the crypto. And you added the kmap_atomic as I pointed out.
> All good.

Great, thanks! Jens, can you take this?

>> FWIW I've tested a simple drbd configuration before/after this change
>> and things seem to be working correctly.
>
> You'd need "data-integrity-alg" set (or "verify-alg", and then have it
> do an online-verify) to excercise the crypto stuff,
> and you'd need a highmem system (are these still out there?)
> to have the kmap not be a no-op.  But I don't see any potential problem.

While I don't have a highmem system, I've confirmed that
data-integrity-alg and verify-alg are both working for me.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
