Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6FAA02CF774E
	for <drbd-dev@lists.linbit.com>; Wed, 13 Sep 2006 22:01:05 +0200 (CEST)
Date: Wed, 13 Sep 2006 22:01:05 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 - next crash in bio_split()
Message-ID: <20060913200105.GA31250@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B37671038B0554@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B37671038B0554@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-09-13 14:15:19 -0400
\ Graham, Simon:
> Yesterday's checkins have allowed me to get past the booting stage and
> I've made some good progress - however, I've started to notice system
> crashes when I failover use of one of the drbd devices from one node to
> the other - always inside bio_split() at an assert that there is a
> single bio_vec in the array (bio->bi_vcnt==1). 
> 
> I see that there has been some discussion of this previously
> (http://lists.linbit.com/pipermail/drbd-dev/2005-March/000272.html) so
> we are all aware that bio_split can only handle a bio with a single
> bio_vec -- part of the mega-reorg of request processing was this change:
> 
> #if 1
> 	/* to make some things easier, force allignment of requests
> within the
> 	 * granularity of our hash tables */
> 	s_enr = bio->bi_sector >> HT_SHIFT;
> 	e_enr = (bio->bi_sector+(bio->bi_size>>9)-1) >> HT_SHIFT;
> #else
> 	/* when not using two primaries (and not being as paranoid as
> lge),
> 	 * actually there is no need to be as strict.
> 	 * only force allignment within AL_EXTENT boundaries */
> 	s_enr = bio->bi_sector >> (AL_EXTENT_SIZE_B-9);
> 	e_enr = (bio->bi_sector+(bio->bi_size>>9)-1) >>
> (AL_EXTENT_SIZE_B-9);
> #endif
> 
> Since HT_SHIFT is 9 and AL_EXTENT_SIZE_B-9 is 13, this means we are far
> more likely to decide to split now and maybe it is happening where the
> bi_io_vec array has more than one entry...

would that do the trick?
both sections should probably be run-time conditional on
"two_primaries", but they have to be consistent, at least...

Index: drbd_req.c
===================================================================
--- drbd_req.c	(revision 2415)
+++ drbd_req.c	(working copy)
@@ -1068,7 +1068,11 @@
 	unsigned int bio_size = bio->bi_size;
 	int max;
 
+#if 1
+	max = DRBD_MAX_SEGMENT_SIZE - ((bio_offset & (DRBD_MAX_SEGMENT_SIZE-1)) + bio_size);
+#else
 	max = AL_EXTENT_SIZE - ((bio_offset & (AL_EXTENT_SIZE-1)) + bio_size);
+#endif
 	if (max < 0) max = 0;
 	if (max <= bvec->bv_len && bio_size == 0)
 		return bvec->bv_len;


-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
