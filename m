Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 92BDD10003ED
	for <drbd-dev@lists.linbit.com>; Thu, 26 Feb 2015 21:12:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 83938318CBC
	for <drbd-dev@lists.linbit.com>; Thu, 26 Feb 2015 21:12:02 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id GXTuIt70Ir9s for <drbd-dev@lists.linbit.com>;
	Thu, 26 Feb 2015 21:12:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5DFE830D7DA
	for <drbd-dev@lists.linbit.com>; Thu, 26 Feb 2015 21:12:02 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GLHN4wxvtzU1 for <drbd-dev@lists.linbit.com>;
	Thu, 26 Feb 2015 21:12:02 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 1ED6B30599A
	for <drbd-dev@lists.linbit.com>; Thu, 26 Feb 2015 21:12:02 +0100 (CET)
Date: Thu, 26 Feb 2015 21:12:01 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150226201201.GL19088@soda.linbit>
References: <54E6C8BA.9090201@suse.de> <20150220074152.GC12926@cacao.linbit>
	<54E6FA84.2070306@suse.de> <20150220141845.GZ20897@soda.linbit>
	<54EB60E7.10304@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <54EB60E7.10304@suse.de>
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

On Mon, Feb 23, 2015 at 11:18:31AM -0600, Goldwyn Rodrigues wrote:
> >>[  176.429715] block drbd0: tumbleweed1: bitmap overflow (e:8388342) =
while decoding bm RLE packet
> >>[  176.429739] drbd r0 tumbleweed1: error receiving P_COMPRESSED_BITM=
AP, e: -5 l: 7!
> >
> >
> >If you can reproduce this (with RLE enabled),
> >can you please down drbd on both nodes,
> >then "dump-md"?
> >
> >I'm interested in how exactly your bitmaps look like,
> >so I could "unit test" the bitmap compression/decompression for it.
> >
>=20
> The problem occurs when the devices are of unequal sizes.

Oh.

Well, they should refuse to talk to each other in the first place.
Or have agreed to the minimum of all involved sizes before even trying
to exchange bitmap information.

However, you should not connect different size DRBD, anyways.
If that does not work yet, well, then don't do it ;-)


> I am
> unable to get the dump-md _after_ the error, because of the
> following:
>=20
> tumbleweed3:~ # drbdadm dump-md r0
> Found meta data is "unclean", please apply-al first
> Command 'drbdmeta 0 v09 /dev/sda internal dump-md' terminated with
> exit code 255

you can add "--force".
or, well, down, then "apply-al", as in "drbdadm apply-al",
resp.  drbdmeta 0 v09 /dev/sda internal apply-al
(where "al" is "activity log").

> I am able to recreate the problem everytime. Here is the dump before
> starting the service:
>=20
> tumbleweed1:~ # drbdadm dump-md r0
> # DRBD meta data dump
> # 2015-02-23 10:31:50 -0600 [1424709110]
> # tumbleweed1> drbdmeta 0 v09 /dev/sda internal dump-md
> #
>=20
> version "v09";
>=20
> max-peers 1;
> # md_size_sect 2120
> # md_offset 34359734272
> # al_offset 34359701504
> # bm_offset 34358652928
>=20
> node-id -1;
> current-uuid 0x0000000000000004;
> flags 0x00000080;
> peer[0] {
>     bitmap-index -1;
>     bitmap-uuid 0x0000000000000000;
>     bitmap-dagtag 0x0000000000000000;
>     flags 0x00000000;
> }
> peer[1] {
>     bitmap-index -1;
>     bitmap-uuid 0x0000000000000000;
>     bitmap-dagtag 0x0000000000000000;
>     flags 0x00000000;
> }

> history-uuids {
>         0x0000000000000000; 0x0000000000000000; 0x0000000000000000;

> # al-extents 257;
> la-size-sect 0;
> bm-byte-per-bit 4096;
> device-uuid 0xA4C9657C56B6D358;
> la-peer-max-bio-size 0;
> al-stripes 1;
> al-stripe-size-4k 8;
> # bm-bytes 0;
> bitmap[0] {
> }
> # bits-set 0;

> tumbleweed3:~ # drbdadm dump-md r0
> # DRBD meta data dump
> # 2015-02-23 10:32:12 -0600 [1424709132]
> # tumbleweed3> drbdmeta 0 v09 /dev/sda internal dump-md
> #
>=20
> version "v09";
>=20
> max-peers 1;
> # md_size_sect 1992
> # md_offset 32212250624
> # al_offset 32212217856
> # bm_offset 32211234816
>=20
> node-id -1;
> current-uuid 0x0000000000000004;
> flags 0x00000080;
> peer[0] {
>     bitmap-index -1;
>     bitmap-uuid 0x0000000000000000;
>     bitmap-dagtag 0x0000000000000000;
>     flags 0x00000000;
> }
> peer[1] {
>     bitmap-index -1;
>     bitmap-uuid 0x0000000000000000;
>     bitmap-dagtag 0x0000000000000000;
>     flags 0x00000000;
> }

> history-uuids {
>         0x0000000000000000; 0x0000000000000000; 0x0000000000000000;
> 0x0000000000000000;

> # al-extents 257;
> la-size-sect 0;
> bm-byte-per-bit 4096;
> device-uuid 0xC789EF231ECD0071;
> la-peer-max-bio-size 0;
> al-stripes 1;
> al-stripe-size-4k 8;
> # bm-bytes 0;
> bitmap[0] {
> }
> # bits-set 0;

> This happens when I try to assign tumbleweed1 (bigger device) the
> primary using the command:
>=20
> # drbdadm -- --overwrite-data-of-peer primary r0

should be enough info for us to reproduce.

For now: just don't do that.
Use devices of the same size everywhere.

Thanks,
	Lars

--=20
: Lars Ellenberg
: http://www.LINBIT.com | Your Way to High Availability
: DRBD, Linux-HA  and  Pacemaker support and consulting

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
