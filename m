Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8C6B04203D6
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:56:15 +0200 (CEST)
Received: by mail-wm1-f66.google.com with SMTP id l17so10056531wmj.0
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:56:15 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	e5sm14440704wrw.19.2020.06.13.02.56.14
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:56:14 -0700 (PDT)
Resent-Message-ID: <20200613095612.GC4222@soda.linbit>
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
	[209.85.208.172])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C84434202C7
	for <drbd-dev@lists.linbit.com>; Mon,  6 Apr 2020 17:25:48 +0200 (CEST)
Received: by mail-lj1-f172.google.com with SMTP id q19so69020ljp.9
	for <drbd-dev@lists.linbit.com>; Mon, 06 Apr 2020 08:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <CANNRee=885eDz9bbcWVLi0_68V9xCufKus_dQMxMpkPaqRZ4sw@mail.gmail.com>
In-Reply-To: <CANNRee=885eDz9bbcWVLi0_68V9xCufKus_dQMxMpkPaqRZ4sw@mail.gmail.com>
From: =?UTF-8?B?16LXqNefINeQ16HXkNeV?= <eranasseo100@gmail.com>
Message-ID: <CANNRee=wxpfbrFBCKuCyquwvvpMbthF66dCHVepdc14Gwc+JTg@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary="000000000000a6780705a2a0e120"
Subject: Re: [Drbd-dev] RHEL 7.6 | 3.10.0-957 | drbd_req.c compilation errors
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
Date: Sat, 13 Jun 2020 09:56:15 -0000

--000000000000a6780705a2a0e120
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
Has anyone encountered the same thing?
(*if I'm using the wrong list please let me know)

Thank you
Eran Asseo

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=93=D7=
=B3, 11 =D7=91=D7=9E=D7=A8=D7=A5 2020 =D7=91-17:24 =D7=9E=D7=90=D7=AA =D7=
=A2=D7=A8=D7=9F =D7=90=D7=A1=D7=90=D7=95 <=E2=80=AAeranasseo100@gmail.com
=E2=80=AC=E2=80=8F>:=E2=80=AC

> Hello experts,
>
> I noticed that some APIs (part_round_stats, part_inc_in_flight) were
> changed in RHEL 7.6 Kernel 3.10.0-957 which drbd_req.c was not aligned to=
.
>
> Do you know if the following patch is correct from DRBD perspective?
>
> https://opendev.org/starlingx/integ/commit/3de433a3b1667c7223702fb9e3e81e=
424cdaedcb
>
> To be more precise I mean only the drbd_req.c changes here:
>
> https://opendev.org/starlingx/integ/src/commit/3de433a3b1667c7223702fb9e3=
e81e424cdaedcb/kernel/kernel-rt/centos/patches/fix-CentOS-7.6-upgrade-compi=
le-error.patch
>
> Would appreciate any help
> Thank you
>
> Regards
> Eran Asseo
>

--000000000000a6780705a2a0e120
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"rtl"><div dir=3D"ltr">Hi</div><div dir=3D"ltr">Has anyone encou=
ntered the same thing?</div><div dir=3D"ltr">(*if I&#39;m using the wrong l=
ist please let me know)</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Th=
ank you</div><div dir=3D"ltr">Eran Asseo<br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"rtl" class=3D"gmail_attr">=E2=80=AB=D7=91=D7=AA=D7=
=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=93=D7=B3, 11 =D7=91=D7=9E=D7=
=A8=D7=A5 2020 =D7=91-17:24 =D7=9E=D7=90=D7=AA =D7=A2=D7=A8=D7=9F =D7=90=D7=
=A1=D7=90=D7=95 &lt;=E2=80=AA<a href=3D"mailto:eranasseo100@gmail.com">eran=
asseo100@gmail.com</a>=E2=80=AC=E2=80=8F&gt;:=E2=80=AC<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div dir=3D"rtl"><div dir=3D"ltr">He=
llo experts,</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">I noticed tha=
t some APIs (<code><span>part_round_stats,</span></code><code><span> part_i=
nc_in_flight</span></code><code><span></span></code>)



were changed in RHEL 7.6 Kernel
3.10.0-957 which drbd_req.c was not aligned to.</div><div dir=3D"ltr"><br><=
/div><div dir=3D"ltr">Do you know if the following patch is correct from DR=
BD perspective?</div><div dir=3D"ltr"><a href=3D"https://opendev.org/starli=
ngx/integ/commit/3de433a3b1667c7223702fb9e3e81e424cdaedcb" target=3D"_blank=
">https://opendev.org/starlingx/integ/commit/3de433a3b1667c7223702fb9e3e81e=
424cdaedcb</a></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">To be more =
precise I mean only the drbd_req.c changes here:</div><div dir=3D"ltr"><a h=
ref=3D"https://opendev.org/starlingx/integ/src/commit/3de433a3b1667c7223702=
fb9e3e81e424cdaedcb/kernel/kernel-rt/centos/patches/fix-CentOS-7.6-upgrade-=
compile-error.patch" target=3D"_blank">https://opendev.org/starlingx/integ/=
src/commit/3de433a3b1667c7223702fb9e3e81e424cdaedcb/kernel/kernel-rt/centos=
/patches/fix-CentOS-7.6-upgrade-compile-error.patch</a></div><div dir=3D"lt=
r"><br></div><div dir=3D"ltr">Would appreciate any help<br></div><div dir=
=3D"ltr">Thank you<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Reg=
ards<br></div><div dir=3D"ltr">Eran Asseo<br></div></div>
</blockquote></div>

--000000000000a6780705a2a0e120--
