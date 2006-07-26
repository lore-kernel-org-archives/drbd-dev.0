Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher EXP1024-RC4-SHA (56/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 4B7932CDC49A
	for <drbd-dev@lists.linbit.com>; Wed, 26 Jul 2006 10:11:23 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Transaction log related assert messages running DRBD 8
	trunk
Date: Wed, 26 Jul 2006 10:11:22 +0200
References: <342BAC0A5467384983B586A6B0B376710333B373@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B376710333B373@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200607261011.22627.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 25. Juli 2006 20:56 schrieb Graham, Simon:
> Running some failover stress testing with the latest DRBD 8, I have
> started to notice assert failures like this:
>
> Jul 24 17:36:22 peer kernel: drbd1: ASSERT( b->br_number =3D=3D barrier_n=
r )
> in drbd/drbd_main.c:280
> Jul 24 17:36:22 peer kernel: drbd1: ASSERT( b->n_req =3D=3D set_size ) in
> drbd/drbd_main.c:281
>
> I'm not quite sure what these mean, but I do note that the code releases
> the spin lock before the assert and it occurs to me that perhaps the
> D_ASSERTs should also be done with the lock held (see below)?
>
> Simon
>
> --- code from drbd_main.c ---
>
> void tl_release(drbd_dev *mdev,unsigned int barrier_nr,
> 		       unsigned int set_size)
> {
> 	struct drbd_barrier *b;
>
> 	spin_lock_irq(&mdev->tl_lock);
>
> 	b =3D mdev->oldest_barrier;
> 	mdev->oldest_barrier =3D b->next;
>
> 	list_del(&b->requests);
> 	/* There could be requests on the list waiting for completion
> 	   of the write to the local disk, to avoid corruptions of
> 	   slab's data structures we have to remove the lists head */
>
> 	spin_unlock_irq(&mdev->tl_lock);
>
> 	D_ASSERT(b->br_number =3D=3D barrier_nr);
> 	D_ASSERT(b->n_req =3D=3D set_size);
> ...
>

Hi Simon,

Currently the code looks like this:

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

#ifdef DBG_ASSERTS
	if(b->br_number !=3D barrier_nr) {
		DUMPI(b->br_number);
		DUMPI(barrier_nr);
	}
	if(b->n_req !=3D set_size) {
		DUMPI(b->n_req);
		DUMPI(set_size);
	}
#endif

	kfree(b);
}


In case they are different you should also see the nubers.=20
BTW, the spinlock only protects the linked lists. Looking at
the content of the barrier object is ok.

PS: Recently I was quite active in this parts of the code, with
    the current SVN head, these ASSERTS should not trigger.

BTW: The meaning is, we sent a number of write requests between
     two barriers. When the barrier ACK of the peer comes in
     we verify that the peer wrote the same number of writes
     between those two barriers.

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
