Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com
	[209.85.213.50]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4ADB61056331
	for <drbd-dev@lists.linbit.com>; Sun, 10 Apr 2016 15:32:04 +0200 (CEST)
Received: by mail-vk0-f50.google.com with SMTP id c4so184280989vkb.3
	for <drbd-dev@lists.linbit.com>; Sun, 10 Apr 2016 06:32:04 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 10 Apr 2016 22:32:03 +0900
Message-ID: <CAF6H8oGA684AhAaxEwK_0jrtjK2C2ks16v05gtJKD7unba=MLw@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a114325ec1838c60530217419
Subject: [Drbd-dev] [CASE-40] Why does "ASSERT:
	list_empty(&device->done_ee)" occur?
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

--001a114325ec1838c60530217419
Content-Type: text/plain; charset=UTF-8

Dear Phil,


Sometimes, the Linux /var/log/messages has as following;

/var/log/messages:Feb 27 15:32:29 drbd9-01 kernel: drbd r0/0 drbd1:
ASSERTION list_empty(&device->read_ee) FAILED in drbd_disconnected

I think this ASSERT has a little problem.
What do you think about it?

Thanks.

--001a114325ec1838c60530217419
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Dear Phil,<br></div><div><br></div><div><br></di=
v><div>Sometimes, the Linux /var/log/messages has as following;</div><div><=
br></div><div>/var/log/messages:Feb 27 15:32:29 drbd9-01 kernel: drbd r0/0 =
drbd1: ASSERTION list_empty(&amp;device-&gt;read_ee) FAILED in drbd_disconn=
ected</div><div><br></div><div>I think this ASSERT has a little problem.=C2=
=A0</div><div>What do you think about it?</div><div><br></div><div>Thanks.<=
/div></div>
</div>

--001a114325ec1838c60530217419--
