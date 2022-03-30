Return-Path: <snitzer@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6A1D64202BA
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2022 20:13:04 +0200 (CEST)
Received: by mail-qv1-f71.google.com with SMTP id
	x6-20020ad44626000000b0044119c7bf4aso16629853qvv.12
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2022 11:06:27 -0700 (PDT)
Date: Wed, 30 Mar 2022 14:06:25 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <YkScIas+/Ev0trcZ@redhat.com>
References: <20220329070618.GA20396@lst.de>
	<CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
	<20220329073254.GA20691@lst.de>
	<CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
	<f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
	<CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
	<3c42b1ed-7c03-64e6-409e-e92247288cac@kernel.dk>
	<CADGDV=WcTSSC70yG61dazo-WyoLOzp3r+nOk-Eg2x_Ncx=3nRg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADGDV=WcTSSC70yG61dazo-WyoLOzp3r+nOk-Eg2x_Ncx=3nRg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] state of drbd in mainline
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

On Wed, Mar 30 2022 at 11:23P -0400,
Philipp Reisner <philipp.reisner@linbit.com> wrote:

> > > Jens, my intention is to keep it in-tree, and at some point update it.
> > > Regarding your questions:
> >
> > That'd be great, but it's been years since there was any significant
> > updates to the in-kernel drbd... I would strongly suggest that the
> > in-kernel be brought closer to what people are mostly running, as it
> > stands it's basically unmaintained.
> 
> The changes we worked on over many Years in the more recent drbd-9.x
> branches are just too fundamental to do them in small chunks, we could
> upstream bit by bit.  We need to get that reviewed in a big series.  If I
> started to dump them on linux-block right away, nobody would look at it
> seriously, since it would be too much.  I intend to get people from red
> hat/suse assigned to do such a review. Then we will do that on linux-block,
> so that everyone who cares sees what happens.

Why do you think Red Hat, SUSE or any other distro vendor's engineers
should be made to review what amounts to be a massive dump of changes
you developed over years?

Presummably you have heard of "upstream first"!?  Why do you think it
doesn't apply to drbd?

It'd be one thing if drbd never went upstream but _it did_.  As is
your development model is completely wrong.

Mike

