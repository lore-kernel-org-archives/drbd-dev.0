Return-Path: <cyril@bouthors.org>
Received: from mail1.lan.jexiste.org (lb1.jexiste.org [84.207.24.12])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 75FE72CE9DC5
	for <drbd-dev@lists.linbit.com>; Mon, 21 Aug 2006 12:52:03 +0200 (CEST)
Received: from [82.206.237.115] (helo=wide.bouthors.org)
	by mail1.lan.jexiste.org with esmtpa (Exim 4.50) id 1GF7Nm-00023z-Kz
	for drbd-dev@lists.linbit.com; Mon, 21 Aug 2006 12:52:03 +0200
Received: from cyb by wide.bouthors.org with local (Exim 4.62)
	(envelope-from <cyril@bouthors.org>) id 1GF7Ne-0001n6-1W
	for drbd-dev@lists.linbit.com; Mon, 21 Aug 2006 13:51:42 +0300
From: Cyril Bouthors <cyb@debian.org>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Debian and DRBD cooperation
References: <87sljrdwxg.fsf@wide.bouthors.org>
	<20060821103235.GD7214@soda.linbit>
Date: Mon, 21 Aug 2006 13:51:41 +0300
In-Reply-To: <20060821103235.GD7214@soda.linbit> (Lars Ellenberg's message of
	"Mon, 21 Aug 2006 12:32:35 +0200")
Message-ID: <87wt92nyyq.fsf@wide.bouthors.org>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21 Aug 2006, Lars Ellenberg wrote:

> but if I go to bugs.debian.org, and search by package for drbd0.7, I
> find exactly three bugs all of them classified as wishlist, two of
> them regarding how to package it (which is a debian internal thing),
> and one of them (the only "forwarded" one) about how to adjust the
> debian/rules file, which is also debian internal.

I've forwarded 4 bugs to DRBD that are still in need of feedback from
you:

Forwarded bugs -- Normal bugs (3 bugs)

  =E2=80=A2 #308640: /sbin/drbdsetup: doesn't work with x86_64 kernel
    Package: drbd0.7-utils (0.7.10-3); Reported by: Patrice Fournier
    <pfournier@loups.net>; Forwarded to drbd-user@lists.linbit.com; 1 year =
and
    101 days old.
  =E2=80=A2 #337210: drbd0.7-utils: man page of drbdsetup is wrong
    Package: drbd0.7-utils (drbd0.7-utils 0.7.11-1); Reported by: Yann Forg=
et
    <yann.forget@goelaan.ch>; Forwarded to drbd-user@linbit.com; 291 days o=
ld.
  =E2=80=A2 #337242: drbd0.7-utils: Wrong argument supplied to drbdsetup
    Package: drbd0.7-utils (drbd0.7-utils 0.7.11-1); Reported by: Yann Forg=
et
    <yann.forget@goelaan.ch>; Forwarded to drbd-user@linbit.com; 290 days o=
ld.

Forwarded bugs -- Wishlist items (1 bug)

  =E2=80=A2 #357298: drbd: fix building for x86_64 on i386
    Package: drbd0.7; Severity: wishlist; Reported by: Guido Guenther
    <agx@sigxcpu.org>; Tags: patch; Forwarded to drbd-user@lists.linbit.com;
    157 days old.

None of them are about `debian/rules'.

All of them have been sent several months ago and I'm still waiting to
receive feedback from you.

> there are even people at debian who have full access to the debian/

This debian/ directory is not part of Debian, this is not official and
not even included in the DRBD tarballs.

We are not using it in the official distribution as I've said many
many times on the mailing list. I've adviced you to remove it from
svn, it thought it was already removed a long time ago.

This is the normal way to make Debian packages, we take upstream
tarballs and we patch them to add our debian/ subdir. If we have to
patch something outside debian/, we contribute our patches to
upstream. If something outside debian/ is buggy, we forward our bugs
to upstream.

Anyone can contribute to the official Detail packages, please follow
the instructions at http://bugs.debian.org/

I'll be glad to receive feedback from anyone about our (my?) Debian
packages.

> so, how can I further help you with this?

Read the bugs I've forwarded to you:

http://bugs.debian.org/308640
http://bugs.debian.org/337210
http://bugs.debian.org/337242
http://bugs.debian.org/357298

And give me feedback.

Thanks
=2D-=20
Cyril Bouthors

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE6ZA9Z1SJHeqsYt8RAmdGAJ9iYYcvKpLDf8WF4npsCa74kAp4IQCfWcI+
BCTzR0B2w0rHbrT6bQRFCkY=
=V/vP
-----END PGP SIGNATURE-----
--=-=-=--
