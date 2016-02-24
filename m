Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com
	[209.85.213.49]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 43B111056333
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 08:17:34 +0100 (CET)
Received: by mail-vk0-f49.google.com with SMTP id k196so9081478vka.0
	for <drbd-dev@lists.linbit.com>; Tue, 23 Feb 2016 23:17:34 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 24 Feb 2016 16:17:33 +0900
Message-ID: <CAF6H8oF0tGttLow+9ixDrQmPpPkQWNg1RLFobndM0h9qQRoXMA@mail.gmail.com>
From: =?UTF-8?B?6rmA7J6s7ZeM?= <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a114325ec10644d052c7edc41
Subject: [Drbd-dev] [CASE-25] Please check ko_count initialization
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

--001a114325ec10644d052c7edc41
Content-Type: text/plain; charset=UTF-8

Hi,

When the send error occurs, ko_count is too big.

Log at timeout situation:

  38754 Feb 19 16:00:04 drbd9-01 kernel: drbd r0 drbd9-03:
[drbd_s_r0/35252] sending time expired, ko = 4294953383
  38755 Feb 19 16:00:10 drbd9-01 kernel: drbd r0 drbd9-03:
[drbd_s_r0/35252] sending time expired, ko = 4294953382
  38756 Feb 19 16:00:16 drbd9-01 kernel: drbd r0 drbd9-03:
[drbd_s_r0/35252] sending time expired, ko = 4294953381
  38757 Feb 19 16:00:22 drbd9-01 kernel: drbd r0 drbd9-03:
[drbd_s_r0/35252] sending time expired, ko = 4294953380
  38758 Feb 19 16:00:28 drbd9-01 kernel: drbd r0 drbd9-03:
[drbd_s_r0/35252] sending time expired, ko = 4294953379
  38759 Feb 19 16:00:34 drbd9-01 kernel: drbd r0 drbd9-03:
[drbd_s_r0/35252] sending time expired, ko = 4294953378
  38760 Feb 19 16:00:40 drbd9-01 kernel: drbd r0 drbd9-03:
[drbd_s_r0/35252] sending time expired, ko = 4294953377
  38761 Feb 19 16:00:46 drbd9-01 kernel: drbd r0 drbd9-03:
[drbd_s_r0/35252] sending time expired, ko = 4294953376
  38762 Feb 19 16:00:52 drbd9-01 kernel: drbd r0 drbd9-03:
[drbd_s_r0/35252] sending time expired, ko = 4294953375
  38763 Feb 19 16:00:58 drbd9-01 kernel: drbd r0 drbd9-03:
[drbd_s_r0/35252] sending time expired, ko = 4294953374

Resolution:
 - At dtt_send_page function, we insert ko-count initialization code before
socket->ops->sendpage() like this;

     if (stream == DATA_STREAM)
     {
         transport->ko_count = transport->net_conf->ko_count;
     }

Please check.

Thanks.

--001a114325ec10644d052c7edc41
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><div><br></div><div>When the send error =
occurs, ko_count is too big.</div><div><br></div><div>Log at timeout situat=
ion:</div><div><br></div><div>=C2=A0 38754 Feb 19 16:00:04 drbd9-01 kernel:=
 drbd r0 drbd9-03: [drbd_s_r0/35252] sending time expired, ko =3D 429495338=
3</div><div>=C2=A0 38755 Feb 19 16:00:10 drbd9-01 kernel: drbd r0 drbd9-03:=
 [drbd_s_r0/35252] sending time expired, ko =3D 4294953382</div><div>=C2=A0=
 38756 Feb 19 16:00:16 drbd9-01 kernel: drbd r0 drbd9-03: [drbd_s_r0/35252]=
 sending time expired, ko =3D 4294953381</div><div>=C2=A0 38757 Feb 19 16:0=
0:22 drbd9-01 kernel: drbd r0 drbd9-03: [drbd_s_r0/35252] sending time expi=
red, ko =3D 4294953380</div><div>=C2=A0 38758 Feb 19 16:00:28 drbd9-01 kern=
el: drbd r0 drbd9-03: [drbd_s_r0/35252] sending time expired, ko =3D 429495=
3379</div><div>=C2=A0 38759 Feb 19 16:00:34 drbd9-01 kernel: drbd r0 drbd9-=
03: [drbd_s_r0/35252] sending time expired, ko =3D 4294953378</div><div>=C2=
=A0 38760 Feb 19 16:00:40 drbd9-01 kernel: drbd r0 drbd9-03: [drbd_s_r0/352=
52] sending time expired, ko =3D 4294953377</div><div>=C2=A0 38761 Feb 19 1=
6:00:46 drbd9-01 kernel: drbd r0 drbd9-03: [drbd_s_r0/35252] sending time e=
xpired, ko =3D 4294953376</div><div>=C2=A0 38762 Feb 19 16:00:52 drbd9-01 k=
ernel: drbd r0 drbd9-03: [drbd_s_r0/35252] sending time expired, ko =3D 429=
4953375</div><div>=C2=A0 38763 Feb 19 16:00:58 drbd9-01 kernel: drbd r0 drb=
d9-03: [drbd_s_r0/35252] sending time expired, ko =3D 4294953374</div><div>=
<br></div><div>Resolution:</div><div>=C2=A0- At dtt_send_page function, we =
insert ko-count initialization code before socket-&gt;ops-&gt;sendpage() li=
ke this;</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0if (stream =3D=3D DAT=
A_STREAM)</div><div>=C2=A0 =C2=A0 =C2=A0{</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0transport-&gt;ko_count =3D transport-&gt;net_conf-&gt;ko_count=
;</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div><br></div><div>Please check.</d=
iv><div><br></div><div>Thanks.</div><div><br></div>
</div>

--001a114325ec10644d052c7edc41--
