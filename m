Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com
	[209.85.213.43]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BD7EC1056312
	for <drbd-dev@lists.linbit.com>; Wed, 20 Apr 2016 15:54:07 +0200 (CEST)
Received: by mail-vk0-f43.google.com with SMTP id n67so52102640vkf.3
	for <drbd-dev@lists.linbit.com>; Wed, 20 Apr 2016 06:54:07 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 20 Apr 2016 22:54:06 +0900
Message-ID: <CAF6H8oEqB6WZrQPowXGtCKH=iC3mg+WAdSzYBsp9hcG0x=9cnA@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a114408465ab93b0530eaede2
Subject: Re: [Drbd-dev] [CASE-29] After re-connect,
 WFBitMapS-WFBitMapT status has sustained continuously and copy
 command hangs
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

--001a114408465ab93b0530eaede2
Content-Type: text/plain; charset=UTF-8

Hi,


This error is not cleared yet!!!!!!

Version: 9.0.2-1
Git: bdcc2a765a9a80c8b263c011a6508cb6e0c3e4d2 [bdcc2a7]

Please check following logs;

1) Primary
     [CASE-29] wfbitmaps_primary.txt
     http://pastebin.com/UHEPcU7g

2) Secondary
     [CASE-29] wfbitmaps_secondary.txt
     http://pastebin.com/DExWa7dr


Thanks.

--001a114408465ab93b0530eaede2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br><br>This error is not cleared yet!!!!!!<br><br>=
Version: 9.0.2-1 <br>Git: bdcc2a765a9a80c8b263c011a6508cb6e0c3e4d2 [bdcc2a7=
]<br><br>Please check following logs;<br><br>1) Primary<br><div>=C2=A0 =C2=
=A0 =C2=A0[CASE-29] wfbitmaps_primary.txt</div><div>=C2=A0 =C2=A0 =C2=A0<a =
href=3D"http://pastebin.com/UHEPcU7g">http://pastebin.com/UHEPcU7g</a></div=
><br>2) Secondary <br><div>=C2=A0 =C2=A0 =C2=A0[CASE-29] wfbitmaps_secondar=
y.txt</div><div>=C2=A0 =C2=A0 =C2=A0<a href=3D"http://pastebin.com/DExWa7dr=
">http://pastebin.com/DExWa7dr</a></div><div><br></div><br>Thanks.
<div><br></div><div><br></div></div>

--001a114408465ab93b0530eaede2--
