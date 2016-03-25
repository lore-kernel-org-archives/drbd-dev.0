Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com
	[209.85.213.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8E1951056332
	for <drbd-dev@lists.linbit.com>; Fri, 25 Mar 2016 11:30:30 +0100 (CET)
Received: by mail-vk0-f54.google.com with SMTP id e185so87678103vkb.1
	for <drbd-dev@lists.linbit.com>; Fri, 25 Mar 2016 03:30:30 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 25 Mar 2016 19:30:29 +0900
Message-ID: <CAF6H8oGVdkia=A4eHTnHtR3FeBkQbhWL8C7j3_4a=w42Ghvifg@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a114408da4e48a3052edd0d84
Subject: [Drbd-dev] [CASE-35] Please check double auto-increment on
	history_uuids[i++].
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

--001a114408da4e48a3052edd0d84
Content-Type: text/plain; charset=UTF-8

Hi,

According to the following code, local i variable be incremented by twice
in one loop.
Is this auto-increment operation no problem?


receive_uuids110()
{
    ...
    for (i = 0; i < history_uuids; i++)
         peer_device->history_uuids[i++] =
be64_to_cpu(p->other_uuids[pos++]);
    ...
}

Thanks.

--001a114408da4e48a3052edd0d84
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>According to the following code, local i variab=
le be incremented by twice in one loop.<div>Is this auto-increment operatio=
n no problem?<br><br><br>receive_uuids110()<br>{<br>=C2=A0 =C2=A0 ...<br>=
=C2=A0 =C2=A0 for (i =3D 0; i &lt; history_uuids; i++)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0peer_device-&gt;history_uuids[i++] =3D be64_to_cpu(p-&gt;o=
ther_uuids[pos++]);</div><div>=C2=A0 =C2=A0 ...<br>}
<div><br></div><div>Thanks.</div><div><br></div><div><br></div></div></div>

--001a114408da4e48a3052edd0d84--
