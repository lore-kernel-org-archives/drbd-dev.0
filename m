Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f53.google.com (mail-vk0-f53.google.com
	[209.85.213.53]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E77351056330
	for <drbd-dev@lists.linbit.com>; Wed,  2 Mar 2016 10:30:18 +0100 (CET)
Received: by mail-vk0-f53.google.com with SMTP id e185so195582684vkb.1
	for <drbd-dev@lists.linbit.com>; Wed, 02 Mar 2016 01:30:18 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 2 Mar 2016 18:30:17 +0900
Message-ID: <CAF6H8oH2bWZBWQYL3ei9MuS4sXCVML5r3j_yfDutU7jo129DmQ@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a11438eaaa9ff01052d0d872d
Subject: [Drbd-dev] [CASE-28] Pause-SyncS color?
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

--001a11438eaaa9ff01052d0d872d
Content-Type: text/plain; charset=UTF-8

Hi,

It's trivial.

On CLI, Pause-SyncT is red color but Pause-SyncS is none.
We think L_PAUSED_SYNC_S is  COLOR_BAD, maybe.
Please check drbd-utils/user/v9/drbdsetup_colors.c

+#ifdef _WIN32_V9
+ [L_PAUSED_SYNC_S] = COLOR_BAD,
+#else
  [L_PAUSED_SYNC_S] = COLOR_NORMAL,
+#endif


Thanks.

--001a11438eaaa9ff01052d0d872d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>It&#39;s trivial.</div><=
div><br></div><div>On CLI, Pause-SyncT is red color but Pause-SyncS is none=
.</div><div>We think L_PAUSED_SYNC_S is =C2=A0COLOR_BAD, maybe.</div><div>P=
lease check drbd-utils/user/v9/drbdsetup_colors.c</div><div><br></div><div>=
+#ifdef _WIN32_V9</div><div>+<span class=3D"" style=3D"white-space:pre">	</=
span>[L_PAUSED_SYNC_S] =3D COLOR_BAD,</div><div>+#else</div><div>=C2=A0<spa=
n class=3D"" style=3D"white-space:pre">	</span>[L_PAUSED_SYNC_S] =3D COLOR_=
NORMAL,</div><div>+#endif</div><div><br></div><div><br></div><div>Thanks.</=
div><div><br></div><div><br></div>
</div>

--001a11438eaaa9ff01052d0d872d--
