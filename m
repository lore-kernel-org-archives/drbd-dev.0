Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 14ACB10000B6
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 0E1AC1B4262
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:00 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KumvkN1LEOkF for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 09:03:59 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id E6FB61B4206
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:59 +0200 (CEST)
Resent-Message-ID: <20120525070359.GJ12726@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E82401017A2C
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 21:58:21 +0200 (CEST)
Date: Thu, 24 May 2012 15:58:10 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120524195810.GB28249@redhat.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-9-git-send-email-koverstreet@google.com>
	<20120524195202.GG27550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120524195202.GG27550@redhat.com>
Cc: axboe@kernel.dk, linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
	mpatocka@redhat.com, bharrosh@panasas.com, tj@kernel.org,
	yehuda@hq.newdream.net, drbd-dev@lists.linbit.com,
	agk@redhat.com, sage@newdream.net
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v2 08/14] block: Kill bi_destructor
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
> 
> Somehow we need to integrate two patches so that we don't have memory leak
> in bisection and reading code becomes easier.
> 
> Also then what's the need of bio_reset() in previous patch. That seems to
> be independent from getting rid of pkt_bio_destructor(). I would think
> that keep we can split the patch and keep bio_reset() logic in a separate
> patch. In fact I am not even sure that for one driver we should introduce
> bio_reset() in generic block layer. So to me we should get rid of bio_reset()
> and let all the gory details remain in driver.

Just noticed bio_kmalloc_destructor() will take care of freeing bio_kmalloc()
bios and it has been dropped in this patch. So memory leak point is moot.
bio_reset() question still remains though.

Thanks
Vivek
