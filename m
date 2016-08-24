Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2BD141028A59
	for <drbd-dev@lists.linbit.com>; Wed, 24 Aug 2016 18:59:29 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Kim, Sung-eun" <sekim@mantech.co.kr>
Date: Wed, 24 Aug 2016 18:59:27 +0200
Message-ID: <2088157.hdSoysrmVY@phil-dell-xps.local>
In-Reply-To: <CAHRYDjiJvKywY0-y2VO6L71Tucm13h=77v8h45TiD0cHs+ZKDA@mail.gmail.com>
References: <CAHRYDjiJvKywY0-y2VO6L71Tucm13h=77v8h45TiD0cHs+ZKDA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Cc: Windows DRBD <wdrbd@mantech.co.kr>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Question About current uuid in drbd9
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

Hi Sung-eun,

Only 63 bits are random. We encode the current role (Primary =3D 1)
into the lowest bit. When comparing the UUIDs the lowest bit
is ignored.

=46rom top of my head, one of the auto-recovery-after-split-brain
policies looks at this bit.

This is normal behavior and expected.

best regards,
 phil

Am Mittwoch, 24. August 2016, 16:41:05 CEST schrieb Kim, Sung-eun:
> Hello,
>=20
>=20
> I have a question about current uuid in drbd9
>=20
> After initial full-sync, primary's current uuid is one more than
> secondary's current uuid.
>=20
> ex) from drbdadm get-gi r0
>=20
> primary *0005F0D20002F86D*
>=20
> :0000000000000000:0000000000000000:0000000000000000:1:1:1:0:0:0:1:0:0:0
>=20
> secondary
> *0005F0D20002F86C*
>=20
> :0000000000000000:0000000000000000:0000000000000000:1:1:0:0:0:0:1:0:0:0
>=20
> But I changed primary's role to secondary , and again changed to primary.
> and replication volume disk I/O is processed.
>=20
> At this point, primary's current uuid is equal to secondary's current
> uuid.(not one more than secondary's)
>=20
> primary
> *0006A4E400035276*
>=20
> :0000000000000000:0000000000000000:0000000000000000:1:1:1:0:0:0:1:0:0:0
>=20
> secondary
> *0006A4E400035276*
>=20
> :0000000000000000:0000000000000000:0000000000000000:1:1:0:0:0:0:1:0:0:0
>=20
> Is this Bug? , or normal situation?(intended implementation in drbd9?).
>=20
> Could you let me about this result?
>=20
> Thanks.
>=20
>=20
> Best Regards,
> Sung-eun Kim
>=20
> [image: =EC=84=A4=EB=AA=85: logo]
>=20
> Technical Research Center / DRBD Team
>=20
> Principal Research Engineer
>=20
> *Sung-eun Kim               sekim@mantech.co.kr <sekim@mantech.co.kr>*
>=20
> 202 Fl, Seoulforest Kolon digital Tower, 308-4, Seongsudong 2ga,
> Seongdong-gu, Seoul, Korea
>=20
> Tel : 02-2136-6913 / Fax : 02-575-4858 / Call Center : 1833-7790
>=20
> http://www.mantech.co.kr
>=20
> [image: =EB=B3=B8=EB=AC=B8 =EC=9D=B4=EB=AF=B8=EC=A7=80 1]


