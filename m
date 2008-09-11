Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Problems with code to disallow connection when peerhas
	mismatched UUID
Date: Thu, 11 Sep 2008 06:33:01 -0400
Message-ID: <DA0E7D869C862D4095C265233CD1D41E011929C8@EXNA.corp.stratus.com>
In-Reply-To: 20080911092451.GB9756@soda.linbit
References: <DA0E7D869C862D4095C265233CD1D41E011929A3@EXNA.corp.stratus.com>
	20080911092451.GB9756@soda.linbit
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Thanks Lars,

> > I'm not sure what the right answer is here, but I have a couple of
> > observations:
> > 1. When we lose connection and are Primary/Inconsistent, should we
> > really create a new current UUID? The local data is bad.
>=20
> I don't think we should.

OK - I'll look at implementing this.

> that piece of code is to avoid "time warps" of content.
> the specific scenario this should protect against is:
>=20
> Primary, Connected
>  connection breaks.
> Primary  ---?
>  primary generates new "current uuid",
>  and continues to write
>  local disk breaks
> Primary, Diskless, ---?
>  connection heals
>=20
> now, if we allow this connection and accept the data of the secondary,
> we just jumped back in time.

Ah OK -- would it perhaps then be OK to check for local disk state <=3D
Negotiating instead of < Outdated:

	if (mdev->state.conn < Connected &&
	    mdev->state.disk <=3D Negotiating &&
	    mdev->state.role =3D=3D Primary &&
	    (mdev->ed_uuid & ~((u64)1)) !=3D (p_uuid[Current] &
~((u64)1))) {
		ERR("Can only connect to data with current
UUID=3D%016llX\n",
		    (unsigned long long)mdev->ed_uuid);
		drbd_force_state(mdev,NS(conn,Disconnecting));
		return FALSE;
	}

This would handle the case we see where we KNOW the local disk does not
have good data... (and we knew before the connection was lost, so we
would NOT have actually been able to change the local copy of the data
on disk).

Simon
