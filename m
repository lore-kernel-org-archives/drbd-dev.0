Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8: BUG when disk write errors occur duringheavyI/O
Date: Thu, 11 Jan 2007 20:45:00 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767104614969@EXNA.corp.stratus.com>
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

>=20
> hm. but that would make the "local" reference count be a network
> reference count, too, it may even keep the reference for a long time
> if you configure it to freeze io on connection loss...
>=20
> not good.

Good point...

>=20
> so maybe we rather want to brace drbd_al_complete_io
> with inc_local dec_local ?
>=20
> currently we only call it in three places,
> early bail out on conflicting writes in drbd_make_request
> [which holds local ref], drbd_endio_write_sec when the
> EE_CALL_AL_COMPLETE_IO flag is set [also holds a local ref]
> and this code in question.
>=20
> so how about this (sorry for the long lines):

Looks good to me -- with Phil's previous change we have an extra
reference sometimes (since in some cases we still have the ref for the
local request) but that's not a problem.

I'll try this out and get back to you.
Simon
