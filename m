Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com
	[209.85.213.43]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6BC141056420
	for <drbd-dev@lists.linbit.com>; Fri, 26 Feb 2016 14:08:19 +0100 (CET)
Received: by mail-vk0-f43.google.com with SMTP id e185so76400311vkb.1
	for <drbd-dev@lists.linbit.com>; Fri, 26 Feb 2016 05:08:19 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 26 Feb 2016 22:08:17 +0900
Message-ID: <CAF6H8oHdbhM3x160NjnCLb=-GfKvNeXkh5M0-T_0Zs17fFVq1A@mail.gmail.com>
From: =?UTF-8?B?6rmA7J6s7ZeM?= <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a114408461ae424052cabfe67
Subject: [Drbd-dev] [CASE-27] please check trivial code cleanup
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

--001a114408461ae424052cabfe67
Content-Type: text/plain; charset=UTF-8

Hi,

Please check your macro in drbd/drbd_int.h

    #define for_each_peer_device_ref(peer_device, m, resource) \
         for (peer_device = __drbd_next_peer_device_ref(&m, NULL,
resource); \
              peer_device; \
              peer_device = __drbd_next_peer_device_ref(&m, peer_device,
resource))

We think the "resource" should be changed to "device".

Thanks.

--001a114408461ae424052cabfe67
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Please check your macro in drbd/drbd_int.h<br><=
br>=C2=A0 =C2=A0 #define for_each_peer_device_ref(peer_device, m, resource)=
 \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (peer_device =3D __drbd_next_pe=
er_device_ref(&amp;m, NULL, resource); \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 peer_device; \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 peer_device =3D __drbd_next_peer_device_ref(&amp;m, peer_device,=
 resource))<br><br>We think the &quot;resource&quot; should be changed to &=
quot;device&quot;.<br><br>Thanks.<div><br></div>
</div>

--001a114408461ae424052cabfe67--
