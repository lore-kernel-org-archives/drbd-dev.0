Return-Path: <kyle@moffetthome.net>
Received: from mail-yw0-f54.google.com (mail-yw0-f54.google.com
	[209.85.213.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 255A710556B7
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 19:28:46 +0200 (CEST)
Received: by ywp17 with SMTP id 17so4483958ywp.27
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 10:28:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1316788285-17433-10-git-send-email-philipp.reisner@linbit.com>
References: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
	<1316788285-17433-10-git-send-email-philipp.reisner@linbit.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Fri, 23 Sep 2011 13:28:24 -0400
Message-ID: <CAGZ=bq+Ef+wy8E9taBv=vZfTdvC_VBFFD=GzNqR9Em46U-wMmg@mail.gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 09/10] drbd: Remove volume numbers from
	struct p_header95
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
[...snip...]
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_mai=
n.c
> index 3310986..99b467e 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -717,11 +717,11 @@ static unsigned int prepare_header80(struct p_heade=
r80 *h, enum drbd_packet cmd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return sizeof(struct p_header80);
> =C2=A0}
>
> -static unsigned int prepare_header95(struct p_header95 *h, enum drbd_pac=
ket cmd, int size, int vnr)
> +static unsigned int prepare_header95(struct p_header95 *h, enum drbd_pac=
ket cmd, int size)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0h->magic =C2=A0 =3D cpu_to_be16(DRBD_MAGIC_BIG=
);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0h->command =3D cpu_to_be16(cmd);
> - =C2=A0 =C2=A0 =C2=A0 h->vol_n_len =3D cpu_to_be32(vnr << 24 | size);
> + =C2=A0 =C2=A0 =C2=A0 h->length =3D cpu_to_be32(size);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return sizeof(struct p_header95);
> =C2=A0}

This patch needs a commit message indicating why it does not break
compatibility.  If you are guaranteed that the "vnr" passed into
prepare_header95 is always zero, then you should indicate why that is
true.

Cheers,
Kyle Moffett
