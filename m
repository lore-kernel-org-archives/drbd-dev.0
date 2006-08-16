Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8 - crash due to NULL page* in drbd_send_page
Date: Tue, 15 Aug 2006 23:32:25 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103625363@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <Lars.Ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Thanks for the update (and for responding when you are supposed to be on
holiday!)

> But I don't really think that is the problem for that NULL pointer.
> There is something else going on here, see below.
> Just for debugging: could you try switching that zero copy off,
> and use the copy-on-send?
>=20

I'll give that a go tomorrow.

>=20
> but I don't get it.
> the WriteAck is sent by the peer after it successfully received the
> data, read it into some pages attached to some bio, submitted this
bio,
> and got a completion event from disk...
> this WriteAck simply _cannot_ be received before the data is
> successfully transmitted, so the _drbd_send_zc_bio has long finished.
>=20

Well, I would have thought so to BUT I can see a way it could happen if
the system is very busy (which it is) -- I think that drbd_send_zc_bio
gets to the point of sending the very last bvec and passes the data to
TCP which pends because of some resource issue (such as the send window
being full) -- the data is then sent (I'm guessing) from the context of
whatever interrupt that makes the resource available and the worker
thread is made ready to run but never actually gets to run before the
Ack arrives from the other box (which is NOT particularly busy).

The only real evidence I have is the trace and the fact that I hit the
assert that the on-wire flag should be set. If we look closely at the
first trace, we see:

> > drbd1: data >>> Data (sector 1560250, id e7f15e10, seq b75, f 0)

(this is just before w_send_dblock sends the data)

> > drbd1: meta <<< WriteAck (sector 1560250, size 1000, id e7f15e10,
seq
> > b75)

(here's the ack for that sector)

> > drbd1: in got_BlockAck:2796: ap_pending_cnt =3D -1 < 0 !
> > drbd1: Sector 1560250, id e7f15e10, seq b75
> >

and we assert that the pending count went -ve

> > drbd1: drbd_send_zc_bio - NULL Page; bio eb49d380, bvec c07678fc
> > drbd1:     sector: 1560250, block_id: e7f15e10, seq b75

And here we are in drbd_send_zc_bio for the same sector, same block id,
same sequence number, so I think we're still in the call that started
where the original Data trace was output.

If you add to that the fact that this explains the assert failure on
ap_pending_cnt _and_ my new assert on the on-wire flag, it seems to me
to be fairly convincing that somehow we get the Ack before the send_zc
call has finished looping through the bvec's in the bio...

All I can do is quote the old adage - 'where there's a window there's a
bug' ;-)

> so if you see NULL pages there, we have an invalid bio.

BTW - sometimes, I don't hit the test for NULL, I just crash on a
completely bogus pointer value -- this smacks of the bio being freed
while we are still referencing it.

>=20
> how is your test setup this time?
>=20

So, I'm running four DRBD volumes, three of them in use by apps running
stress (which use large amounts of CPU) and one lightly used for logging
info. There is no resync in progress, just the test stress. The systems
are DP Dell boxes with a dedicated gbit link used by DRBD traffic.

>=20
> the problems I see are broken cleanup during connection loss,
> some lately (re)introduced (probably harmless but annoying) races
> during resync with concurrent application writes, and unpleasant
> suprises when we try to handle disk failures.
>=20

Yah -- I'm trying to get back to my work on handling the disk failures
(removing panics in particular) but I need a stable base for this.

Simon

