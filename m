Return-Path: <cyril@bouthors.org>
Received: from mail.jexiste.org (lb1.jexiste.org [84.207.24.12])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 50D3E2CF7FD4
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2006 12:44:35 +0200 (CEST)
Received: from [62.56.243.68] (helo=wide.bouthors.org)
	by mail.jexiste.org with esmtpa (Exim 4.50) id 1GULHd-00032N-82
	for drbd-dev@lists.linbit.com; Mon, 02 Oct 2006 12:44:29 +0200
Received: from cyb by wide.bouthors.org with local (Exim 4.63)
	(envelope-from <cyril@bouthors.org>) id 1GULHS-0005tS-2v
	for drbd-dev@lists.linbit.com; Mon, 02 Oct 2006 13:44:14 +0300
From: Cyril Bouthors <cyb@debian.org>
To: drbd-dev@lists.linbit.com
References: <200610021114.55092.philipp.reisner@linbit.com>
Date: Mon, 02 Oct 2006 13:44:13 +0300
In-Reply-To: <200610021114.55092.philipp.reisner@linbit.com> (Philipp
	Reisner's message of "Mon, 2 Oct 2006 11:14:54 +0200")
Message-ID: <87u02nj8ua.fsf@wide.bouthors.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Subject: [Drbd-dev] Re: [DRBD-announce] drbd-8.0pre5.tar.gz
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

> The good news are: pre5 is much more stable and usable than any other 8.0=
=20
> prerelease before.
>
> 8.0pre5 (api:84/proto:83)
> --------
> * The request code was completely rewritten.
> * The write conflict detection code for primary-primary is currently
> broken, but will be fixed soon.
> * drbdsetup is no longer based on IOCTL but works now via=20
> netlink/connector.
> * drbd_panic() is on its way out.
> * A runtime configurable tracing framework got added.
> * A lot of effort was put into finding and fixing bugs.
>
> http://oss.linbit.com/drbd/8.0/drbd-8.0pre5.tar.gz
> http://svn.drbd.org/drbd/tags/drbd-8.0pre5/
>
> Happy testing, happy early-adoping ;)
>
> -Philipp

This version provoques the following warnings with the latest lintian
(the Debian package checker):

Now running lintian...
W: drbd8-utils: init.d-script-missing-lsb-keyword /etc/init.d/drbd short-de=
scription
W: drbd8-utils: init.d-script-missing-lsb-keyword /etc/init.d/drbd required=
-stop
Finished running lintian.

I've fixed this with this patch:

=2D-- drbd8-8.0pre5.orig/scripts/drbd
+++ drbd8-8.0pre5/scripts/drbd
@@ -10,10 +10,10 @@
 ### BEGIN INIT INFO
 # Provides: drbd
 # Required-Start: $network $syslog sshd
=2D# Required-Stop:
+# Required-Stop: $network $syslog sshd
 # Default-Start:  3 5
 # Default-Stop:   0 1 2 6
=2D# Description:    Control drbd resources.
+# Short-Description:    Control drbd resources.
 ### END INIT INFO
=20
 DEFAULTFILE=3D"/etc/default/drbd"


Please apply this patch is the next release.

For more information, have a look at
http://wiki.debian.org/LSBInitScripts/


By the way, the Debian package [1] still ships this second patch to
the initscript because some users needed it:

=2D-- drbd-0.7.10.orig/scripts/drbd	2005-01-13 17:30:28.000000000 +0300
+++ drbd-0.7.10/scripts/drbd	2005-04-17 18:18:16.166074586 +0300
@@ -19,8 +19,8 @@
 DEFAULTFILE=3D"/etc/default/drbd"
 DRBDADM=3D"/sbin/drbdadm"
 PROC_DRBD=3D"/proc/drbd"
=2DMODPROBE=3D"modprobe"
=2DRMMOD=3D"rmmod"
+MODPROBE=3D"/sbin/modprobe"
+RMMOD=3D"/sbin/rmmod"
 UDEV_TIMEOUT=3D10
 ADD_MOD_PARAM=3D""

Would it be possible to commit them both into SVN?

Have a look at http://bugs.debian.org/302556 and
http://bugs.debian.org/303060 for more information.

Thanks.

PS: I've uploaded 8.0pre5 to Debian/sid.

[1] the official one, to avoid confusions
=2D-=20
 ,''`.
: :' :      Cyril Bouthors
`. `'         Debian.org
  `-

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFIO19Z1SJHeqsYt8RApIRAKCQZiz3FmC0CDx6a5OtF5UV1bwF9ACffkSp
7aJY/N4D7B1zUQz7MSU0Ly8=
=0fN8
-----END PGP SIGNATURE-----
--=-=-=--
