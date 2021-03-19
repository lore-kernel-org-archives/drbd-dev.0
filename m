Return-Path: <arnd@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1BC674202B5
	for <drbd-dev@lists.linbit.com>; Fri, 19 Mar 2021 16:03:44 +0100 (CET)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 971A364F59
	for <drbd-dev@lists.linbit.com>; Fri, 19 Mar 2021 14:56:36 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id d133so5038724oib.3
	for <drbd-dev@lists.linbit.com>; Fri, 19 Mar 2021 07:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210312105530.2219008-1-lee.jones@linaro.org>
	<20210312105530.2219008-7-lee.jones@linaro.org>
In-Reply-To: <20210312105530.2219008-7-lee.jones@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 19 Mar 2021 15:56:19 +0100
Message-ID: <CAK8P3a234A2WmPFJxXmf-n+J7TP3A=DyDWEr657zxaML7V9UWQ@mail.gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block <linux-block@vger.kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/11] block: drbd: drbd_main: Remove
	duplicate field initialisation
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

On Fri, Mar 12, 2021 at 11:57 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> [P_RETRY_WRITE] is initialised more than once.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/block/drbd/drbd_main.c: In function =E2=80=98cmdname=E2=80=99:
>  drivers/block/drbd/drbd_main.c:3660:22: warning: initialized field overw=
ritten [-Woverride-init]
>  drivers/block/drbd/drbd_main.c:3660:22: note: (near initialization for =
=E2=80=98cmdnames[44]=E2=80=99)
>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: drbd-dev@lists.linbit.com
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks correct. I had actually posted a slightly different fix last year,
but either one addresses the warning:

https://lore.kernel.org/lkml/20201026215043.3893318-1-arnd@kernel.org/

         Arnd
