Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Jul 2006 14:56:07 -0400
Message-ID: <342BAC0A5467384983B586A6B0B376710333B373@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Transaction log related assert messages running DRBD 8
	trunk
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Running some failover stress testing with the latest DRBD 8, I have
started to notice assert failures like this:

Jul 24 17:36:22 peer kernel: drbd1: ASSERT( b->br_number =3D=3D =
barrier_nr )
in drbd/drbd_main.c:280=20
Jul 24 17:36:22 peer kernel: drbd1: ASSERT( b->n_req =3D=3D set_size ) =
in
drbd/drbd_main.c:281=20

I'm not quite sure what these mean, but I do note that the code releases
the spin lock before the assert and it occurs to me that perhaps the
D_ASSERTs should also be done with the lock held (see below)?

Simon

--- code from drbd_main.c ---

void tl_release(drbd_dev *mdev,unsigned int barrier_nr,
		       unsigned int set_size)
{
	struct drbd_barrier *b;

	spin_lock_irq(&mdev->tl_lock);

	b =3D mdev->oldest_barrier;
	mdev->oldest_barrier =3D b->next;

	list_del(&b->requests);
	/* There could be requests on the list waiting for completion
	   of the write to the local disk, to avoid corruptions of
	   slab's data structures we have to remove the lists head */

	spin_unlock_irq(&mdev->tl_lock);

	D_ASSERT(b->br_number =3D=3D barrier_nr);
	D_ASSERT(b->n_req =3D=3D set_size);
...

