Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Problems with DRBD merge-bvec function
Date: Thu, 10 Apr 2008 18:13:46 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767108F02F3F@EXNA.corp.stratus.com>
In-Reply-To: 20080410212131.GA12178@racke.local
References: <342BAC0A5467384983B586A6B0B3767108F02DDB@EXNA.corp.stratus.com>
	20080410212131.GA12178@racke.local
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

Lars,

Thanks for the swift and comprehensive response - gonna have to digest
this for a bit but I do have some questions:

> to make it impossible for two "simultaneous" io requests to the same
> region
> to reach the disks in different order, we need to check for conflicts.
> these conflicts are easy to provoke by just doing multiple "dd
> oflag=3Ddirect"
> to the same block on an smp box, so the risk is real.
> even when not using two primaries.
>=20

Hmm.. the result of such badness is undefined, but I guess we should try
and make DRBD have the same result on both sides in this case... cant
say I'm entirely convinced though -- if you do bad things, you get bad
results!

> conflict detection works by just checking the collision chain for
> overlapping
> requests.  if we allow a request to cross collision chain boundaries,
> we'd have
> to check three colision chains for the single request, which would be
> not that
> bad...  but this degenerates when looking at the problem more
> thoroughly.  I

Hmm.. this one escapes me - I can see how you have to potentially search
three chains for collisions (the one before and the two that the request
spans) but if the max rq size is 32KB and the bucket size is 32KB, how
can it expand beyond the three?

I'm sure you are right, just trying to understand...

> or ignore the risk (any application triggering these sanity checks is
> seriously
> broken and would probably not work anyways, so as long as you have an
> established file system/data base, arguably you can assume that this
> check is
> just too paranoid, at least in the one-primary case).
> if you chose this option, just revert it to the 4MB boundary check we
> used to have.  this one has to stay, though, the activity log depends
> on
> it, one al-extent coverse 4MB.
>=20

That's what I'm testing at the moment -- I reverted the checks in both
drbd_merge_bvec and drbd_make_request_26.

Thanks again for the invaluable information
Simon
