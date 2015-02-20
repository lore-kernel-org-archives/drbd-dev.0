Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AD103104B1A2
	for <drbd-dev@lists.linbit.com>; Fri, 20 Feb 2015 15:18:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9C4653EDCD1
	for <drbd-dev@lists.linbit.com>; Fri, 20 Feb 2015 15:18:45 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id tJsy1w33mG9k for <drbd-dev@lists.linbit.com>;
	Fri, 20 Feb 2015 15:18:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 817003EDC71
	for <drbd-dev@lists.linbit.com>; Fri, 20 Feb 2015 15:18:45 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mIFoPKSLklGi for <drbd-dev@lists.linbit.com>;
	Fri, 20 Feb 2015 15:18:45 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 572963EDC2D
	for <drbd-dev@lists.linbit.com>; Fri, 20 Feb 2015 15:18:45 +0100 (CET)
Date: Fri, 20 Feb 2015 15:18:45 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150220141845.GZ20897@soda.linbit>
References: <54E6C8BA.9090201@suse.de> <20150220074152.GC12926@cacao.linbit>
	<54E6FA84.2070306@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <54E6FA84.2070306@suse.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [bug] drbd 9: Receiver error
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

On Fri, Feb 20, 2015 at 03:12:36AM -0600, Goldwyn Rodrigues wrote:
> Hi Philipp,
>=20
>=20
> On 02/20/2015 01:41 AM, Philipp Marek wrote:
> >Hi Goldwyn,
> >
> >>I compiled drbd-9.0 against Opensuse Tumbleweed and installed it [1].
> >>I applied Linux kernel commit f730c848affc05fb7262574b06e0cd7e1fa9609=
6 to
> >>get it to compile against the latest (factory) kernels and should be =
the
> >>same for the tumbleweed kernel (3.18.3 based) I am using to test.
> >>
> >>I am getting the following receiver errors in the kernel log when I t=
ry to
> >>start the drbd service:
> >...
> >>Please let me know if you need any more information to debug this or =
if I am
> >>doing something wrong.
> >how many nodes did you connect, which DRBD versions were they running?
>=20
> Two nodes, traditional way with one local device and no other
> clustering software.
>=20
> >Can you show the configuration, and some more log lines - from all nod=
es,
> >and starting quite a bit earlier?
>=20
> Here is the one which errs:
>=20
> [  175.644532] drbd: initialized. Version: 9.0.0rc1 (api:1/proto:86-110=
)
> [  175.644535] drbd: GIT-hash:
> 9804ed9b1eedab65cb137380f8066518a9521c12 build by abuild@cloud109,
> 2015-02-20 08:39:07
> [  175.644536] drbd: registered as block device major 147
> [  175.657174] drbd r0: Starting worker thread (from drbdsetup [1162])
> [  175.797012]  sda: unknown partition table
> [  175.798367] block drbd0: disk( Diskless -> Attaching )
> [  175.798404] block drbd0: Maximum number of peer devices =3D 1
> [  175.798634] drbd r0: Method to ensure write ordering: flush
> [  175.798644] block drbd0: drbd_bm_resize called with capacity =3D=3D =
62912568
> [  175.799879] block drbd0: resync bitmap: bits=3D7864071 words=3D12287=
7
> pages=3D240


> [  176.429715] block drbd0: tumbleweed1: bitmap overflow (e:8388342) wh=
ile decoding bm RLE packet
> [  176.429739] drbd r0 tumbleweed1: error receiving P_COMPRESSED_BITMAP=
, e: -5 l: 7!


If you can reproduce this (with RLE enabled),
can you please down drbd on both nodes,
then "dump-md"?

I'm interested in how exactly your bitmaps look like,
so I could "unit test" the bitmap compression/decompression for it.

Thanks,
	Lars

--=20
: Lars Ellenberg
: http://www.LINBIT.com | Your Way to High Availability
: DRBD, Linux-HA  and  Pacemaker support and consulting

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
