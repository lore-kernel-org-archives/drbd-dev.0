Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Problems with code to disallow connection when peer
	has mismatched UUID
Date: Tue, 16 Sep 2008 15:14:52 -0400
Message-ID: <DA0E7D869C862D4095C265233CD1D41E01192F53@EXNA.corp.stratus.com>
In-Reply-To: <DA0E7D869C862D4095C265233CD1D41E01192D4A@EXNA.corp.stratus.com>
References: <DA0E7D869C862D4095C265233CD1D41E011929A3@EXNA.corp.stratus.com>20080911092451.GB9756@soda.linbit
	<DA0E7D869C862D4095C265233CD1D41E011929C8@EXNA.corp.stratus.com>
	<DA0E7D869C862D4095C265233CD1D41E01192D4A@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>,
	<drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hah! I just realized that the current HEAD in the 8.2 tree already
includes this - thanks Phil!

So - just ignore this one.
Simon

> -----Original Message-----
> From: Graham, Simon
> Sent: Monday, September 15, 2008 10:41 AM
> To: Graham, Simon; drbd-dev@linbit.com
> Subject: RE: [Drbd-dev] Problems with code to disallow connection when
> peer has mismatched UUID
>=20
> Attached is a proposed patch to address this problem that does the
> following:
>=20
> 1. When connection is lost, a new UUID is not created on the primary
if
> the local disk is inconsistent
> 2. Allow connection to be established if local disk is inconsistent
> even if the remote is using
>    a different UUID - our data is useless and cannot have been changed
> anyway. The following handshake
>    will cause the appropriate resync.
>=20
> Although only one of these is actually required to fix my problem, I
> thought it was better to be consistent
> and change both.
>=20
> Simon
>=20
> > -----Original Message-----
> > From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-
> bounces@linbit.com]
> > On Behalf Of Graham, Simon
> > Sent: Thursday, September 11, 2008 6:33 AM
> > To: drbd-dev@linbit.com
> > Subject: RE: [Drbd-dev] Problems with code to disallow connection
> when
> > peerhasmismatched UUID
> >
> > Thanks Lars,
> >
> > > > I'm not sure what the right answer is here, but I have a couple
> of
> > > > observations:
> > > > 1. When we lose connection and are Primary/Inconsistent, should
> we
> > > > really create a new current UUID? The local data is bad.
> > >
> > > I don't think we should.
> >
> > OK - I'll look at implementing this.
> >
> > > that piece of code is to avoid "time warps" of content.
> > > the specific scenario this should protect against is:
> > >
> > > Primary, Connected
> > >  connection breaks.
> > > Primary  ---?
> > >  primary generates new "current uuid",
> > >  and continues to write
> > >  local disk breaks
> > > Primary, Diskless, ---?
> > >  connection heals
> > >
> > > now, if we allow this connection and accept the data of the
> > secondary,
> > > we just jumped back in time.
> >
> > Ah OK -- would it perhaps then be OK to check for local disk state
<=3D
> > Negotiating instead of < Outdated:
> >
> > 	if (mdev->state.conn < Connected &&
> > 	    mdev->state.disk <=3D Negotiating &&
> > 	    mdev->state.role =3D=3D Primary &&
> > 	    (mdev->ed_uuid & ~((u64)1)) !=3D (p_uuid[Current] &
> > ~((u64)1))) {
> > 		ERR("Can only connect to data with current
> > UUID=3D%016llX\n",
> > 		    (unsigned long long)mdev->ed_uuid);
> > 		drbd_force_state(mdev,NS(conn,Disconnecting));
> > 		return FALSE;
> > 	}
> >
> > This would handle the case we see where we KNOW the local disk does
> not
> > have good data... (and we knew before the connection was lost, so we
> > would NOT have actually been able to change the local copy of the
> data
> > on disk).
> >
> > Simon
> > _______________________________________________
> > drbd-dev mailing list
> > drbd-dev@lists.linbit.com
> > http://lists.linbit.com/mailman/listinfo/drbd-dev
