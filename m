Return-Path: <kyle@moffetthome.net>
Received: from mail-yx0-f182.google.com (mail-yx0-f182.google.com
	[209.85.213.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 903531055701
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 19:43:13 +0200 (CEST)
Received: by yxk36 with SMTP id 36so4495815yxk.27
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 10:43:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1316788285-17433-9-git-send-email-philipp.reisner@linbit.com>
References: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
	<1316788285-17433-9-git-send-email-philipp.reisner@linbit.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Fri, 23 Sep 2011 13:42:52 -0400
Message-ID: <CAGZ=bqJMKZ=MK+GXSXWCPVCecXHQv_15AT9Dxq2wxfcA_gNdMA@mail.gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 08/10] drbd: Introduce protocol version 100
	headers
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
> =C2=A0drivers/block/drbd/drbd_int.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A08 =
++++++++
> =C2=A0drivers/block/drbd/drbd_main.c =C2=A0 =C2=A0 | =C2=A0 31 ++++++++++=
+++++++++++++++------
> =C2=A0drivers/block/drbd/drbd_receiver.c | =C2=A0 14 ++++++++++++--
> =C2=A0include/linux/drbd.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A01 +
> =C2=A04 files changed, 46 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.=
h
> index 9868518..7d679c5 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -307,6 +307,14 @@ struct p_header95 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 =C2=A0 =C2=A0 =C2=A0 vol_n_len; =C2=A0 =C2=
=A0/* big endian: high byte =3D volume; remaining 24 bit =3D length */
> =C2=A0} __packed;
>
> +struct p_header100 {
> + =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 magic;
> + =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 volume;
> + =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 command;
> + =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 length;
> + =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 pad;
> +} __packed;
> +

This commit also needs additional log message text,
specifically something that indicates what is new and
different between the protocol 95 and protocol 100
headers.  (IE: Why was the change made?)

Cheers,
Kyle Moffett
