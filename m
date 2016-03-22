Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D9E491051881
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:25:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CAA00406FD0
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:25:18 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id z8PrIwVsG9j3 for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:25:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id AE11F406FD1
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:25:18 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 00LH5fCYHeuQ for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:25:18 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 5DCD9406FD0
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:25:18 +0100 (CET)
Date: Tue, 22 Mar 2016 11:25:17 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160322102517.GG4437@soda.linbit>
References: <20160321231817.GI30157@schiffbauer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20160321231817.GI30157@schiffbauer.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] integer signedness mixup problem in drbd_main.c
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

On Tue, Mar 22, 2016 at 12:18:17AM +0100, Marc Schiffbauer wrote:
> hi all,
>=20
> using a kernel hardened with grsecurity/PaX we discovered a problem=20
> where PaX detects a size overflow after a quite large uptime:
>=20
> PAX: size overflow detected in function drbd_send_dblock=20
> drivers/block/drbd/drbd_main.c:1625 cicus.964_133 max, count: 1
>=20
> this was in kernel 3.14.19, but 4.4.5 still seems to have that problem.=
 =20
> The line triggering this is:
>=20
> p->seq_num =3D cpu_to_be32(atomic_inc_return_unchecked(&mdev->packet_se=
q));

Boring.
seq_num should give it away: it is a sequence number.
it wraps. that's what sequence numbers do, eventually.

haven't we been here before?


--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
