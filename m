Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Running Protocol C with disk cache enabled
Date: Wed, 20 Jun 2007 15:47:02 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767105DEB765@EXNA.corp.stratus.com>
In-Reply-To: 20070620163120.GC24827@ogo.aicooma.com
References: <342BAC0A5467384983B586A6B0B3767105BD4EEC@EXNA.corp.stratus.com><200706201533.14467.philipp.reisner@linbit.com>
	20070620163120.GC24827@ogo.aicooma.com
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

> > > acknowledged prior to the failure. Now, I think that the activity
> log
> > > maintained by the Primary actually includes the necessary
> information
> > > about blocks which should be resynchronized _but_ I don't see any
> code
> > > that would actually add these blocks to the bitmap when such a
> failure
> > > occurs.
> > >
> >
> > Right we do not do this. The current opinion on this is: If the
> > disk reported IO completion it has to be on disk. (actually a point
> > of view of the Linux-2.2 and Linux-2.4 time).
>=20
> Me and Phil had a few words about this.
>=20
> Now, lying hardware is sooo broken :(
> but, anyways.
>=20

Well, I look at this slightly differently; use of the on-disk cache is
really the only way to get decent (i.e. competitive) performance out of
rotating rust, so what we have to do is find ways to allow this and
still be correct.

BTW: another case that is of interest to me is when you have a caching
controller -- even though these have battery backup, there is still the
case to worry about when the controller itself fails (something we have
to worry about when building fault tolerant servers) -- in this case, it
should be possible to repair/replace the failed controller and then
reboot and have DRBD resync correctly...

>=20
> we would basically maintain the activity log on the secondary
> as well, and introduce an additional "cleanly detached" flag.
>=20
> whenever you attach it again, the extents covered would need to be
> resynced.  obviously this behaviour should be configurable, you want
to
> disable it for good hardware and large activity log.
>=20
> I can think of few possible optimizations, even...
> but we should not over-engineer what is "just" a workaround.
>=20

I thought about this too -- however, I managed to convince myself that
it isn't necessary to store the AL on both disks since we can use the AL
from the disk that was primary (wouldn't they be identical?) -- maybe
there's a case I'm not considering though.

Would it be enough to modify the code to add the current AL to the
in-memory and on-disk bitmaps on the primary whenever you lose contact
with the peer??? I realize this is different from how it is handled for
the loss-of-primary case...

Simon


