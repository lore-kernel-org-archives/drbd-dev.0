Return-Path: <kyle@moffetthome.net>
Received: from mail-yw0-f54.google.com (mail-yw0-f54.google.com
	[209.85.213.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CCAF710556B7
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 19:34:06 +0200 (CEST)
Received: by ywp17 with SMTP id 17so4489750ywp.27
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 10:34:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1316788285-17433-5-git-send-email-philipp.reisner@linbit.com>
References: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
	<1316788285-17433-5-git-send-email-philipp.reisner@linbit.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Fri, 23 Sep 2011 13:33:45 -0400
Message-ID: <CAGZ=bqJ_b54h9xid_PNwz-Ag6aNuvyUHx2QCm5UXpdc-JvHhKQ@mail.gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 04/10] drbd: Replace and remove old primitives
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi!

On Fri, Sep 23, 2011 at 10:31, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
> From: Andreas Gruenbacher <agruen@linbit.com>
>
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> ---
> =C2=A0drivers/block/drbd/drbd_int.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 45 +----
> =C2=A0drivers/block/drbd/drbd_main.c =C2=A0 =C2=A0 | =C2=A0502 ++++++++++=
++++++--------------------
> =C2=A0drivers/block/drbd/drbd_receiver.c | =C2=A0 86 ++++---
> =C2=A0drivers/block/drbd/drbd_worker.c =C2=A0 | =C2=A0 24 +-
> =C2=A04 files changed, 294 insertions(+), 363 deletions(-)

I'm afraid this commit is waaaaay too large and complicated
to have a one-line commit message.

You should either split this up into more pieces or you should
write a detailed log indicated what this is supposed to be doing
and why it is OK.  (Or both).

Cheers,
Kyle Moffett
