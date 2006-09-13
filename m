Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C00502CF77D1
	for <drbd-dev@lists.linbit.com>; Wed, 13 Sep 2006 23:51:12 +0200 (CEST)
Date: Wed, 13 Sep 2006 23:51:12 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 - next crash in bio_split()
Message-ID: <20060913215112.GC31250@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B37671038B05D1@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B37671038B05D1@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-09-13 16:41:25 -0400
\ Graham, Simon:
> > Index: drbd_req.c
> > ===================================================================
> > --- drbd_req.c	(revision 2415)
> > +++ drbd_req.c	(working copy)
> > @@ -1068,7 +1068,11 @@
> >  	unsigned int bio_size = bio->bi_size;
> >  	int max;
> > 
> > +#if 1
> > +	max = DRBD_MAX_SEGMENT_SIZE - ((bio_offset &
> > (DRBD_MAX_SEGMENT_SIZE-1)) + bio_size);
> > +#else
> >  	max = AL_EXTENT_SIZE - ((bio_offset & (AL_EXTENT_SIZE-1)) +
> > bio_size);
> > +#endif
> >  	if (max < 0) max = 0;
> >  	if (max <= bvec->bv_len && bio_size == 0)
> >  		return bvec->bv_len;
> 
> I'm not sure to be honest - I take it the intent here is to ensure there
> can only ever be one bio_vec in a bio that needs to be split? And the
> way to do that is to ensure that the only way a request that is too
> large can be passed to DRBD is if it is the first entry that is too
> large?

basically, yes.  but the "first_sectors" calculation for the bio_split
was terribly wrong, too.
I just committed the correct fix (I think).
its just been my own "stupidity" (again).

please verify. at least for me, it just copied the complete linux-2.6.17
source tree several times without even triggering an assert.
before that fix, it would just blow up in the very first seconds...

cheers, and good night

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
