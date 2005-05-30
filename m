Return-Path: <cyb@bouthors.org>
Received: from serveur.moneytech.mg (unknown [196.192.36.22])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id EBE8316B50
	for <drbd-dev@lists.linbit.com>; Mon, 30 May 2005 10:21:21 +0200 (CEST)
Received: from serveur.moneytech.mg (localhost [127.0.0.1])
	by moneytech (Postfix) with ESMTP id 0436B51C119
	for <drbd-dev@lists.linbit.com>; Mon, 30 May 2005 11:21:12 +0300 (EAT)
Received: from wide.bouthors.org (cyril.intranet.moneytech.mg [192.168.1.178])
	by moneytech (Postfix) with ESMTP id D67D951C030
	for <drbd-dev@lists.linbit.com>; Mon, 30 May 2005 11:21:11 +0300 (EAT)
To: drbd-dev@lists.linbit.com
From: Cyril Bouthors <cyb@debian.org>
Date: Mon, 30 May 2005 11:22:17 +0300
Message-ID: <87oeatrume.fsf@wide.bouthors.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="===-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: Cyril Bouthors <cyb@bouthors.org>
Cc: Igor Genibel <igor@jexiste.org>
Subject: [Drbd-dev] [Igor Genibel] Bug#310993: reproductible segfault when
 parsing the config file
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--===-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=

Igor has found a bug in 0.7.10. drbdadm fails when the config file is
bigger than 4798 bytes, which is the default:

root@wide:~# drbdadm -d adjust all
Segmentation fault
root@wide:~# ls -lh /etc/drbd.conf
-rw-r--r--  1 root root 11K 2005-05-30 11:18 /etc/drbd.conf
root@wide:~#

I've marked this Debian bug as "forwarded to upstream".  Please notice
me when it's fixed.

Thanks.


--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline

X-From-Line: debbugs@bugs.debian.org Fri May 27 18:40:46 2005
Return-path: <debbugs@bugs.debian.org>
Envelope-to: cyb@localhost
Delivery-date: Fri, 27 May 2005 18:40:46 +0300
Received: from localhost ([127.0.0.1])
	by wide.bouthors.org with esmtp (Exim 4.50) id 1Dbgx4-0002S3-97
	for cyb@localhost; Fri, 27 May 2005 18:40:46 +0300
Received: from wide.bouthors.org [127.0.0.1]
	by localhost with POP3 (fetchmail-6.2.5)
	for cyb@localhost (single-drop); Fri, 27 May 2005 18:40:46 +0300 (EAT)
Received: from master.debian.org ([146.82.138.7])
	by mail2.jexiste.org with esmtp (Exim 4.34) id 1Dbgqp-0000PK-OD
	for cyril@bouthors.org; Fri, 27 May 2005 17:34:23 +0200
Received: from qa by master.debian.org with local (Exim 3.35 1 (Debian))
	id 1Dbgub-0005oT-00; Fri, 27 May 2005 10:38:13 -0500
Received: from spohr.debian.org [140.211.166.43] by master.debian.org with
	esmtp (Exim 3.35 1 (Debian)) id 1DbguZ-0005nJ-00; Fri, 27 May 2005
	10:38:11 -0500
Received: from debbugs by spohr.debian.org with local (Exim 3.35 1
	(Debian)) id 1Dbgpc-0006v0-00; Fri, 27 May 2005 08:33:04 -0700
X-Loop: owner@bugs.debian.org
Subject: Bug#310993: reproductible segfault when parsing the config file
Reply-To: Igor Genibel <igenibel@debian.org>, 310993@bugs.debian.org
Resent-From: Igor Genibel <igenibel@debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: David Krovich <dkrovich@csee.wvu.edu>
Resent-Date: Fri, 27 May 2005 15:33:03 UTC
Resent-Message-Id: <handler.310993.B.111720727514745@bugs.debian.org>
X-Debian-PR-Message: report 310993
X-Debian-PR-Package: drbd0.7-utils
X-Debian-PR-Keywords: 
Received: via spool by submit@bugs.debian.org id=B.111720727514745 (code B
	ref -1); Fri, 27 May 2005 15:33:03 UTC
Received: (at submit) by bugs.debian.org; 27 May 2005 15:21:15 +0000
Received: from (serveur.moneytech.mg) [196.192.36.22] by spohr.debian.org
	with esmtp (Exim 3.35 1 (Debian)) id 1Dbge8-0003c3-00; Fri, 27 May 2005
	08:21:13 -0700
Received: from serveur.moneytech.mg (localhost [127.0.0.1]) by moneytech
	(Postfix) with ESMTP id 1AA3251C11E for <submit@bugs.debian.org>;
	Fri, 27 May 2005 18:20:19 +0300 (EAT)
Received: from localhost.localdomain (igor.intranet.moneytech.mg
	[192.168.1.179]) by moneytech (Postfix) with ESMTP id CF11A51C030 for
	<submit@bugs.debian.org>; Fri, 27 May 2005 18:20:18 +0300 (EAT)
Received: by genibel.org via sendmail from stdin id
	<m1Dbgcy-005YcoC@localhost.localdomain> (Debian Smail3.2.0.115) Fri,
	27 May 2005 17:20:00 +0200 (CEST)
