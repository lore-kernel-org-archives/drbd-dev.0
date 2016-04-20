Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f53.google.com (mail-vk0-f53.google.com
	[209.85.213.53]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8E76C1056312
	for <drbd-dev@lists.linbit.com>; Wed, 20 Apr 2016 15:52:40 +0200 (CEST)
Received: by mail-vk0-f53.google.com with SMTP id t129so59508727vkg.2
	for <drbd-dev@lists.linbit.com>; Wed, 20 Apr 2016 06:52:40 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 20 Apr 2016 22:52:38 +0900
Message-ID: <CAF6H8oGU7YLGG6nft0cJen5cAgugc1DmzzuwKP=o19x+Z7d3QQ@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=94eb2c12308a21c2e10530eae830
Subject: Re: [Drbd-dev] [CASE-41] After re-connected,
 despite of OOS remaining primary does not start re-synchronization
 or continues AHEAD mode.
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--94eb2c12308a21c2e10530eae830
Content-Type: text/plain; charset=UTF-8

Hi,

This error is not cleared yet!!!

Version: 9.0.2-1
Git: bdcc2a765a9a80c8b263c011a6508cb6e0c3e4d2 [bdcc2a7]

Please check following logs;

1) Primary
    [CASE-41] ahead_primary.txt
    http://pastebin.com/3CkEuKTW


2) Secondary
    [CASE-41] ahead_secondary.txt
    http://pastebin.com/Tdu8tmEV

Thanks.

--94eb2c12308a21c2e10530eae830
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div><div>This error is not cleared yet!=
!!</div><div><br></div><div>Version: 9.0.2-1=C2=A0</div><div>Git: bdcc2a765=
a9a80c8b263c011a6508cb6e0c3e4d2 [bdcc2a7]<br></div><div><br></div><div>Plea=
se check following logs;</div><div><div><br></div><div>1) Primary</div><div=
>=C2=A0 =C2=A0 [CASE-41] ahead_primary.txt=C2=A0</div><div>=C2=A0 =C2=A0 <a=
 href=3D"http://pastebin.com/3CkEuKTW">http://pastebin.com/3CkEuKTW</a></di=
v><div><br></div><div><br></div><div>2) Secondary=C2=A0</div><div>=C2=A0 =
=C2=A0 [CASE-41] ahead_secondary.txt</div><div>=C2=A0 =C2=A0 <a href=3D"htt=
p://pastebin.com/Tdu8tmEV">http://pastebin.com/Tdu8tmEV</a></div></div><div=
><br></div><div>Thanks.</div><div><br></div><div><br></div>
</div></div>

--94eb2c12308a21c2e10530eae830--
