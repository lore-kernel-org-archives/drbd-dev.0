Return-Path: <pawel@dawidek.net>
Received: from mail.dawidek.net (60.wheelsystems.com [83.12.187.60])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9F7AF1056C50
	for <drbd-dev@lists.linbit.com>; Tue, 16 Aug 2011 17:32:15 +0200 (CEST)
Received: from localhost (89-73-195-149.dynamic.chello.pl [89.73.195.149])
	by mail.dawidek.net (Postfix) with ESMTPSA id 47EF253B
	for <drbd-dev@lists.linbit.com>; Tue, 16 Aug 2011 17:25:19 +0200 (CEST)
Date: Tue, 16 Aug 2011 17:25:06 +0200
From: Pawel Jakub Dawidek <pjd@FreeBSD.org>
To: drbd-dev@lists.linbit.com
Message-ID: <20110816152505.GA1712@garage.freebsd.pl>
References: <4E3BA638.9000601@ii.nl>
	<20110816130833.GD3975@barkeeper1-xen.linbit>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20110816130833.GD3975@barkeeper1-xen.linbit>
Subject: Re: [Drbd-dev] [PATCH] expand section on throughput tuning to
 highlight prime usecase of external metadata, florians comments applied,
 added section replacing metadata
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2011 at 03:08:33PM +0200, Lars Ellenberg wrote:
> I suggest to point out that this is for _linear streaming writes_,
> which, once they leave the covered area, need one activity log
> transaction every 4 MiB.
>=20
> Other, more localized, usage patterns need less AL-transactions per
> amount of changes, and are less impacted, or virtually not at all,
> depending on the change rate and size of the working set, and the
> size of the activity log.
>=20
> The impact heavily depends on the overall AL-transaction latency, which
> is why write cache enabled controllers do much better. Even better than
> a dedicated disk, usually, which may no longer suffer from seek time,
> but still has access and processing time up to two orders of magnitude
> higher than a decent write cache.

BTW. How do you ensure AL update "reached the platters"? Do you flush
disk write cache after every AL update?

[...]
> > +see writes of 70 MB/s with DRBD. This is purely caused by head seeks; =
data
> > +writes have to be followed by activity log updates and data writes can=
 only
> > +continue after the meta data update has _reached the platters_. With R=
AID-0,
[...]

--=20
Pawel Jakub Dawidek                       http://www.wheelsystems.com
FreeBSD committer                         http://www.FreeBSD.org
Am I Evil? Yes, I Am!                     http://yomoli.com

--huq684BweRXVnRxX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (FreeBSD)

iEYEARECAAYFAk5Ki9EACgkQForvXbEpPzRfDgCgxZCThbfs1YOy3tk0rLDrfIoX
KGAAoMf+SelaU1pd0fkt3eOAVM8LzPr9
=cUCl
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
