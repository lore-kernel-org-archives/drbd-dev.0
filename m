Return-Path: <cyril@bouthors.org>
Received: from mail1.lan.jexiste.org (lb1.jexiste.org [84.207.24.12])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B834C2CF09FE
	for <drbd-dev@lists.linbit.com>; Wed, 23 Aug 2006 13:59:51 +0200 (CEST)
Received: from [82.206.237.115] (helo=wide.bouthors.org)
	by mail1.lan.jexiste.org with esmtpa (Exim 4.50) id 1GFrOZ-0005T2-SH
	for drbd-dev@lists.linbit.com; Wed, 23 Aug 2006 13:59:50 +0200
Received: from cyb by wide.bouthors.org with local (Exim 4.62)
	(envelope-from <cyril@bouthors.org>) id 1GFrOV-0003jp-HU
	for drbd-dev@lists.linbit.com; Wed, 23 Aug 2006 14:59:39 +0300
From: Cyril Bouthors <cyril@bouthors.org>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Debian and DRBD cooperation
References: <87sljrdwxg.fsf@wide.bouthors.org>
	<20060821103235.GD7214@soda.linbit> <877j12pe64.fsf@wide.bouthors.org>
	<20060821105426.GE7214@soda.linbit>
Date: Wed, 23 Aug 2006 14:59:39 +0300
In-Reply-To: <20060821105426.GE7214@soda.linbit> (Lars Ellenberg's message of
	"Mon, 21 Aug 2006 12:54:26 +0200")
Message-ID: <87bqqbvf10.fsf@wide.bouthors.org>
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

On 21 Aug 2006, Lars Ellenberg wrote:

>> http://bugs.debian.org/cgi-bin/pkgreport.cgi?src=3Ddrbd0.7#_1_4_5
>
> #308640: /sbin/drbdsetup: doesn't work with x86_64 kernel
> fixed; was broken because of a minor glitch between versions.
> 	 we now have compile time asserts in place so this is
> unlikely to ever happen again.
>
> #337210: drbd0.7-utils: man page of drbdsetup is wrong
> fixed;
> example section has been removed/replaced with a url pointer to
> examples on the web -- which may or may not be correct ;)
>
> #337242: drbd0.7-utils: Wrong argument supplied to drbdsetup
> bogus; the "you must not give an index with internal" is correct
> 	 for the drbd.conf syntax. because it _implies_ the -1 on the drbdsetup
> 	 commandline. whatever the problem of the reporter was, this is not it.
>
>> http://bugs.debian.org/cgi-bin/pkgreport.cgi?src=3Ddrbd0.7#_1_6_5
>
> #357298: drbd: fix building for x86_64 on i386
> 	has to be fixed debian internally, I think, in case it still
> 	applies.

Thanks.

I've processed all the bugs we got from Debian users. There's only one
left and it's a Debian-internal stuff, we are working on it, should be
fixed later this week.

> all of these have been dealt with very quickly
> on drbd-user when first reported there.

Maybe I missed something but I got no answer to those bug reports :

http://lists.linbit.com/pipermail/drbd-user/2005-December/004194.html
http://lists.linbit.com/pipermail/drbd-user/2005-December/004193.html
http://lists.linbit.com/pipermail/drbd-user/2006-April/004872.html
http://lists.linbit.com/pipermail/drbd-user/2006-April/004871.html
=2D-=20
Cyril Bouthors

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE7EMrZ1SJHeqsYt8RAjUJAJ4gYbJBbiqSteg3T7u1sZVMh/veQACfV0Rq
X5JMGaK6sviFbPkJJNgqaZQ=
=+G+g
-----END PGP SIGNATURE-----
--=-=-=--