Message-Id: <m1Dbgcy-005YcoC@localhost.localdomain>
From: Igor Genibel <igenibel@debian.org>
To: Debian Bug Tracking System <submit@bugs.debian.org>
X-Mailer: reportbug 3.12
Date: Fri, 27 May 2005 17:20:00 +0200
X-Virus-Scanned: ClamAV using ClamSMTP
Delivered-To: submit@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Status: No, hits=-8.0 required=4.0 tests=BAYES_00,HAS_PACKAGE
	autolearn=no version=2.60-bugs.debian.org_2005_01_02
X-Spam-Level: 
Resent-Sender: Debian BTS <debbugs@bugs.debian.org>
Delivered-To: drbd@packages.qa.debian.org
Precedence: list
X-Loop: drbd@packages.qa.debian.org
X-PTS-Package: drbd
X-PTS-Keyword: bts
X-Unsubscribe: echo 'unsubscribe drbd' | mail pts@qa.debian.org
X-Spam-Score: 0.0 (/)
Lines: 92
Xref: wide.bouthors.org debian:1050
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===-=-="



--=-=-=--

--===-=-=
Content-Disposition: inline

Package: drbd0.7-utils
Version: 0.7.10-3
Severity: normal

Hi,

It seems that the config file size is limited around 4798 bytes. This
really strange.
Here are to two config files that only differ from one byte.
With the first one (named first) here is the strace output:
[...]
open("/etc/drbd-07.conf", O_RDONLY)     = -1 ENOENT (No such file or
directory)
open("/etc/drbd.conf", O_RDONLY)        = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbffff078) = -1 ENOTTY
(Inappropriate ioctl for device)
fstat64(3, {st_mode=S_IFREG|0644, st_size=4598, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7fe8000
read(3, "# \n#    on-io-error pass_on;\n#  "..., 8192) = 4598
read(3, "", 4096)                       = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

With the second one (named second) here is the strace output:
[...]
write(2, "/dev/drbd0", 10/dev/drbd0)              = 10
write(2, " ", 1 )                        = 1
write(2, "primary", 7primary)                  = 7
write(2, "\' terminated with exit code 20\n", 31' terminated with exit
code 20
) = 31
write(2, "drbdadm aborting\n", 17drbdadm aborting
)      = 17
exit_group(20)                          = ?

It exists abnormaly because of the tests. If I use the initscript it
works well with the second config file.


-- System Information:
Debian Release: 3.1
  APT prefers unstable
  APT policy: (500, 'unstable')
Architecture: i386 (i686)
Shell:  /bin/sh linked to /bin/bash
Kernel: Linux 2.6.11-1-686
Locale: LANG=fr_FR@euro, LC_CTYPE=fr_FR@euro (charmap=ISO-8859-15)

Versions of packages drbd0.7-utils depends on:
ii  debconf                       1.4.49     Debian configuration management sy

-- no debconf information

--===-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=1.drbd.conf.gz
Content-Transfer-Encoding: base64

H4sICLM5l0IAAzEuZHJiZC5jb25mAO2STW6DMBCF95zCEmtIjNRCyqoH6BkqF09bq4mNBtMoinL3
mmJ+GyIW7aYaCwmj92Z4Hn8hC0LmltGRMhEgGmSlqKpno/NGuQRh86pOugBk59aMwgLj26exw2hm
XV1nkfCpCmh2bOP2G4kvcpt7TVUfjA3auxSJl4SUCK6LW3yXxPw+i3nM091DmmaZ9xzAiqjtobQF
1GI/C3JUEv4mSLYyiHtcuanR/dpCZds0JRprCrNnj7kfqxVo67LLGjqHOgg8tZ/H1yKy6gCmtuyu
iwxvGM2FrrqCwmjZ14djH0+6U4c/enSan+D3kc7EBXFBXBAXxAVxQVwQF8QFcUFcEBfExb/iYo7F
lIpgzMQUiStELAERzHG4TsMNGJqwQU/CIgje1lMwhcCrAwE35r489hXXvzj0IYG/+t9OkK1JcAm+
AAvqts32EQAA
--===-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=2.drbd.conf.gz
Content-Transfer-Encoding: base64

H4sICNY5l0IAAzIuZHJiZC5jb25mAO2STW6DMBCF95zCEmtIjNRCyqoH6BkqF09bq4mNBtMoinL3
mmJ+GyIW7aYaCwmj92Z4Hn9hEDK3jI6UiQDRICtFVT0bnTfKJQibV3XSBSA7t2YUFhjfPo0dRjPr
6jqLhE9VQLNjG7ffSHyR29xrqvpgbNDepUi8JKREcF3c4rsk5vdZzGOe7h7SNMu85wBWRG0PpS2g
FvtZkKOS8DdBspVB3OPKTY3u1xYq26Yp0VhTmD17zP1YrUBbl13W0DnUQeCp/Ty+FpFVBzC1ZXdd
ZHjDaC501RUURsu+Phz7eNKdOvzRo9P8BL+PdCYuiAvigrggLogL4oK4IC6IC+KCuCAu/hUXcyym
VARjJqZIXCFiCYhgjsN1Gm7A0IQNehIWQfC2noIpBF4dCLgx9+Wxr7j+xaEPCfzV/3aCbE2CS/AF
NzQx5/URAAA=
--===-=-=--

--=-=-=
Content-Transfer-Encoding: quoted-printable



=2D-=20
Cyril Bouthors

--=-=-=--

--===-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCms05Z1SJHeqsYt8RAt05AJ9aVk6PcFhqUr4XDvgPcvCZ/eCovACfSrqM
FvXu2gfhgpPmYzdnZ/40Ghk=
=tjTb
-----END PGP SIGNATURE-----
--===-=-=--
