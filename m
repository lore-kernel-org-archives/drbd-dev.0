Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] [PATCH] Supporting barriers in DRBD, part 1
Date: Sun, 25 Nov 2007 15:30:42 -0500
Message-ID: <342BAC0A5467384983B586A6B0B37671072830A9@EXNA.corp.stratus.com>
In-Reply-To: 20071125192059.GA10009@racke.local
References: <342BAC0A5467384983B586A6B0B37671072830A7@EXNA.corp.stratus.com>
	20071125192059.GA10009@racke.local
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

Thanks for the comments Lars,

To answer questions/comments:

> since you say "part 1", what will the next part be?
> defer "_req_is_done" until the corresponding barrier ack,
> even for protocol C?
>=20

Well, Part 2 will be integrating the TL into recovery when we lose
contact with the secondary - not sure I want to add this feature as
well.

>=20
> 	or, preferably, we finally allocate local and remote error flag
> 	members in struct drbd_request, and properly deal with it :)
>=20
> 	meaning we could (at least for protocol C) notice, distinguish,
> 	and recover from both local and remote ENOTSUPP, for a barrier
> 	request.

I thought about something like this but it gets (more) complicated --
what we should really do in the case where a barrier request results in
-EOPNOTSUPP from either side is return -EOPNOTSUPP to the master bio (so
that we tell the DRBD user that barriers don't work) - I don't think,
for example, that we should retry the request without the barrier bit on
behalf of our user.

As far as protocol goes - I think we need to make sure this failure is
reported in all protocols which means more protocol changes.

> > 4.       Forced a meta data write when a disk is attached so that we
> > determine early on whether or not barriers are supported.
>=20
> remains the problem of storage area device !=3D meta data area device.
>=20

Rats! I always forget that -- I guess that means we really have to
implement per-I/O checking until we know barriers are not supported on
one or both sides _and_ save a separate bit for metadata and storage
area devices in case they are different...

> > 5.       Extended the tracing of BIO's to include internally
> generated
> > BIOs as well as the ones from above
>=20
> would you agree if we changed that to no longer use printk,
> but to netlink-broadcast to userspace,
> so you'd be able to see them with "drbdsetup events"?
>=20
> I did that already for some other reasons,
> so the code is basically there.
>=20

I think that would be fine.

> > 3.       I think we can remove the #ifdef BIO_RW_XXX - certainly
they
> > are not present everywhere these macros are referenced...
>=20
> I'll have to check that. we still try to support even 2.6.5-something.
>=20

So, there are some places where you unconditionally checked
BIO_RW_BARRIER previously (I either fixed these or used bio_barrier(bio)
instead, but that shouldn't change whether or not this thing builds on
older releases.

