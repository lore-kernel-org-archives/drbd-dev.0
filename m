Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com
	[209.85.219.171])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6B8054202C6
	for <drbd-dev@lists.linbit.com>; Tue,  5 Mar 2024 10:40:07 +0100 (CET)
Received: by mail-yb1-f171.google.com with SMTP id
	3f1490d57ef6-dcbf82cdf05so5477858276.2
	for <drbd-dev@lists.linbit.com>; Tue, 05 Mar 2024 01:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20240226103004.281412-1-hch@lst.de>
	<20240226103004.281412-11-hch@lst.de>
	<20240303151438.GB27512@lst.de>
	<CADGDV=XqJ_3biGx-rX0jMMue4-dTg=J8NjyHOU-Ufonv4QiJ-A@mail.gmail.com>
In-Reply-To: <CADGDV=XqJ_3biGx-rX0jMMue4-dTg=J8NjyHOU-Ufonv4QiJ-A@mail.gmail.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 5 Mar 2024 10:39:55 +0100
Message-ID: <CADGDV=WJWZHj89rebvNJ2BOhuqG=_Nr5S3+QXp6LTEGGKyzuKQ@mail.gmail.com>
Subject: Re: drbd queue limits conversion ping
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
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

Christoph,

we are fine with the queue limit conversion as you did it. Lars and I
reviewed it, and Christoph ran the tests. All fine.


On Mon, Mar 4, 2024 at 4:31=E2=80=AFPM Philipp Reisner
<philipp.reisner@linbit.com> wrote:
>
> Hi Christoph,
>
> thanks for the heads up, and sorry for not seeing it sooner. We test
> it overnight and review the patches tomorrow morning.
>
>
> On Sun, Mar 3, 2024 at 4:14=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
> >
> > Dear RDBD maintainers,
> >
> > can you start the review on the drbd queue limits conversion?
> > This is the only big chunk of the queue limits conversion we haven't
> > even started reviews on, and the merge window is closing soon.
> >
