Return-Path: <philipp.reisner@linbit.com>
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
	[209.85.217.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0FB6F4201B8
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2022 09:22:37 +0200 (CEST)
Received: by mail-vs1-f50.google.com with SMTP id t123so18183246vst.13
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2022 00:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220329070618.GA20396@lst.de>
In-Reply-To: <20220329070618.GA20396@lst.de>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 29 Mar 2022 09:22:26 +0200
Message-ID: <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: multipart/alternative; boundary="000000000000199c0305db564bc7"
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
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

--000000000000199c0305db564bc7
Content-Type: text/plain; charset="UTF-8"

Hi Christoph,

what do you expect for the DRBD changes? Usually, they fall into the
category: yes, obviously. When you are changing the block layer in this
way, then that is necessary for the in-tree DRBD code.

Regarding users: Yes, there are users of the in-tree DRBD code. Very big
corporations. And, yes, we see pressure building up that we get our act
together and re-sync the in-tree DRBD with the out-of tree DRBD.

best regards,
 Phil


On Tue, Mar 29, 2022 at 9:06 AM Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
>
> while I've been reworking large parts of the block layer over the
> last months I've basically never gotten drbd reviews, and in general
> drbd seems to be completely maintained upstream.  Do we even have users
> for it?  Is it time to drop drbd from the kernel tree?
>
> Thanks,
>         Christoph
>

--000000000000199c0305db564bc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Christoph,<div><br></div><div>what do you expect for th=
e DRBD changes? Usually, they fall into the category: yes, obviously. When =
you are changing the block layer in this way, then that is necessary for th=
e in-tree DRBD code.</div><div><br></div><div>Regarding users: Yes, there a=
re users of the in-tree DRBD code. Very big corporations. And, yes, we see =
pressure=C2=A0building up that we get our act together and re-sync the in-t=
ree DRBD with the out-of tree DRBD.</div><div><br></div><div>best regards,<=
br>=C2=A0Phil</div><div><br></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 29, 2022 at 9:06 AM Christoph=
 Hellwig &lt;<a href=3D"mailto:hch@lst.de">hch@lst.de</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
while I&#39;ve been reworking large parts of the block layer over the<br>
last months I&#39;ve basically never gotten drbd reviews, and in general<br=
>
drbd seems to be completely maintained upstream.=C2=A0 Do we even have user=
s<br>
for it?=C2=A0 Is it time to drop drbd from the kernel tree?<br>
<br>
Thanks,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Christoph<br>
</blockquote></div>

--000000000000199c0305db564bc7--
