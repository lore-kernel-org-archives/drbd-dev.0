Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 137934203D6
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:55:26 +0200 (CEST)
Received: by mail-wm1-f68.google.com with SMTP id b82so1522224wmb.1
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:55:26 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	88sm15234900wre.45.2020.06.13.02.55.25
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:55:25 -0700 (PDT)
Resent-Message-ID: <20200613095524.GB4222@soda.linbit>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9EC624203DE
	for <drbd-dev@lists.linbit.com>; Wed, 11 Mar 2020 16:56:53 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id n15so3263700wrw.13
	for <drbd-dev@lists.linbit.com>; Wed, 11 Mar 2020 08:56:53 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?16LXqNefINeQ16HXkNeV?= <eranasseo100@gmail.com>
Message-ID: <CANNRee=885eDz9bbcWVLi0_68V9xCufKus_dQMxMpkPaqRZ4sw@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary="00000000000072a34e05a095d4a9"
Subject: [Drbd-dev] RHEL 7.6 | 3.10.0-957 | drbd_req.c compilation errors
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
Date: Sat, 13 Jun 2020 09:55:40 -0000

--00000000000072a34e05a095d4a9
Content-Type: text/plain; charset="UTF-8"

Hello experts,

I noticed that some APIs (part_round_stats, part_inc_in_flight) were
changed in RHEL 7.6 Kernel 3.10.0-957 which drbd_req.c was not aligned to.

Do you know if the following patch is correct from DRBD perspective?
https://opendev.org/starlingx/integ/commit/3de433a3b1667c7223702fb9e3e81e424cdaedcb

To be more precise I mean only the drbd_req.c changes here:
https://opendev.org/starlingx/integ/src/commit/3de433a3b1667c7223702fb9e3e81e424cdaedcb/kernel/kernel-rt/centos/patches/fix-CentOS-7.6-upgrade-compile-error.patch

Would appreciate any help
Thank you

Regards
Eran Asseo

--00000000000072a34e05a095d4a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"rtl"><div dir=3D"ltr">Hello experts,</div><div dir=3D"ltr"><br>=
</div><div dir=3D"ltr">I noticed that some APIs (<code class=3D"gmail-diff =
gmail-hljs"><span class=3D"gmail-hljs-addition">part_round_stats,</span></c=
ode><code class=3D"gmail-diff gmail-hljs"><span class=3D"gmail-hljs-additio=
n"> part_inc_in_flight</span></code><code class=3D"gmail-diff gmail-hljs"><=
span class=3D"gmail-hljs-addition"></span></code>)



were changed in RHEL 7.6 Kernel
3.10.0-957 which drbd_req.c was not aligned to.</div><div dir=3D"ltr"><br><=
/div><div dir=3D"ltr">Do you know if the following patch is correct from DR=
BD perspective?</div><div dir=3D"ltr"><a href=3D"https://opendev.org/starli=
ngx/integ/commit/3de433a3b1667c7223702fb9e3e81e424cdaedcb">https://opendev.=
org/starlingx/integ/commit/3de433a3b1667c7223702fb9e3e81e424cdaedcb</a></di=
v><div dir=3D"ltr"><br></div><div dir=3D"ltr">To be more precise I mean onl=
y the drbd_req.c changes here:</div><div dir=3D"ltr"><a href=3D"https://ope=
ndev.org/starlingx/integ/src/commit/3de433a3b1667c7223702fb9e3e81e424cdaedc=
b/kernel/kernel-rt/centos/patches/fix-CentOS-7.6-upgrade-compile-error.patc=
h">https://opendev.org/starlingx/integ/src/commit/3de433a3b1667c7223702fb9e=
3e81e424cdaedcb/kernel/kernel-rt/centos/patches/fix-CentOS-7.6-upgrade-comp=
ile-error.patch</a></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Would =
appreciate any help<br></div><div dir=3D"ltr">Thank you<br></div><div dir=
=3D"ltr"><br></div><div dir=3D"ltr">Regards<br></div><div dir=3D"ltr">Eran =
Asseo<br></div></div>

--00000000000072a34e05a095d4a9--
