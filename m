Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8 - next crash in bio_split()
Date: Wed, 13 Sep 2006 16:41:25 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671038B05D1@EXNA.corp.stratus.com>
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

> Index: drbd_req.c
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drbd_req.c	(revision 2415)
> +++ drbd_req.c	(working copy)
> @@ -1068,7 +1068,11 @@
>  	unsigned int bio_size =3D bio->bi_size;
>  	int max;
>=20
> +#if 1
> +	max =3D DRBD_MAX_SEGMENT_SIZE - ((bio_offset &
> (DRBD_MAX_SEGMENT_SIZE-1)) + bio_size);
> +#else
>  	max =3D AL_EXTENT_SIZE - ((bio_offset & (AL_EXTENT_SIZE-1)) +
> bio_size);
> +#endif
>  	if (max < 0) max =3D 0;
>  	if (max <=3D bvec->bv_len && bio_size =3D=3D 0)
>  		return bvec->bv_len;

I'm not sure to be honest - I take it the intent here is to ensure there
can only ever be one bio_vec in a bio that needs to be split? And the
way to do that is to ensure that the only way a request that is too
large can be passed to DRBD is if it is the first entry that is too
large?

I'll try this and let you know...
