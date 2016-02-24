Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com
	[209.85.213.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8658C1056333
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 08:04:13 +0100 (CET)
Received: by mail-vk0-f42.google.com with SMTP id c3so8628228vkb.3
	for <drbd-dev@lists.linbit.com>; Tue, 23 Feb 2016 23:04:13 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 24 Feb 2016 16:04:11 +0900
Message-ID: <CAF6H8oFkGOr-=Uej1fR5JZxh47UPNzF-Dc2Va4p6ZpUcmwip6A@mail.gmail.com>
From: =?UTF-8?B?6rmA7J6s7ZeM?= <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a114318c84dd315052c7eac2c
Subject: [Drbd-dev] [CASE-24] Does replication have to wait until the end of
	handler service?
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

--001a114318c84dd315052c7eac2c
Content-Type: text/plain; charset=UTF-8

Hi,

Conf:
 - A(Async) or C(sync) replication mode
 - setup before-resync-source( this handler sleeps just 1 minute)

Test:
 - 1) Big file copy
 - 2) During copy,disconnect and connect
 - 3) before-resync-source handler called
 - 4) At this point copy operation is pending until handler finished.

Is it normal operation?

Thanks.

--001a114318c84dd315052c7eac2c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Conf:<br>=C2=A0- A(Async) or C(sync) replicatio=
n mode<br>=C2=A0- setup before-resync-source( this handler sleeps just 1 mi=
nute)<br>=C2=A0<br>Test:<br>=C2=A0- 1) Big file copy<br>=C2=A0- 2) During c=
opy,disconnect and connect<br>=C2=A0- 3) before-resync-source handler calle=
d<br>=C2=A0- 4) At this point copy operation is pending until handler finis=
hed.<br><br>Is it normal operation?<br><br>Thanks.<div><br></div>
</div>

--001a114318c84dd315052c7eac2c--
