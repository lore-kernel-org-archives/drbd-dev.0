Return-Path: <philipp.reisner@linbit.com>
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
	[209.85.221.174])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F237E420651
	for <drbd-dev@lists.linbit.com>; Mon,  4 Mar 2024 16:38:18 +0100 (CET)
Received: by mail-vk1-f174.google.com with SMTP id
	71dfb90a1353d-4d35b9a4b13so1693086e0c.0
	for <drbd-dev@lists.linbit.com>; Mon, 04 Mar 2024 07:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20240226103004.281412-1-hch@lst.de>
	<20240226103004.281412-11-hch@lst.de>
	<20240303151438.GB27512@lst.de>
In-Reply-To: <20240303151438.GB27512@lst.de>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Mon, 4 Mar 2024 16:31:53 +0100
Message-ID: <CADGDV=XqJ_3biGx-rX0jMMue4-dTg=J8NjyHOU-Ufonv4QiJ-A@mail.gmail.com>
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

Hi Christoph,

thanks for the heads up, and sorry for not seeing it sooner. We test
it overnight and review the patches tomorrow morning.


On Sun, Mar 3, 2024 at 4:14=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Dear RDBD maintainers,
>
> can you start the review on the drbd queue limits conversion?
> This is the only big chunk of the queue limits conversion we haven't
> even started reviews on, and the merge window is closing soon.
>
