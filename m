Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F3D411005420
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id EBFFB1B4262
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:00 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U1YE+pbbe4ir for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 09:04:00 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 6B3031B4206
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:00 +0200 (CEST)
Resent-Message-ID: <20120525070400.GK12726@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D6C981017A2C
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 22:00:17 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so942975pbb.27
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 13:00:15 -0700 (PDT)
Date: Thu, 24 May 2012 13:00:12 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID: <20120524200012.GB18624@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-9-git-send-email-koverstreet@google.com>
	<20120524195202.GG27550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120524195202.GG27550@redhat.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	bharrosh@panasas.com, linux-fsdevel@vger.kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 08/14] block: Kill bi_destructor
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 24, 2012 at 03:52:02PM -0400, Vivek Goyal wrote:
> On Wed, May 23, 2012 at 05:02:45PM -0700, Kent Overstreet wrote:
> 
> [..]
> > @@ -234,6 +234,13 @@ void bio_free(struct bio *bio, struct bio_set *bs)
> >  {
> >  	void *p;
> >  
> > +	if (!bs) {
> > +		if (bio_integrity(bio))
> > +			bio_integrity_free(bio, fs_bio_set);
> > +		kfree(bio);
> > +		return;
> > +	}
> > +
> 
> Ok, this seems to be the code which will take care of freeing kmalloced
> bio. I think putting little comment about the explicit assumption is not
> a bad idea.

Yeah, it's changing the semantics of bio_free(). I'll document that.

> Somehow we need to integrate two patches so that we don't have memory leak
> in bisection and reading code becomes easier.

I don't think there's any memory leak issues with this patch... there
are various annoyances with the dm code, though.

> Also then what's the need of bio_reset() in previous patch. That seems to
> be independent from getting rid of pkt_bio_destructor(). I would think
> that keep we can split the patch and keep bio_reset() logic in a separate
> patch. In fact I am not even sure that for one driver we should introduce
> bio_reset() in generic block layer. So to me we should get rid of bio_reset()
> and let all the gory details remain in driver.

Well, it would be possible to kill bi_destructor without introducing
bio_reset() - but that'd mean the kill bi_destructor patch would have to
muck around in the pktcdvd code. IMO introducing bio_reset() makes the
rest of the patch series much cleaner.
