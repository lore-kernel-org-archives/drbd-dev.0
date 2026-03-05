Return-Path: <agruenba@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B41FC1630E4
	for <drbd-dev@lists.linbit.com>; Thu,  5 Mar 2026 19:37:41 +0100 (CET)
Received: by mail-yw1-f198.google.com with SMTP id
	00721157ae682-7987861595eso148963607b3.1
	for <drbd-dev@lists.linbit.com>; Thu, 05 Mar 2026 10:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20260304190424.291743-1-agruenba@redhat.com>
	<20260304190424.291743-5-agruenba@redhat.com>
	<aamP2qNKEmiyXQQH@infradead.org>
In-Reply-To: <aamP2qNKEmiyXQQH@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 5 Mar 2026 19:37:26 +0100
Message-ID: <CAHc6FU5sEivMqj38xrAXuTxZ0d19LJjxbvoWtsPqm6NYigAEhA@mail.gmail.com>
Subject: Re: [PATCH 4/4] bio: use bio_io_error more often
To: Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
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

On Thu, Mar 5, 2026 at 3:14=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
> On Wed, Mar 04, 2026 at 08:04:09PM +0100, Andreas Gruenbacher wrote:
> > Instead of setting bio->bi_status to BLK_STS_IOERR and calling
> > bio_endio(bio), use the shorthand bio_io_error(bio).
>
> I'm a little torn how good these helpers actually are, as
> hard coding one specific type of error seems to create weird
> code and lead to bugs like the xfs one you fixed yesterday.
>
> Maybe we just need a bio_endio_status() that allows passing the
> status?

I'm not particularly attached to bio_io_error(bio); it's been around
forever but it can be confusing. Any thoughts on replacing it with a
new bio_endio_status(bio, BLK_STS_IOERR) helper instead of keeping two
mechanisms for doing the same thing?

> Also you really need to send one patch per subsystem.

I'm really trying to avoid that for simple, obviously correct,
mechanical changes that can be recreated from scratch any time.

Thanks,
Andreas

