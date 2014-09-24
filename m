Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1876D101AC7E
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 12:04:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 0C2332A0C2F
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 12:04:45 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id takVhiVl4hgw for <drbd-dev@lists.linbit.com>;
	Wed, 24 Sep 2014 12:04:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E236F2A5795
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 12:04:44 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Bfic6AfTpaX0 for <drbd-dev@lists.linbit.com>;
	Wed, 24 Sep 2014 12:04:44 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 36A682A0C2F
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 12:04:44 +0200 (CEST)
Date: Wed, 24 Sep 2014 12:04:42 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140924100442.GB7118@soda.linbit>
References: <20140919094909.GA21578@schiffbauer.net>
	<20140919144805.GS13125@soda.linbit>
	<20140919151653.GH21578@schiffbauer.net>
	<20140923110348.GA19076@soda.linbit>
	<20140923170824.GA32597@schiffbauer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20140923170824.GA32597@schiffbauer.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] drbd 8.4.3: refcounter overflow on re-sync
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

On Tue, Sep 23, 2014 at 07:08:24PM +0200, Marc Schiffbauer wrote:
> * Lars Ellenberg schrieb am 23.09.14 um 13:03 Uhr:
> >On Fri, Sep 19, 2014 at 05:16:53PM +0200, Marc Schiffbauer wrote:
> >>* Lars Ellenberg schrieb am 19.09.14 um 16:48 Uhr:
> >>>On Fri, Sep 19, 2014 at 11:49:09AM +0200, Marc Schiffbauer wrote:
> >>>>Hi,
> >>>>
> >>>
> >>>If you resolve that to a code line,
> >>>I may be able to figure out what PAX is talking about.
> >>>
> >>>But from this stack trace alone, I have absolutely no idea what PAX
> >>>is trying to say, which refcount could possibly be meant there,
> >>>let alone why it could possibly overflow or.
> >>>
> >>>Ah, ok. Looking at [1], "PaX Team" says:
> >>>.---
> >>>| after having looked at the drbd code a bit i think this could be a
> >>>| real bug in drbd but only upstream can tell for sure so you'll hav=
e to
> >>>| contact them. you can show them the following that i figured out s=
o far:
> >>>|
> >>>| the refcount overflow was detected in
> >>>| drivers/block/drbd/drbd_bitmap.c:bm_page_io_async at the
> >>>|
> >>>| atomic_add(len >> 9, &mdev->rs_sect_ev)
> >>>
> >>>Well, yes, why would it not overflow.
> >>>It is *not* a refcount.
> >>>It is an atomic counter.
> >>>It is meant to overflow.
> >>
> >>Ok, then I can report this back and it should be fixed in PaX as a
> >>false postive. Thanks for clarifying this.
> >
> >I still don't get why PAX is even sending a signal there.
> >How could sending a signal possibly help against an overflowing counte=
r?
>=20
>=20
> PAX is a patchset for the linux kernel that hardens the kernel in
> several ways.
>=20
> The REFCOUNT feature will detect and prevent overflowing of
> refcounters.
>=20
> This is a good introduction of what it does:
> http://wiki.gentoo.org/wiki/Hardened/PaX_Quickstart

Yeah.

Why would sending a signal to the current thread prevent a counter from
overflowing. How could that possibly improve the overall situation,
even assuming that the overflow would have bad side effects?

Never mind.  This won't be a fruitful discussion...

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
