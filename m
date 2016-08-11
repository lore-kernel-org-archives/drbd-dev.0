Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 94FB31028A59
	for <drbd-dev@lists.linbit.com>; Thu, 11 Aug 2016 15:53:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6FD644481F6
	for <drbd-dev@lists.linbit.com>; Thu, 11 Aug 2016 15:53:12 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id xFxYKSNIKuR9 for <drbd-dev@lists.linbit.com>;
	Thu, 11 Aug 2016 15:53:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5107E448205
	for <drbd-dev@lists.linbit.com>; Thu, 11 Aug 2016 15:53:12 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PbvcZA4JwPW5 for <drbd-dev@lists.linbit.com>;
	Thu, 11 Aug 2016 15:53:12 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 2ACEB4481F6
	for <drbd-dev@lists.linbit.com>; Thu, 11 Aug 2016 15:53:12 +0200 (CEST)
Date: Thu, 11 Aug 2016 15:53:11 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160811135311.GC8765@soda.linbit>
References: <CALLFrTQW43=D8kJ4Z+rJV=+Dk4BBOA_0hT1rOxFRcqrBAa0K2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALLFrTQW43=D8kJ4Z+rJV=+Dk4BBOA_0hT1rOxFRcqrBAa0K2A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] Failed to reconnect in different volume's size over
 the 3 nodes
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

On Thu, Aug 11, 2016 at 02:48:38PM +0900, =EB=B0=95=EA=B2=BD=EB=AF=BC wro=
te:
> Hello
>=20
> After 2 commit below
> 585554e drbd: resize: reduce own sanity checks, trust peer
> c09ce4b drbd: resize loop avoidance band-aid
>=20
> It can't reconnect  just in case different volume's size.
> That was only occurred over the 3 nodes configuration.
>=20
> The scenario is below
>=20
> A(100mb) - B(100mb) - C(90mb)
> 1. Success to connect at Inconsistent state
> 2. C node does "Primary --force "
> 3. All nodes agree 90mb size
> 4. C node does down
> 5. A node does down
> 6. A node does up
> 7. A and b agree 100mb size
> 8. C node can't connect because of lower size
>=20
>=20
>=20
> I was looking for the code,and I think it was recalculated forcibly bec=
ause
> below
>=20
> in receive_sizes()
> /* Maybe the peer knows something about peers I cannot currently see. *=
/
> if (is_handshake)
> ddsf |=3D DDSF_FORCED;
>=20

Maybe. Maybe not.
That "force" may not do what you think it does,
or what the name of the flag seems to imply.

Size handshake, and resize, with DRBD 9 and "flaky connections",
is very erratic still. We will have to eventually fix that properly,
maybe by using some extension of the cluster wide transactions we
already have.

 * don't do that, then
 * maybe you want to explicitly set a size limit in the config
 * please send logs of the connection attempts,
   always from all nodes, always time synced.

Thanks,

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=C2=AE and LINBIT=C2=AE are registered trademarks of LINBIT
