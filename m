Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Problems with DRBD merge-bvec function
Date: Sun, 13 Apr 2008 17:38:10 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767108F030CD@EXNA.corp.stratus.com>
In-Reply-To: 20080411064552.GA22939@mail.linbit.com
References: <342BAC0A5467384983B586A6B0B3767108F02DDB@EXNA.corp.stratus.com><342BAC0A5467384983B586A6B0B3767108F02F3F@EXNA.corp.s
	tratus.com> 20080411064552.GA22939@mail.linbit.com
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

> > That's what I'm testing at the moment -- I reverted the checks in
> both
> > drbd_merge_bvec and drbd_make_request_26.
>=20
> let us know what the impact on performance is.
>=20

It makes things a little better but not much -- after staring at this
for a while, I realized that I've been looking at the disk stats for the
LVM device underneath DRBD (because DRBD currently doesn't implement the
counters exposed in /proc/diskstats) -- at this level, the average size
of a transfer is reduced because of the meta data updates that are going
on; with the specific workload I am testing, I see about 50 AL cache
misses per second - obviously not good (and yes I am experimenting with
increasing the size, but this test is vicious and does random writes all
over the disk).

I've actually been working on adding support for the standard disk
counters - will probably submit a patch for that shortly on the
assumption that it's generally interesting.

> but maybe this had not been your problem at all?
> if any of the lower level devices has a merge_bvec function itself,
> drbd falls back to "PAGE_SIZE" max-segments, unless you have
"use-bmbv"
> enabled, because we currently cannot cope with bios that need not be
> split on the Primary, but would suddenly be split on the Secondary due
> to different lower level constraints.

They don't. However, I don't think the code actually behaves the way you
describe, unless I'm missing something -- in the merge-bvec routine (in
8.0) it has:

	limit =3D DRBD_MAX_SEGMENT_SIZE - ((bio_offset &
(DRBD_MAX_SEGMENT_SIZE-1)) + bio_size);

	if (limit < 0) limit =3D 0;
	if (bio_size =3D=3D 0) {
		if (limit <=3D bvec->bv_len) limit =3D bvec->bv_len;
	} else if (limit && inc_local(mdev)) {
		struct request_queue * const b =3D
mdev->bc->backing_bdev->bd_disk->queue;
		if(b->merge_bvec_fn && mdev->bc->dc.use_bmbv) {
			backing_limit =3D b->merge_bvec_fn(b,bio,bvec);
			limit =3D min(limit,backing_limit);
		}
		dec_local(mdev);
	}

To me, this says it will use the normal 32KB boundary unless use_bmbv is
set in which case it uses the minimum of ours and the lower devices
value... I don't see anything here that would limit the size to 4K.

Simon

