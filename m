Return-Path: <cyril@bouthors.org>
Received: from mail.jexiste.org (lb2.jexiste.org [84.207.24.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 55D6D2DF6539
	for <drbd-dev@lists.linbit.com>; Tue, 24 Oct 2006 19:12:33 +0200 (CEST)
Received: from [62.56.243.68] (helo=wide.bouthors.org)
	by mail.jexiste.org with esmtpa (Exim 4.50) id 1GcPoA-0003b8-Nn
	for drbd-dev@lists.linbit.com; Tue, 24 Oct 2006 19:12:33 +0200
Received: from cyb by wide.bouthors.org with local (Exim 4.63)
	(envelope-from <cyril@bouthors.org>) id 1GcPny-0004xb-2w
	for drbd-dev@lists.linbit.com; Tue, 24 Oct 2006 20:11:10 +0300
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-announce] drbd-8.0pre5.tar.gz
References: <200610021114.55092.philipp.reisner@linbit.com>
	<87u02nj8ua.fsf@wide.bouthors.org>
	<200610021459.06658.philipp.reisner@linbit.com>
From: Cyril Bouthors <cyril@bouthors.org>
Date: Tue, 24 Oct 2006 20:11:09 +0300
In-Reply-To: <200610021459.06658.philipp.reisner@linbit.com> (Philipp
	Reisner's message of "Mon, 2 Oct 2006 14:59:06 +0200")
Message-ID: <87u01tabbm.fsf@wide.bouthors.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On  2 Oct 2006, philipp.reisner@linbit.com wrote:

> Applied both paches.

Still the same with 0.7.22:

Now running lintian...
W: drbd0.7-utils: init.d-script-missing-lsb-keyword /etc/init.d/drbd short-=
description
W: drbd0.7-utils: init.d-script-missing-lsb-keyword /etc/init.d/drbd requir=
ed-stop
Finished running lintian.

Are you sure you've applied my patches?
=2D-=20
Cyril Bouthors

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFPkktZ1SJHeqsYt8RAjcNAKC1e8m2+A20BOLdVi8RSa/NT9un+QCgofrl
UUCEqLQfgz9ATn3XMh2c3oY=
=Eb39
-----END PGP SIGNATURE-----
--=-=-=--
