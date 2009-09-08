Return-Path: <pjd@garage.freebsd.pl>
Received: from mail.garage.freebsd.pl (ghf60.internetdsl.tpnet.pl
	[83.12.187.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7C1841011C09
	for <drbd-dev@lists.linbit.com>; Tue,  8 Sep 2009 11:24:49 +0200 (CEST)
Received: from localhost (pdawidek.wheel.pl [10.0.1.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.garage.freebsd.pl (Postfix) with ESMTP id 7928245683
	for <drbd-dev@lists.linbit.com>; Tue,  8 Sep 2009 11:06:19 +0200 (CEST)
Date: Tue, 8 Sep 2009 11:06:21 +0200
From: Pawel Jakub Dawidek <pjd@FreeBSD.org>
To: drbd-dev@lists.linbit.com
Message-ID: <20090908090621.GD1577@garage.freebsd.pl>
References: <20090904142717.GD1610@garage.freebsd.pl>
	<20090908090249.GB8037@barkeeper1-xen.linbit>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <20090908090249.GB8037@barkeeper1-xen.linbit>
Subject: Re: [Drbd-dev] DRBD and FreeBSD.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2009 at 11:02:49AM +0200, Lars Ellenberg wrote:
> On Fri, Sep 04, 2009 at 04:27:17PM +0200, Pawel Jakub Dawidek wrote:
> > Hi.
> >=20
> > I'm going to work on similar functionality to DRBD, although I plan to
> > start with something simple (only master-slave mode, only
> > quasi-synchronous replication).
> >=20
> > I was looking at DRBD source code, but I'm afraid the code is too
> > Linux-specific, so I won't be able to port it.
>=20
> Sorry about that.
> So GPL'ed kernel modules would be compatible with BSD?

Yes, there are quite a few of them in FreeBSD's base system (at least
GPLv2, not sure about v3). Although we warn users about that fact at
kernel compile-time, I think:)

> > I'd still be happy to exchange ideas, etc. I just subscribed to
> > drbd-dev@, but I was wondering if DRBD developers hang on IRC maybe,
> > so there is more direct contact?
>=20
> Sometimes we join various channels on freenode,
> but usually we don't really hang out there,
> as we typically can shout accross the room ;)
> But feel free to post any ideas or suggestions to drbd-dev.

Ok, thanks for the reply.

--=20
Pawel Jakub Dawidek                       http://www.wheel.pl
pjd@FreeBSD.org                           http://www.FreeBSD.org
FreeBSD committer                         Am I Evil? Yes, I Am!

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (FreeBSD)

iD8DBQFKph6NForvXbEpPzQRAo7yAKC2h3VVtuvPruQ/OtlP1f0UwYR1jgCcDYR+
O/nVezBP+Z3h85NwtyoTa0o=
=R4ED
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
