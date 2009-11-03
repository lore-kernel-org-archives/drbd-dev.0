Return-Path: <Simon.Graham@stratus.com>
Received: from mailhub5.stratus.com (mailhub5.stratus.com [134.111.1.18])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5DDC714221E4
	for <drbd-dev@lists.linbit.com>; Tue,  3 Nov 2009 04:48:03 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 2 Nov 2009 22:47:54 -0500
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C9390DA7@EXHQ.corp.stratus.com>
In-Reply-To: 20091102224223.GE14841@barkeeper1-xen.linbit
References: <BC2F8964429F14468EA0E6D6CF00E8C9390D66@EXHQ.corp.stratus.com>
	20091102224223.GE14841@barkeeper1-xen.linbit
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] Primary/Diskless node cannot reconnect
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> 8.2 is dead.

Hmmm... it hasn't stopped moving yet... are you saying you won't make
any more fixes to it?=20


> has been fixed differently in 8.3 already,
> where the corresponding code looks like
>=20
>  if (mdev->state.conn < C_CONNECTED &&
>             mdev->state.disk < D_INCONSISTENT &&
>             mdev->state.role =3D=3D R_PRIMARY &&
>             (mdev->ed_uuid & ~((u64)1)) !=3D (p_uuid[UI_CURRENT] &
> ~((u64)1))) {
>=20

I must admit I haven't looked at 8.3 in any detail yet but that code you
quote looks suspiciously like the 8.2 code to me -- D_DISKLESS is still
a value less than D_INCONSISTENT...

Shouldn't this be:

  if (mdev->state.conn < C_CONNECTED &&
             mdev->state.disk > D_DISKLESS &&
             mdev->state.disk < D_INCONSISTENT &&
             mdev->state.role =3D=3D R_PRIMARY &&
             (mdev->ed_uuid & ~((u64)1)) !=3D (p_uuid[UI_CURRENT] &
~((u64)1))) {

To fix this same issue???
Simon
