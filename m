Return-Path: <tjyang2001@gmail.com>
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
	[209.85.208.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 41EDB420005
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2020 17:33:21 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id v6so13528729edw.8
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2020 09:33:21 -0700 (PDT)
MIME-Version: 1.0
From: "T.J. Yang" <tjyang2001@gmail.com>
Message-ID: <CAD2GW8rEcO0rYaFbi3y8FC3ps7koyyN_ihvHZ8iRGrps_=-TFQ@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary="0000000000009e484905a174134b"
Subject: [Drbd-dev] Lower MIN_SPATCH_VERSION to 1.0.7 ?
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
Date: Sun, 22 Mar 2020 16:33:22 -0000

--0000000000009e484905a174134b
Content-Type: text/plain; charset="UTF-8"

Hi

Can MIN_SPATCH_VERSION be set to 1.0.7 in upstream code base ?

CentOS 8 only have rpm package(coccinelle) for version 1.0.7.
With version 1.0.7 set, I was able to make drbd.

[me@centos8t01 drbd]$ grep MIN_SPATCH_VERSION=
 drbd-kernel-compat/gen_compat_patch.sh
MIN_SPATCH_VERSION=1.0.7
[me@centos8t01 drbd]$ make

    Calling toplevel makefile of kernel source tree, which I believe is in
    KDIR=/lib/modules/4.18.0-187.el8.x86_64/source

make -C /lib/modules/4.18.0-187.el8.x86_64/source
 O=/lib/modules/4.18.0-187.el8.x86_64/build M=/build/me/github/drbd/drbd
 modules
  Building modules, stage 2.
  MODPOST 2 modules
mv .drbd_kernelrelease.new .drbd_kernelrelease
Memorizing module configuration ... done.
[me@centos8t01 drbd]$

-- 
T.J. Yang

--0000000000009e484905a174134b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0<div><br></div><div>Can=C2=A0MIN_SPATCH_VERSION be=
 set to 1.0.7 in upstream code base ?=C2=A0</div><div><br></div><div>CentOS=
 8 only have rpm package(coccinelle) for version 1.0.7.</div><div>With vers=
ion 1.0.7 set, I was able to make drbd.=C2=A0</div><div><br></div><div>[me@=
centos8t01 drbd]$ grep MIN_SPATCH_VERSION=3D =C2=A0 =C2=A0drbd-kernel-compa=
t/gen_compat_patch.sh<br>MIN_SPATCH_VERSION=3D1.0.7<br></div><div>[me@cento=
s8t01 drbd]$ make<br><br>=C2=A0 =C2=A0 Calling toplevel makefile of kernel =
source tree, which I believe is in<br>=C2=A0 =C2=A0 KDIR=3D/lib/modules/4.1=
8.0-187.el8.x86_64/source<br><br>make -C /lib/modules/4.18.0-187.el8.x86_64=
/source =C2=A0O=3D/lib/modules/4.18.0-187.el8.x86_64/build M=3D/build/me/gi=
thub/drbd/drbd =C2=A0modules<br>=C2=A0 Building modules, stage 2.<br>=C2=A0=
 MODPOST 2 modules<br>mv .drbd_kernelrelease.new .drbd_kernelrelease<br>Mem=
orizing module configuration ... done.<br>[me@centos8t01 drbd]$<br><div><br=
></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"=
gmail_signature">T.J. Yang</div></div></div>

--0000000000009e484905a174134b--
