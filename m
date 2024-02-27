Return-Path: <song@kernel.org>
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6B07B4205D4
	for <drbd-dev@lists.linbit.com>; Tue, 27 Feb 2024 23:04:13 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B83DDCE1AAA
	for <drbd-dev@lists.linbit.com>; Tue, 27 Feb 2024 21:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A72C433C7
	for <drbd-dev@lists.linbit.com>; Tue, 27 Feb 2024 21:55:03 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
	2adb3069b0e04-5131316693cso1328501e87.0
	for <drbd-dev@lists.linbit.com>; Tue, 27 Feb 2024 13:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20240226103004.281412-1-hch@lst.de>
	<20240226103004.281412-7-hch@lst.de>
	<b4828284-87ec-693b-e2c3-84bdafcbda65@huaweicloud.com>
	<20240227152609.GA14782@lst.de>
In-Reply-To: <20240227152609.GA14782@lst.de>
From: Song Liu <song@kernel.org>
Date: Tue, 27 Feb 2024 13:54:50 -0800
Message-ID: <CAPhsuW5xaK=WR1RKGpYkSzHW8TOMbUwY-KeTD=kD3otQFZZV0Q@mail.gmail.com>
Subject: Re: [PATCH 06/16] md/raid1: use the atomic queue limit update APIs
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	Mikulas Patocka <mpatocka@redhat.com>, "yukuai \(C\)" <yukuai3@huawei.com>,
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

On Tue, Feb 27, 2024 at 7:26=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Feb 26, 2024 at 07:29:08PM +0800, Yu Kuai wrote:
> > Hi,
> >
> > =E5=9C=A8 2024/02/26 18:29, Christoph Hellwig =E5=86=99=E9=81=93:
> >> Build the queue limits outside the queue and apply them using
> >> queue_limits_set.  Also remove the bogus ->gendisk and ->queue NULL
> >> checks in the are while touching it.
> >
> > The checking of mddev->gendisk can't be removed, because this is used t=
o
> > distinguish dm-raid and md/raid. And the same for following patches.
>
> Ah.  Well, we should make that more obvious then.  This is what I
> currently have:
>
> http://git.infradead.org/?p=3Dusers/hch/block.git;a=3Dshortlog;h=3Drefs/h=
eads/md-blk-limits
>
> particularly:
>
> http://git.infradead.org/?p=3Dusers/hch/block.git;a=3Dcommitdiff;h=3D24b2=
fd15f57f06629d2254ebec480e1e28b96636

Yes! I was thinking about something like mddev_is_dm() to make these
checks less confusing. Thanks!

Song
