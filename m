Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E939A105645E
	for <drbd-dev@lists.linbit.com>; Tue, 20 Sep 2016 09:57:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DCA794206A2
	for <drbd-dev@lists.linbit.com>; Tue, 20 Sep 2016 09:57:09 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9d9f4Zwc_qtR for <drbd-dev@lists.linbit.com>;
	Tue, 20 Sep 2016 09:57:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BF8214206AC
	for <drbd-dev@lists.linbit.com>; Tue, 20 Sep 2016 09:57:09 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4p9txv5oNBf1 for <drbd-dev@lists.linbit.com>;
	Tue, 20 Sep 2016 09:57:09 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 9C9804206A2
	for <drbd-dev@lists.linbit.com>; Tue, 20 Sep 2016 09:57:09 +0200 (CEST)
Date: Tue, 20 Sep 2016 09:57:09 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160920075709.GL3302@soda.linbit>
References: <alpine.LRH.2.11.1609191155210.21602@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.11.1609191155210.21602@mail.ewheeler.net>
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

On Mon, Sep 19, 2016 at 12:09:12PM -0700, Eric Wheeler wrote:
> Hello all,
>=20
> We noticed after resizing one backing device and not the other, that th=
e=20
> side with the larger device issued the following assertion:
>=20
> ASSERT( drbd_md_ss(device->ldev) =3D=3D device->ldev->md.md_offset ) in=
 drbd/obj/default/drbd_main.c:3257
>
> We were issuing a drbdadm resize --assume-clean, but for "reasons", the=
=20
> far-end did not resize. Below you can see the trace of the side issuing=
=20
> assertions. Is this a bug that should be hanadled intelligent way?
>=20
> What does the failed assertion indicate? It appears to assert shortly=20
> after role change to-or-from Primary-or-Secondary.

DRBD is configured for "internal" meta data,
for some reason does some meta data IO, and realizes that someone
resized the backing device under it, without telling it to.

Should not do further harm.

On the box that is logging these asserts,
do a "drbdadm check-resize".

Preferably, you should follow a backend resize immediately
with a drbdadm check-resize (or resize).

> We are using DRBD 8.4.7-2 from git.
>=20
> [576057.341024] block drbd8033: logical block size of local backend doe=
s not match (drbd:512, backend:4096); was this a late attach?
> [576057.343299] block drbd8033: drbd_bm_resize called with capacity =3D=
=3D 21854808
> [576057.344366] block drbd8033: resync bitmap: bits=3D2731851 words=3D4=
2686 pages=3D84
> [576057.345395] block drbd8033: size =3D 10 GB (10927404 KB)
> [576057.381838] block drbd8033: Writing the whole bitmap, size changed
> [576057.382865] block drbd8033: 0 KB (0 bits) marked out-of-sync by on =
disk bit-map.
> [576057.384064] block drbd8033: Resync of new storage suppressed with -=
-assume-clean
> [576061.509044] block drbd8033: logical block size of local backend doe=
s not match (drbd:512, backend:4096); was this a late attach?
> [576911.559399] block drbd8033: role( Primary -> Secondary )=20
> [576911.560677] block drbd8033: 0 KB (0 bits) marked out-of-sync by on =
disk bit-map.
> [662435.411830] block drbd8033: role( Secondary -> Primary )=20
> [663204.542351] block drbd8033: role( Primary -> Secondary )=20
> [663204.543515] block drbd8033: 0 KB (0 bits) marked out-of-sync by on =
disk bit-map.
> [748834.185982] block drbd8033: role( Secondary -> Primary )=20
> [750155.916752] block drbd8033: role( Primary -> Secondary )=20
> [750155.918007] block drbd8033: 0 KB (0 bits) marked out-of-sync by on =
disk bit-map.
> [750155.918768] block drbd8033: ASSERT( drbd_md_ss(device->ldev) =3D=3D=
 device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d=
818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257
> [835228.859747] block drbd8033: role( Secondary -> Primary )=20
> [835228.860996] block drbd8033: ASSERT( drbd_md_ss(device->ldev) =3D=3D=
 device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d=
818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
