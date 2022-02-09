Return-Path: <jinpu.wang@ionos.com>
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
	[209.85.218.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 389F8420949
	for <drbd-dev@lists.linbit.com>; Wed,  9 Feb 2022 15:08:22 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id e7so3615077ejn.13
	for <drbd-dev@lists.linbit.com>; Wed, 09 Feb 2022 06:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20220209082828.2629273-1-hch@lst.de>
	<20220209082828.2629273-4-hch@lst.de>
	<CAMGffE=GMYNsw+mDt1h-BDh3JXkdrP9v2AUF7z0xE7jkumM+RQ@mail.gmail.com>
	<20220209140448.GA20765@lst.de>
In-Reply-To: <20220209140448.GA20765@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 9 Feb 2022 15:08:11 +0100
Message-ID: <CAMGffEm5qivscB8r+koGL7-bVxUOPr6=wLH6-RfHqzp8u2+HMw@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: axboe@kernel.dk, manoj@linux.ibm.com, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, haris.iqbal@ionos.com,
	ukrishn@linux.ibm.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com, mrochs@linux.ibm.com
Subject: Re: [Drbd-dev] [PATCH 3/7] rnbd: drop WRITE_SAME support
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

On Wed, Feb 9, 2022 at 3:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Feb 09, 2022 at 11:16:13AM +0100, Jinpu Wang wrote:
> > Hi Christoph,
> >
> >
> > On Wed, Feb 9, 2022 at 9:28 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > REQ_OP_WRITE_SAME was only ever submitted by the legacy Linux zeroing
> > > code, which has switched to use REQ_OP_WRITE_ZEROES long before rnbd was
> > > even merged.
> >
> > Do you think if it makes sense to instead of removing
> > REQ_OP_WRITE_SAME, simply convert it to REQ_OP_WRITE_ZEROES?
>
> Well, they have different semantics, so you can't just "convert" it.
> But it might make sense to add REQ_OP_WRITE_ZEROES.
Thanks, we will add support for REQ_OP_WRITE_ZEROES later.

For this patch, I've run internal tests, works fine.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thanks!
