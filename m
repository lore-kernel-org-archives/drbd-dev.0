Return-Path: <gld-drbd-dev@m.gmane.org>
Received: from main.gmane.org (main.gmane.org [80.91.229.2])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 5155F14303
	for <drbd-dev@lists.linbit.com>; Fri, 19 Nov 2004 14:00:23 +0100 (CET)
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CV8NC-0002kO-00
	for <drbd-dev@lists.linbit.com>; Fri, 19 Nov 2004 14:00:22 +0100
Received: from serveur.moneytech.mg ([62.173.234.190])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Fri, 19 Nov 2004 14:00:22 +0100
Received: from cyril by serveur.moneytech.mg with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Fri, 19 Nov 2004 14:00:22 +0100
To: drbd-dev@lists.linbit.com
From: Cyril Bouthors <cyril@bouthors.org>
Date: Fri, 19 Nov 2004 15:52:27 +0300
Message-ID: <87llcy0zn8.fsf@wide.bouthors.org>
References: <200411152259.28960.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: news <news@sea.gmane.org>
Subject: [Drbd-dev] Re: 0.7.6 release tomorrow...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--=-=-=

On 16 Nov 2004, philipp.reisner@public.gmane.org wrote:

> What exactly should I put into debian/changelog ?

Since DRBD is not a native Debian package (i.e., package which have
been written especially for Debian), I think the tarball must not
contain a debian/changelog nor a debian/ directory.

Please read the docs a http://debian.org/devel/ for more information.

FYI, the debian/ tree from upstream is not used for the official
Debian package.  If you want to help maintaining the Debian package,
Philipp Hug and I would be glad to welcome you as a co-maintainer.
-- 
Cyril Bouthors

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBneyLZ1SJHeqsYt8RAs3AAKChV2WwGGPasEMfRFiiiDWHoWNiSACfcfaV
vCHK8AjENa6R5vJ/woE14bE=
=q6dT
-----END PGP SIGNATURE-----
--=-=-=--

