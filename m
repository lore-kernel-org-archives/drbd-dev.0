Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5E9011056330
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 14:50:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4CA652A8250
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 14:50:09 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id HXstOqjVOMrL for <drbd-dev@lists.linbit.com>;
	Wed, 24 Feb 2016 14:50:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2F0203FC169
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 14:50:09 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F-kb4UYy46tH for <drbd-dev@lists.linbit.com>;
	Wed, 24 Feb 2016 14:50:09 +0100 (CET)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id E640F2A8250
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 14:50:08 +0100 (CET)
Date: Wed, 24 Feb 2016 14:50:07 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160224135005.GL1621@rck.sh>
References: <CAF6H8oFsnxUs4FrSSN4a+0qPp6yvy0wWL13jncZBNxNTzrmqgw@mail.gmail.com>
	<20160224095617.GK1621@rck.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160224095617.GK1621@rck.sh>
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

On Wed, Feb 24, 2016 at 10:56:18AM +0100, Roland Kammerer wrote:
> On Wed, Feb 24, 2016 at 03:44:56PM +0900, =EA=B9=80=EC=9E=AC=ED=97=8C w=
rote:
> > Hi,
> >=20
> > Please check following codes whether potential error or not on versio=
n:
> > 9.0.1-1.
> >=20
> > 1. drbd_pause_after/drbd_resume_next
> >=20
> >  - You used disk_state without array index.
> >=20
> > #if 1
> >        if (other_device->disk_state[NOW] =3D=3D D_DISKLESS) { // new
> > #else
> >        if (other_device->disk_state =3D=3D D_DISKLESS) { // orignal c=
ode
> > #endif
> >=20
> >=20
> > 2. drbd_adm_dump_peer_devices/drbd_adm_dump_devices
> >=20
> >  - If you run the first "goto put_result;" statement, you should meet
> > rcu_read_unlock() without rcu_read_lock().
> >  - Is it no problem?
>=20
> Hi,
>=20
> I think you are right in both cases, I prepared fixes, which are
> currently under review...

http://git.linbit.com/drbd-9.0.git/commitdiff/89fc34d91724c402c64e9f8cd7d=
7d92058abf0ed
and
http://git.linbit.com/drbd-9.0.git/commitdiff/3cd85d42444749166d04d1f8ffc=
ea25c7e9add04

Thanks again, rck
