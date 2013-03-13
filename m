Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D715F10518AC
	for <drbd-dev@lists.linbit.com>; Wed, 13 Mar 2013 10:36:06 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 13 Mar 2013 10:36:05 +0100
Message-ID: <1836456.C0Q3SvHLOO@fat-tyre>
In-Reply-To: <14929986.1066301363073806770.herumi@nifty.com>
References: <14929986.1066301363073806770.herumi@nifty.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [Drbd-dev] [request][patch] adding sysfs entry for backing_dev
	info
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

Am Dienstag, 12. M=E4rz 2013, 16:36:46 schrieb MITSUNARI Shigeo:
> Hi, all.
>=20
> We are using drbdsetup directly without drbdadm and configuration fil=
es
> in order to configure DRBD resources dynamically.  Most operations ca=
n
> be done without configuration files except one.
>=20

Right, this is a valid use case.

> Currently, the kernel does not provide information about the attached=

> backing devices.

This statement is wrong. The output of "drbdsetup show" contains the
backing device.

> Without the information, we cannot implement such dynamic configurati=
ons
> in a state-less manner.
>=20
> The attached patch exposes the backing device information via sysfs e=
ntry.
>=20

You need to know that we have implemented some sysfs support with 8.3.1=
4
(exposing some UUIDs). But it was rejected when we tried to forward thi=
s
sysfs support to our in-linux-tree DRBD.

It was rejected to put a new directory under /sys/block/drbd0. See
https://lkml.org/lkml/2012/10/3/254

We might consider to retry it with DRBD as a seperate bus. I.e. /sys/bu=
s/drbd
at a later point in time.

I.e. so far, you patch will _not_ be accepted by us into the out-of-tre=
e DRBD.

Best regards,
 Philipp

