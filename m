Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Handling on-disk caches
Date: Wed, 7 Nov 2007 09:16:45 -0500
Message-ID: <342BAC0A5467384983B586A6B0B37671070749B3@EXNA.corp.stratus.com>
In-Reply-To: 20071107140302.GE11379@barkeeper1.linbit
References: <342BAC0A5467384983B586A6B0B376710707496D@EXNA.corp.stratus.com>
	20071107140302.GE11379@barkeeper1.linbit
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> > I think the solution to this consists of a number of changes:
>=20
> I think there is no solution to this short of fixing the lower
> layers/hardware to not tell lies.
>=20

Don't think of it as lying -- instead consider it as an enhanced disk
interface that provides the means to get improved performance out of the
disk; the barrier implementations provide the tools necessary to get
this performance benefit safely, we just need to make use of them (and
ensure that all out of sync blocks are resynced).

> > 2. Meta-data updates (certainly the AL but possibly all meta-data
> > updates) should be issued as barrier requests (so that we know these
> > are on disk before issuing the associated writes) (I don't think
they
> > are currently)
>=20
> I may be wrong, but even with barrier requests,
> I doubt that a device with volatile write cache enabled would
> handle such a "barrier" thing any different.
>=20

No they do -- the block layer code will issue flush requests and writes
with the FUA bit set for example to ensure barrier requests are actually
on rotating rust before continuing. Certainly this doesn't work _unless_
the underlying HBA/Disks support provides at least a flush operation
(and preferably both flush and FUA). There's a good description of this
in the Linux doc tree -- documentation/block/barrier.txt from your
favourite source tree -- see section 2. - Forced flushing to physical
medium.

> any network hickup would cause a resync of the area equivalent to the
> activity log (several GB in most cases), were it would have caused
only
> very few blocks to be resynced now.
>=20

Well, this is a good argument for implementing option b) -- keep the AL
on both primary and secondary -- that way, we only do the extra resync
if the secondary actually crashes as opposed to simply losing the
network connection for a while. More complex but better performing in
the face of network glitches.

> hm. but better sync some GB to much than overlook one KB, right.

Correct!

Thanks,
Simon
