Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1C5FD105648E
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 11:46:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 039274259D8
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 11:46:46 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id RDm8Tdzh8WiV for <drbd-dev@lists.linbit.com>;
	Mon, 26 Sep 2016 11:46:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D85B6425A21
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 11:46:45 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d7OlFTNxE2fE for <drbd-dev@lists.linbit.com>;
	Mon, 26 Sep 2016 11:46:45 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id B0B514259D8
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 11:46:45 +0200 (CEST)
Date: Mon, 26 Sep 2016 11:46:45 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160926094645.GZ3302@soda.linbit>
References: <alpine.LRH.2.11.1609191155210.21602@mail.ewheeler.net>
	<20160920075709.GL3302@soda.linbit>
	<alpine.LRH.2.11.1609231457310.29933@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.11.1609231457310.29933@mail.ewheeler.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] ASSERT( drbd_md_ss(device->ldev) ==
 device->ldev->md.md_offset )
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

On Fri, Sep 23, 2016 at 03:01:11PM -0700, Eric Wheeler wrote:
> On Tue, 20 Sep 2016, Lars Ellenberg wrote:
>=20
> > On Mon, Sep 19, 2016 at 12:09:12PM -0700, Eric Wheeler wrote:
> > > Hello all,
> > >=20
> > > We noticed after resizing one backing device and not the other, tha=
t the=20
> > > side with the larger device issued the following assertion:
> > >=20
> > > ASSERT( drbd_md_ss(device->ldev) =3D=3D device->ldev->md.md_offset =
) in drbd/obj/default/drbd_main.c:3257
> > >
> > > We were issuing a drbdadm resize --assume-clean, but for "reasons",=
 the=20
> > > far-end did not resize. Below you can see the trace of the side iss=
uing=20
> > > assertions. Is this a bug that should be hanadled intelligent way?
> > >=20
> > > What does the failed assertion indicate? It appears to assert short=
ly=20
> > > after role change to-or-from Primary-or-Secondary.
> >=20
> > DRBD is configured for "internal" meta data,
> > for some reason does some meta data IO, and realizes that someone
> > resized the backing device under it, without telling it to.
> >=20
> > Should not do further harm.
>=20
> "Further" ?  Was there any harm (corruption) in the first place?

Spamming your logs ;)

> > On the box that is logging these asserts,
> > do a "drbdadm check-resize".
> >=20
> > Preferably, you should follow a backend resize immediately
> > with a drbdadm check-resize (or resize).
>=20
> Is `drbdadm check-resize` a node-local operation?  Does it move metadat=
a=20
> to the end on both sides, or only on the side invoking check-resize?

Depends on whether or not you have a user set size limit configured.

"check-resize" tells DRBD to check for possible backend resize,
and to move its meta data to where it would expect it
if it would attach now.

After the meta data was moved,
we send our new backend size, current exposed size,
and user capped size if any, to the peer.
Which will take the hint and itself double-check
if it's backend has been resized,
if so, do the same (see above).

Also, whenever we receive such size tuples, we check if it would allow
us to agree on a new size, and if so, do it right there.

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
