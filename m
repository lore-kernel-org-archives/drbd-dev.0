Return-Path: <gld-drbd-dev@m.gmane.org>
Received: from main.gmane.org (main.gmane.org [80.91.229.2])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 0DB7B14303
	for <drbd-dev@lists.linbit.com>; Thu, 25 Nov 2004 08:49:04 +0100 (CET)
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CXENE-0007ei-00
	for <drbd-dev@lists.linbit.com>; Thu, 25 Nov 2004 08:49:04 +0100
Received: from 196.192.39.166 ([196.192.39.166])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Thu, 25 Nov 2004 08:49:04 +0100
Received: from cyril by 196.192.39.166 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Thu, 25 Nov 2004 08:49:04 +0100
To: drbd-dev@lists.linbit.com
From: Cyril Bouthors <cyril@bouthors.org>
Date: Thu, 25 Nov 2004 10:46:59 +0300
Message-ID: <87pt22fk0c.fsf@wide.bouthors.org>
References: <200411152259.28960.philipp.reisner@linbit.com>
	<41A48BB0.4080707@wollmersdorfer.at> <41A4909F.4070806@hug.cx>
	<200411241518.55023.philipp.reisner@linbit.com>
	<41A4A309.9030705@hug.cx> <Z+CHtpDcVPhqXMZ3GOO8Jts=lge@web.de>
	<41A51BF0.10109@hug.cx> <rIe9JTBXuI5VKlizdCtH1u8=lge@web.de>
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

<#secure method=pgpmime mode=sign>
--=-=-=

On 25 Nov 2004, Lars Ellenberg wrote:
> -	@find $$(svn st -v | sed '/^?/d;s/^.\{8\} \+[0-9]\+ \+[0-9]\+ [a-z]\+ *//;') \
> +	@find $$(svn st -v | sed '/^?/d;s/^.\{8\} \+[0-9]\+ \+[0-9]\+ [a-z]\+ *//;/^debian/d' ) \

This will really make the debian maintainers life easier.

Thanks.
-- 
Cyril Bouthors

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBpY3zZ1SJHeqsYt8RAhQMAJ41sAvZ40a1URFR5f3LUw0zlKE7YACbBcg/
M4O36FD++gG/dfOw+0vZ2OY=
=5n2t
-----END PGP SIGNATURE-----
--=-=-=--

