Return-Path: <manoj.k.k@nokia.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
	(mail-db3on0136.outbound.protection.outlook.com [157.55.234.136])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1E4041056332
	for <drbd-dev@lists.linbit.com>; Thu, 16 Jun 2016 10:56:33 +0200 (CEST)
From: "K, Manoj K. (Nokia - IN/Bangalore)" <manoj.k.k@nokia.com>
To: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Date: Thu, 16 Jun 2016 07:56:14 +0000
Message-ID: <HE1PR07MB1196F106848ADFD1C7B62EAFB0560@HE1PR07MB1196.eurprd07.prod.outlook.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_HE1PR07MB1196F106848ADFD1C7B62EAFB0560HE1PR07MB1196eurp_"
MIME-Version: 1.0
Subject: [Drbd-dev] ASSERT log from drbd_al_read_log() in drbd_actlog.c
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

--_000_HE1PR07MB1196F106848ADFD1C7B62EAFB0560HE1PR07MB1196eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Below ASSERT log is seen in my machine . Recent change was one of the drbd =
device is resized.

kernel: [   49.584540] block drbd7: ASSERT( from_tnr - cnr + i - from =3D=
=3D mx+1 ) in /data/osci-builds/fpt/build-5348-r5486-x86_64_acpi5/x86_64_ac=
pi5/build/drbd-8.3.16/drbd/drbd_actlog.c:558

Please let me know in which case this ASSERT is triggered.

BTW,  I am using drbd-tools -8.3.16

BR,
Manoj Katari


--_000_HE1PR07MB1196F106848ADFD1C7B62EAFB0560HE1PR07MB1196eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<div>Hi,</div>
<div>&nbsp;</div>
<div>Below ASSERT log is seen in my machine . Recent change was one of the =
drbd device is resized.</div>
<div>&nbsp;</div>
<div><font color=3D"red">kernel: [&nbsp;&nbsp; 49.584540] block drbd7: ASSE=
RT( from_tnr - cnr &#43; i - from =3D=3D mx&#43;1 ) in /data/osci-builds/fp=
t/build-5348-r5486-x86_64_acpi5/x86_64_acpi5/build/drbd-8.3.16/drbd/drbd_ac=
tlog.c:558</font></div>
<div><font color=3D"red">&nbsp;</font></div>
<div>Please let me know in which case this ASSERT is triggered.</div>
<div>&nbsp;</div>
<div>BTW,&nbsp; I am using drbd-tools -8.3.16</div>
<div>&nbsp;</div>
<div>BR,</div>
<div>Manoj Katari</div>
<div>&nbsp;</div>
</span></font>
</body>
</html>

--_000_HE1PR07MB1196F106848ADFD1C7B62EAFB0560HE1PR07MB1196eurp_--
