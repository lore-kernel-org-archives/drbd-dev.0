Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8 - handling data write errors
Date: Thu, 11 Jan 2007 10:50:27 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767104614838@EXNA.corp.stratus.com>
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

> this is not a short-term project, but
> how about this:
>  introduce an additional "badblocks" bitmap -- actually, I think
> probably
>  a "range-list" type of storage would be appropriate here.
>=20
>  local read error:
>     mark dirty, read full blocks remotely (which may be more than the
>     application requested), write -- written ok: mark clean again.
>  local write error:
>     mark block (range) as bad,
>     mark system "degraded"
>  both blocks bad, or remote not reachable:
>     pass to upper layers.
>=20

You are right - it's not short term! Also;
. I think it'd be necessary to write this new badblocks structure to the
on-disk=20
  meta-data so we'd need to allocate space for it
. We'd then need to deal with the case of having no more space to record
badblocks (the
  disk is pretty toasty in this case - maybe just detach).

You know, the underlying disks already include a lot of this
functionality and the more I think about it, the more convinced I am
that detaching on any error is the right thing to do --=20
. DRBD already (I think) correctly handles things if you re-attach
following this (it'll try=20
  to resync the failed blocks and if that fails it would detach again).
. Although this seems like you end up doing a lot of work, these errors
are unlikely so I
  think it's OK to use a large hammer.

I'm going to do some experiments with the error handler set to Detach -
will report back on results.
Simon

