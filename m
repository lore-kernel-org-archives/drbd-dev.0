Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D0D97101AC7E
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 12:15:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BE9402A5686
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 12:15:03 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id YQykAgreB5s1 for <drbd-dev@lists.linbit.com>;
	Wed, 24 Sep 2014 12:15:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A5EA52A5AAD
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 12:15:03 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HVJutSSvRsiT for <drbd-dev@lists.linbit.com>;
	Wed, 24 Sep 2014 12:15:03 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 654D62A5686
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 12:15:03 +0200 (CEST)
Date: Wed, 24 Sep 2014 12:14:51 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140924101451.GC7118@soda.linbit>
References: <20140919094909.GA21578@schiffbauer.net>
	<20140919144805.GS13125@soda.linbit>
	<20140919151653.GH21578@schiffbauer.net>
	<20140923110348.GA19076@soda.linbit>
	<20140923181421.GB32597@schiffbauer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20140923181421.GB32597@schiffbauer.net>
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

On Tue, Sep 23, 2014 at 08:14:21PM +0200, Marc Schiffbauer wrote:
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
>=20
>=20
> Another question PaX-Team is asking:
>=20
> what about rs_sect_in?

That usually should not overflow, as it is typically regularly (several
times per second) reset to zero (and for other reasons).

If you manage to transfer more 2 TiByte in subseconds via a single TCP
connection, more power to you.

Still, if it should overflow (for whatever reason), no real harm done.
Arbitrarily sending a signal or terminating processes in that case would
be the only actually disturbing thing.

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
