Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 37DAF1056445
	for <drbd-dev@lists.linbit.com>; Thu, 16 Jun 2016 11:16:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id EDE6C409625
	for <drbd-dev@lists.linbit.com>; Thu, 16 Jun 2016 11:16:21 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id cEKJqDmYIeGZ for <drbd-dev@lists.linbit.com>;
	Thu, 16 Jun 2016 11:16:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D07AF40969C
	for <drbd-dev@lists.linbit.com>; Thu, 16 Jun 2016 11:16:21 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qH1mpdiHBLdn for <drbd-dev@lists.linbit.com>;
	Thu, 16 Jun 2016 11:16:21 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A6DA4409625
	for <drbd-dev@lists.linbit.com>; Thu, 16 Jun 2016 11:16:21 +0200 (CEST)
Date: Thu, 16 Jun 2016 11:16:21 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160616091621.GN3235@soda.linbit>
References: <HE1PR07MB1196F106848ADFD1C7B62EAFB0560@HE1PR07MB1196.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <HE1PR07MB1196F106848ADFD1C7B62EAFB0560@HE1PR07MB1196.eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] ASSERT log from drbd_al_read_log() in drbd_actlog.c
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

On Thu, Jun 16, 2016 at 07:56:14AM +0000, K, Manoj K. (Nokia - IN/Bangalo=
re) wrote:
> Hi,
>=20
> Below ASSERT log is seen in my machine . Recent change was one of the d=
rbd device is resized.
>=20
> kernel: [   49.584540] block drbd7: ASSERT( from_tnr - cnr + i - from =3D=
=3D mx+1 ) in /data/osci-builds/fpt/build-5348-r5486-x86_64_acpi5/x86_64_=
acpi5/build/drbd-8.3.16/drbd/drbd_actlog.c:558
>=20
> Please let me know in which case this ASSERT is triggered.
>=20
> BTW,  I am using drbd-tools -8.3.16

You do realize that you have a ticket open with LINBIT,
and that you have been asked to provide more information?

Broadcasting "HELP" on all channels
will not magically provide the missing information, though.

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
