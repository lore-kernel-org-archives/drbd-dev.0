Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E2435104B1A2
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 10:56:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CDEB73E759F
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 10:56:19 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id IuKpBQc6JgeK for <drbd-dev@lists.linbit.com>;
	Wed, 24 Feb 2016 10:56:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id AFFEC3E7E84
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 10:56:19 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0YkFuAygH5O1 for <drbd-dev@lists.linbit.com>;
	Wed, 24 Feb 2016 10:56:19 +0100 (CET)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 7F7BB3E759F
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 10:56:19 +0100 (CET)
Date: Wed, 24 Feb 2016 10:56:18 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160224095617.GK1621@rck.sh>
References: <CAF6H8oFsnxUs4FrSSN4a+0qPp6yvy0wWL13jncZBNxNTzrmqgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF6H8oFsnxUs4FrSSN4a+0qPp6yvy0wWL13jncZBNxNTzrmqgw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [CASE-23] please check potential error possibility.
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

On Wed, Feb 24, 2016 at 03:44:56PM +0900, =EA=B9=80=EC=9E=AC=ED=97=8C wro=
te:
> Hi,
>=20
> Please check following codes whether potential error or not on version:
> 9.0.1-1.
>=20
> 1. drbd_pause_after/drbd_resume_next
>=20
>  - You used disk_state without array index.
>=20
> #if 1
>        if (other_device->disk_state[NOW] =3D=3D D_DISKLESS) { // new
> #else
>        if (other_device->disk_state =3D=3D D_DISKLESS) { // orignal cod=
e
> #endif
>=20
>=20
> 2. drbd_adm_dump_peer_devices/drbd_adm_dump_devices
>=20
>  - If you run the first "goto put_result;" statement, you should meet
> rcu_read_unlock() without rcu_read_lock().
>  - Is it no problem?

Hi,

I think you are right in both cases, I prepared fixes, which are
currently under review...

Regards, rck
