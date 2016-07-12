Return-Path: <P.Miedzik@gsi.de>
Received: from lxmtout2.gsi.de (lxmtout2.gsi.de [140.181.3.112])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BECAF105633A
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jul 2016 10:53:12 +0200 (CEST)
From: "Miedzik, Piotr Bogdan" <P.Miedzik@gsi.de>
To: 'Lars Ellenberg' <lars.ellenberg@linbit.com>, "drbd-dev@lists.linbit.com"
	<drbd-dev@lists.linbit.com>
Date: Tue, 12 Jul 2016 08:53:10 +0000
Message-ID: <B7D370631C221640AE09F705C57A14F3732A2327@W2K050.campus.gsi.de>
References: <B7D370631C221640AE09F705C57A14F37329FAF0@W2K050.campus.gsi.de>
	<B7D370631C221640AE09F705C57A14F3732A0E50@W2K050.campus.gsi.de>
	<20160711162734.GC13335@soda.linbit>
In-Reply-To: <20160711162734.GC13335@soda.linbit>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Drbd-dev] [PATCH] drbd.ocf: drbdsetup v9 has no sh-status
 command
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

I realized that so I've written new script (https://github.com/qermit/drbd-=
utils/blob/master/scripts/drbd9.ocf) based on stateful OCF example, Filesys=
tem and drbd.ocf=20

The main difference to an original drbd.ocf is:
- it should not fail (or become unmanaged) when it's defined as a normal re=
source.
- each resource has its own debug level and debug file
- does not relay on drbdsetup sh-status
- creates .enable.${resourcename} file to cope with drbdmanage
- allows to have more than 2 clones

I find drbdmanage very nice tool but it causes some problems with pcs start=
/stop actions. It would be nice to have something like promotion type param=
eter (auto/manual/disabled).

Regards

> -----Original Message-----
> From: drbd-dev-bounces@lists.linbit.com [mailto:drbd-dev-
> bounces@lists.linbit.com] On Behalf Of Lars Ellenberg
> Sent: 11 lipca 2016 18:28
> To: drbd-dev@lists.linbit.com
> Subject: Re: [Drbd-dev] [PATCH] drbd.ocf: drbdsetup v9 has no sh-status
> command
>=20
> On Fri, Jul 08, 2016 at 11:26:52AM +0000, Miedzik, Piotr Bogdan wrote:
> > I've found mistake in drbd.ocf in line 1045 anyway.
> > Kernel module version should be checked in opposite order.
>=20
> That's not the only thing missing wrt drbd 9 and pacemaker integration.
>=20
> I have some unfinished work around, which eventually will find its way
> into the repositories and packages "soon".
>=20
> But for now, it's unfinished :-|
>=20
> --
> : Lars Ellenberg
> : LINBIT | Keeping the Digital World Running
> : DRBD -- Heartbeat -- Corosync -- Pacemaker
> : R&D, Integration, Ops, Consulting, Support
>=20
> DRBD(r) and LINBIT(r) are registered trademarks of LINBIT
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
