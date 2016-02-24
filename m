Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f41.google.com (mail-vk0-f41.google.com
	[209.85.213.41]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 24432105632E
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 07:44:58 +0100 (CET)
Received: by mail-vk0-f41.google.com with SMTP id e185so8369909vkb.1
	for <drbd-dev@lists.linbit.com>; Tue, 23 Feb 2016 22:44:58 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 24 Feb 2016 15:44:56 +0900
Message-ID: <CAF6H8oFsnxUs4FrSSN4a+0qPp6yvy0wWL13jncZBNxNTzrmqgw@mail.gmail.com>
From: =?UTF-8?B?6rmA7J6s7ZeM?= <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a1143f1547697d9052c7e6789
Subject: [Drbd-dev] [CASE-23] please check potential error possibility.
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

--001a1143f1547697d9052c7e6789
Content-Type: text/plain; charset=UTF-8

Hi,

Please check following codes whether potential error or not on version:
9.0.1-1.

1. drbd_pause_after/drbd_resume_next

 - You used disk_state without array index.

#if 1
       if (other_device->disk_state[NOW] == D_DISKLESS) { // new
#else
       if (other_device->disk_state == D_DISKLESS) { // orignal code
#endif


2. drbd_adm_dump_peer_devices/drbd_adm_dump_devices

 - If you run the first "goto put_result;" statement, you should meet
rcu_read_unlock() without rcu_read_lock().
 - Is it no problem?


Thanks.

--001a1143f1547697d9052c7e6789
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Please check following codes whether potential =
error or not on version: 9.0.1-1.<br><br>1. drbd_pause_after/drbd_resume_ne=
xt<div><br>=C2=A0- You used disk_state without array index.<br><br>#if 1<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (other_device-&gt;disk_state[NOW] =3D=3D D_D=
ISKLESS) { // new<br>#else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (other_device-&=
gt;disk_state =3D=3D D_DISKLESS) { // orignal code<br>#endif<br><br><br>2. =
drbd_adm_dump_peer_devices/drbd_adm_dump_devices<br><br>=C2=A0- If you run =
the first &quot;goto put_result;&quot; statement, you should meet rcu_read_=
unlock() without rcu_read_lock().<br>=C2=A0- Is it no problem?<br><br><br>T=
hanks.
</div><div><br></div></div>

--001a1143f1547697d9052c7e6789--
