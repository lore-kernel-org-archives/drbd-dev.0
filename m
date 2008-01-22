Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Barrier assert failures with latest 8.0 sources
Date: Tue, 22 Jan 2008 15:49:19 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107E89E95@EXNA.corp.stratus.com>
In-Reply-To: 20080122162007.GD7594@barkeeper1.linbit
References: <342BAC0A5467384983B586A6B0B3767107E89B46@EXNA.corp.stratus.com><342BAC0A5467384983B586A6B0B3767107E89D34@EXNA.corp.s
	tratus.com> 20080122162007.GD7594@barkeeper1.linbit
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

> > I think the problem is that tl_clear does NOT clear the
> CREATE_BARRIER
> > bit from mdev->flags - so if we disconnect in the small window
> between
> > setting this bit and creating the new barrier, then when we
reconnect
> > and send the first request, we'll end up creating a new barrier
> before
> > sending the BarrierRq(4711) (processing the first request that has
to
> go
> > remote) and I think this gets us into the cycle of always being one
> > barrier behind the remote system... this would also explain why the
> > assert is intermittent since you have to disconnect in a small
> window...
> >
> > Seem reasonable?
>=20
> absolutely.
>=20
>  :)

Reasonable - yes, correct - no ;-(

Clearing the bit in tl_clear didn't work so I dug some more and I think
I _really_ found it this time...

In _about_to_complete_local_write, we see this code:

	/* before we can signal completion to the upper layers,
	 * we may need to close the current epoch */
	if (req->epoch =3D=3D mdev->newest_barrier->br_number)
		queue_barrier(mdev);

This can be true when the connection is not active _if_ the connection
is torn down before the first I/O completes (seems a little unlikely,
but possible) - in that case, the req->epoch will be 4711 and the
disconnect cleared out the list so that newest_barrier->br_number is
4711... so we go ahead and call queue_barrier() which sets the
CREATE_BARRIER bit...

I think this will also result in inc_ap_pending() being called with no
matching decrement - when the worker thread runs w_send_barrier, it will
detect that the conn state is < Connected and bail without decrementing
the count...

I do feel that the situations when this can arise should be incredibly
rare - the connection has to fail between issuing the first request and
the time it completes... and yet I can hit this problem fairly easily,
so maybe there is some other situation I haven't thought of that causes
this path to be taken.

Anyway - presumably the fix is to modify
_about_to_complete_local_write() to not do the barrier stuff unless the
connection state is >=3D Connected?

Simon
