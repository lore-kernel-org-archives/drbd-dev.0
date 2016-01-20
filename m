Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 266BE104B1D2
	for <drbd-dev@lists.linbit.com>; Wed, 20 Jan 2016 13:08:17 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: =?utf-8?B?6rmA7ISx7J2A?= <sekim@mantech.co.kr>
Date: Wed, 20 Jan 2016 10:26:26 +0100
Message-ID: <1480093.ZW76pyVVg3@phil-dell-xps.local>
In-Reply-To: <CAHRYDjgyCcQEA0usvC+oxgtUE=n__4UbxeZUe3694s6P_BdYQQ@mail.gmail.com>
References: <CAHRYDjgyCcQEA0usvC+oxgtUE=n__4UbxeZUe3694s6P_BdYQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Cc: =?utf-8?B?7KeE7ZiE7J20?= <jhlee@mantech.co.kr>,
	Windows DRBD <wdrbd@mantech.co.kr>,
	=?utf-8?B?6rmA7J6s7ZeM?= <jhkim@mantech.co.kr>,
	=?utf-8?B?67CV7ISx7ZmY?= <shpark@mantech.co.kr>,
	'lars Ellenberg' <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [CASE 12] 2 primary split-brain is not detected
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

Hi,

I am following up on CASE 12 now.

I was not able to reproduce what you describe in this report.
Please check that you can still reproduce it with current GIT-head.
If yes, please re-send it with a more detailed description, including:

 Configuration used.
 Logfiles from begin to end of the test.

Thanks!

Best regards,
 Phil

> Hello,
>=20
> I am Software Manager in Mantech, and testing drbd 9.
>=20
> some problems are occurred. CASE 12 is one of them.
>=20
> [CASE 12] 2 primary split-brain is not detected.
>=20
> Env:
> - Linux VM 2 nodes
> - Linux drbd version 9.0.0
>=20
> Test scenario:
>=20
> - 2 node's status is uptodate
>=20
> node 1node 2drbdadm disconnect r0 drbdadm primary r0 copy files on
> node1   drbdadm
> primary r0 copy files on node2
> drbdadm connect r0
>=20
> - at this point, we predicted that 2 primary split-brain is occurred =
and
> drbd9 detect it.
>=20
> But split-brain is not occurred, not detected. no debug log.
> Just retry connection log is showing between two nodes.
>=20
> Question is :
>=20
> 1) How can I test 2 primary split-brain situation ?
>=20
> 2) Does support 2 primary split-brain in drbd9 ?
>=20
>=20
> PS)
>=20
> http://drbd.linbit.com/users-guide-9.0/s-configure-split-brain-behavi=
or.html
> #s-split-brain-notification
>=20
> drbd9's manual describe 'after-sb-2pri' option.
>=20
> Thanks,
>=20
>=20
> Best Regards
> Sungeun Kim
>=20
>=20
>=20
>=20
> [image: =EC=84=A4=EB=AA=85: logo]
>=20
> =EA=B8=B0=EC=88=A0=EC=97=B0=EA=B5=AC=EC=86=8C / DRBD=ED=8C=80        =
Mobile : 010-2813-4843
>=20
> *=EA=B9=80 =EC=84=B1 =EC=9D=80 **=EC=B0=A8=EC=9E=A5               sek=
im@mantech.co.kr <sekim@mantech.co.kr>*
>=20
> =EC=84=9C=EC=9A=B8=ED=8A=B9=EB=B3=84=EC=8B=9C =EC=84=B1=EB=8F=99=EA=B5=
=AC =EC=84=B1=EC=88=98=EC=9D=BC=EB=A1=9C4=EA=B8=B8 25 =EC=84=9C=EC=9A=B8=
=EC=88=B2=EC=BD=94=EC=98=A4=EB=A1=B1=EB=94=94=EC=A7=80=ED=84=B8=ED=83=80=
=EC=9B=8C 12=EC=B8=B5
>=20
> Tel : 02-2136-6913 / Fax : 02-575-4858 / =EC=BD=9C=EC=84=BC=ED=84=B0 =
: 1833-7790
>=20
> http://www.mantech.co.kr
>=20
> [image: =EB=B3=B8=EB=AC=B8 =EC=9D=B4=EB=AF=B8=EC=A7=80 1]

