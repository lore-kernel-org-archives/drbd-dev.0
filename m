Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Crash in lru_cache.c
Date: Sat, 12 Jan 2008 10:23:58 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107C5B0B7@EXNA.corp.stratus.com>
In-Reply-To: 20080112135136.GA23622@debian-etc-mailname
References: <342BAC0A5467384983B586A6B0B3767107C5AE45@EXNA.corp.stratus.com><342BAC0A5467384983B586A6B0B3767107C5AE95@EXNA.corp.s
	tratus.com> 20080112135136.GA23622@debian-etc-mailname
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> > Because there WAS a disk when the request was issued - in fact, the
> > local write to disk completed successfully, but the request is still
> > sitting in the TL waiting for the next barrier to complete.
> Subsequent
> > to that but while the request is still in the TL, the local disk is
> > detached.
>=20
> AND it is re-attached so fast,
> that we have a new (uhm; well, probably the same?) disk again,
> while still the very same request is sitting there
> waiting for that very barrier ack?
>=20

You got it!

> now, how unlikely is THAT to happen in real life.
>=20

Fairly rare I agree although someone could do a 'drbdadm detach' and
then 'drbdadm attach' -- that's how we hit this situation (and the
reason for THAT is as a way to test errors on meta-data reads)

Given that there is no real boundary on the lifetime of a request in the
TL, it's also feasible (although unlikely I agree) that a disk could
fail and be replaced and reattached whilst an old request is still in
the TL...

> > I think this might work but only as a side effect -- if you look
back
> to
> > the sequence I documented, you will see that there has to be a write
> > request to the same AL area after the disk is reattached - this is
> > because drbd_al_complete_io quietly ignores the case where no active
> AL
> > extent is found for the request being completed.
>=20
> huh?
> I simply disallow re-attaching while there are still requests pending
> from before the detach.
> no more (s & RQ_LOCAL_MASK), no more un-accounted for references.
>=20

Yes but those requests that have unaccounted references from before the
detach are still in the TL -- it so happens that the code does not crash
in this case (completing a request in the TL when there is no matching
AL cache entry) but that's not very safe I think.

You also have to trigger a barrier as part of this -- not only block new
requests during attach until the TL is empty but also trigger a barrier
so that the TL will be emptied...

Both of these are why I like the idea of "reconnecting" the requests in
the TL to the AL cache when doing an attach...

> if I understand correctly,
> you can reproduce this easily.
> to underline my point,
> does it still trigger when you do
>  "dd if=3D/dev/drbdX of=3D/dev/null bs=3D1b count=3D1 iflag=3Ddirect ; =
sleep 5"
> before the re-attach?

So, the real test is to do this _before_ the DETACH, then see what
happens when the requests are removed from the TL.

> for other reasons, I think we need to rewrite the barrier code anyways
> to send out the barrier as soon as possible, and not wait until the
> next
> io request comes in.

That's an interesting idea -- it would also allow you to use the Linux
barrier mechanism to implement. Still wouldn't handle this case I think
though -- you can have requests in the TL that do not yet require a
barrier when you lose the local disk...

Simon
