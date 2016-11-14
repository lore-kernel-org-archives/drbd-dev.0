Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DB5CD1056471
	for <drbd-dev@lists.linbit.com>; Mon, 14 Nov 2016 11:11:09 +0100 (CET)
Date: Mon, 14 Nov 2016 11:11:09 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Wolfgang Walter <linux@stwm.de>
Message-ID: <20161114101109.GW1382@soda.linbit>
References: <6098334.rfGYZxPirJ@stwm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6098334.rfGYZxPirJ@stwm.de>
Content-Transfer-Encoding: quoted-printable
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD: ASSERT in drbd_actlog.c:259
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

On Fri, Nov 11, 2016 at 06:45:18PM +0100, Wolfgang Walter wrote:
> Hello,
>=20
> when I execute
>=20
> mkfs.ext4 -J device=3DUUID=3D625d871f-c278-4acb-916d-774dc78dbd8a -v -b=
 4096 -E stride=3D$((512/4)),stripe_width=3D$((512/4*3)),lazy_itable_init=
=3D0 -O inline_data,mmp -L dyn -m .01 /dev/test/big
>=20
> the command hangs

It should not hang, really, but it is probably too busy spewing below
message to the console over and over again.

There have been some problems with our trim/discard handling in some situ=
ations.
That's also why this does not happen if you say nodiscard.

> and the kernel (4.4.30) complains:
>
> block drbd1: ASSERT( (unsigned)(last - first) <=3D 1 ) in drivers/block=
/drbd/drbd_actlog.c:259

see:
commit 505675f96cf0f169647a18c3dda1f373eca957b1
Author: Lars Ellenberg <lars.ellenberg@linbit.com>
Date:   Tue Jun 14 00:26:23 2016 +0200

    drbd: allow larger max_discard_sectors
   =20
    Make sure we have at least 67 (> AL_UPDATES_PER_TRANSACTION)
    al-extents available, and allow up to half of that to be
    discarded in one bio.
   =20
    Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
    Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
    Signed-off-by: Jens Axboe <axboe@fb.com>

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_a=
ctlog.c
index d524973..265b2b6 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -258,7 +258,7 @@ bool drbd_al_begin_io_fastpath(struct drbd_device *de=
vice, struct drbd_interval
 	unsigned first =3D i->sector >> (AL_EXTENT_SHIFT-9);
 	unsigned last =3D i->size =3D=3D 0 ? first : (i->sector + (i->size >> 9=
) - 1) >> (AL_EXTENT_SHIFT-9);
=20
-	D_ASSERT(device, (unsigned)(last - first) <=3D 1);
+	D_ASSERT(device, first <=3D last);
 	D_ASSERT(device, atomic_read(&device->local_cnt) > 0);
=20
 	/* FIXME figure out a fast path for bios crossing AL extent boundaries =
*/

...
and some more chunks, but you should not cherry-pick stuff "just so",
if it may change semantics ...

kernel v4.4 is roughly equivalent to out-of-tree drbd 8.4.5,
we are at 8.4.9 meanwhile, so you may want to try that as well.

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
