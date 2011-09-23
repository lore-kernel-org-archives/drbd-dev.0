Return-Path: <kyle@moffetthome.net>
Received: from mail-pz0-f44.google.com (mail-pz0-f44.google.com
	[209.85.210.44]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6BED910556B7
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 19:38:36 +0200 (CEST)
Received: by pzk32 with SMTP id 32so15524123pzk.3
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 10:38:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1316788285-17433-8-git-send-email-philipp.reisner@linbit.com>
References: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
	<1316788285-17433-8-git-send-email-philipp.reisner@linbit.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Fri, 23 Sep 2011 13:38:15 -0400
Message-ID: <CAGZ=bq+XQNGEU1HHBEMWdc-hg-B-=eoKNYobUeGrZeeSq41M_A@mail.gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 07/10] drbd: Remove headers from on-the-wire
 data structures (struct p_*)
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
> =C2=A0drivers/block/drbd/drbd_int.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 45 -----=
-----
> =C2=A0drivers/block/drbd/drbd_main.c =C2=A0 =C2=A0 | =C2=A0 44 +++++-----
> =C2=A0drivers/block/drbd/drbd_receiver.c | =C2=A0171 ++++++++++++++++++--=
----------------
> =C2=A0drivers/block/drbd/drbd_worker.c =C2=A0 | =C2=A0 =C2=A02 +-

This commit is kind of borderline too-big for just a one-line commit messag=
e.

It is admittedly very simple (changing the same pointer math in ~50 places)=
,
but it needs a bit more explanation about why it's helpful or necessary.

I *think* it's because the protocol-100 code will use a different-sized hea=
der,
but that needs to be actually explained somewhere.

Cheers,
Kyle Moffett
