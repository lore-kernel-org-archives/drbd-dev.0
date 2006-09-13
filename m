Return-Path: <Simon.Graham@stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Date: Wed, 13 Sep 2006 14:15:19 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671038B0554@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8 - next crash in bio_split()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Yesterday's checkins have allowed me to get past the booting stage and
I've made some good progress - however, I've started to notice system
crashes when I failover use of one of the drbd devices from one node to
the other - always inside bio_split() at an assert that there is a
single bio_vec in the array (bio->bi_vcnt=3D=3D1).=20

I see that there has been some discussion of this previously
(http://lists.linbit.com/pipermail/drbd-dev/2005-March/000272.html) so
we are all aware that bio_split can only handle a bio with a single
bio_vec -- part of the mega-reorg of request processing was this change:

#if 1
	/* to make some things easier, force allignment of requests
within the
	 * granularity of our hash tables */
	s_enr =3D bio->bi_sector >> HT_SHIFT;
	e_enr =3D (bio->bi_sector+(bio->bi_size>>9)-1) >> HT_SHIFT;
#else
	/* when not using two primaries (and not being as paranoid as
lge),
	 * actually there is no need to be as strict.
	 * only force allignment within AL_EXTENT boundaries */
	s_enr =3D bio->bi_sector >> (AL_EXTENT_SIZE_B-9);
	e_enr =3D (bio->bi_sector+(bio->bi_size>>9)-1) >>
(AL_EXTENT_SIZE_B-9);
#endif

Since HT_SHIFT is 9 and AL_EXTENT_SIZE_B-9 is 13, this means we are far
more likely to decide to split now and maybe it is happening where the
bi_io_vec array has more than one entry...

Simon
