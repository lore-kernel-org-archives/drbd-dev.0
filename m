Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DDAE01013806
	for <drbd-dev@lists.linbit.com>; Wed,  5 Sep 2018 10:39:40 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so6654880wro.11
	for <drbd-dev@lists.linbit.com>; Wed, 05 Sep 2018 01:39:40 -0700 (PDT)
Date: Wed, 5 Sep 2018 10:33:20 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Kees Cook <keescook@chromium.org>
Message-ID: <20180905083320.GA28462@soda.linbit>
References: <20180806233216.GA6037@beast>
	<CAGXu5jKA6_aZpDXB2UurmW5cEGEC7aMcq=qvJGPVAifjnk17ug@mail.gmail.com>
	<CAGXu5jLyynGbnuhwabbViwzvRFzn-Vj5ktYOrypRGj_qk8UvQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLyynGbnuhwabbViwzvRFzn-Vj5ktYOrypRGj_qk8UvQw@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	LKML <linux-kernel@vger.kernel.org>, drbd-dev@lists.linbit.com
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

On Tue, Sep 04, 2018 at 08:04:18PM -0700, Kees Cook wrote:
> On Mon, Sep 3, 2018 at 11:04 PM, Kees Cook <keescook@chromium.org> wrote:
> > On Mon, Aug 6, 2018 at 4:32 PM, Kees Cook <keescook@chromium.org> wrote:
> >> In preparing to remove all stack VLA usage from the kernel[1], this
> >> removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
> >> the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
> >> to direct shash. By removing a layer of indirection this both improves
> >> performance and reduces stack usage. The stack allocation will be made
> >> a fixed size in a later patch to the crypto subsystem.
> >>
> >> The bulk of the lines in this change are simple s/ahash/shash/, but the
> >> main logic differences are in drbd_csum_ee() and drbd_csum_bio(), which
> >> externalizes the page walking with k(un)map_atomic() instead of using
> >> scattergather.
> >
> > Hi Lars! How does this look to you? If you can Ack I assume Jens would
> > be able to take this.

Sure, I should have ACKed it a month ago already.  As I said, I believe
you the crypto. And you added the kmap_atomic as I pointed out.
All good.

> FWIW I've tested a simple drbd configuration before/after this change
> and things seem to be working correctly.

You'd need "data-integrity-alg" set (or "verify-alg", and then have it
do an online-verify) to excercise the crypto stuff,
and you'd need a highmem system (are these still out there?)
to have the kmap not be a no-op.  But I don't see any potential problem.

Thanks!

    Lars
