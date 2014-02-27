Return-Path: <kmo@daterainc.com>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
	[209.85.192.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 023CF1019A35
	for <drbd-dev@lists.linbit.com>; Thu, 27 Feb 2014 22:25:14 +0100 (CET)
Received: by mail-pd0-f179.google.com with SMTP id w10so2971076pde.10
	for <drbd-dev@lists.linbit.com>; Thu, 27 Feb 2014 13:25:12 -0800 (PST)
Date: Thu, 27 Feb 2014 13:27:15 -0800
From: Kent Overstreet <kmo@daterainc.com>
To: Matthew Wilcox <willy@linux.intel.com>
Message-ID: <20140227212715.GA2834@kmo-pixel>
References: <1393457997-17618-1-git-send-email-kmo@daterainc.com>
	<1393457997-17618-2-git-send-email-kmo@daterainc.com>
	<20140227172254.GI5744@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140227172254.GI5744@linux.intel.com>
Cc: axboe@kernel.dk, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Neil Brown <neilb@suse.de>,
	Asai Thambi S P <asamymuthupa@micron.com>, Peng Tao <bergwolf@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Geoff Levand <geoff@infradead.org>, dm-devel@redhat.com,
	drbd-user@lists.linbit.com, Jiri Kosina <jkosina@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jim Paris <jim@jtan.com>,
	Nitin Gupta <ngupta@vflare.org>, Sam Bradshaw <sbradshaw@micron.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 1/9] block: Make generic_make_request handle
 arbitrary sized bios
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Feb 27, 2014 at 12:22:54PM -0500, Matthew Wilcox wrote:
> On Wed, Feb 26, 2014 at 03:39:49PM -0800, Kent Overstreet wrote:
> > We do this by adding calls to blk_queue_split() to the various
> > make_request functions that need it - a few can already handle arbitrary
> > size bios. Note that we add the call _after_ any call to blk_queue_bounce();
> > this means that blk_queue_split() and blk_recalc_rq_segments() don't need to
> > be concerned with bouncing affecting segment merging.
> 
> > diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> > index 51824d1f23..e4376b9613 100644
> > --- a/drivers/block/nvme-core.c
> > +++ b/drivers/block/nvme-core.c
> > @@ -737,6 +737,8 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
> >  	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
> >  	int result = -EBUSY;
> >  
> > +	blk_queue_split(q, &bio, q->bio_split);
> > +
> >  	if (!nvmeq) {
> >  		put_nvmeq(NULL);
> >  		bio_endio(bio, -EIO);
> 
> I'd suggest that we do:
> 
> -	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
> +	struct nvme_queue *nvmeq;
>  	int result = -EBUSY;
> 
> +	blk_queue_split(q, &bio, q->bio_split);
> +
> +	nvmeq = get_nvmeq(ns->dev);
>  	if (!nvmeq) {
> 
> so that we're running the blk_queue_split() code outside the get_cpu()
> call.

Whoops, that's definitely a bug.

> Now, the NVMe driver has its own rules about when BIOs have to be split.
> Right now, that's way down inside the nvme_map_bio() call when we're
> walking the bio to compose the scatterlist.  Should we instead have an
> nvme_bio_split() routine that is called instead of blk_queue_split(),
> and we can simplify nvme_map_bio() since it'll know that it's working
> with bios that don't have to be split.
> 
> In fact, I think it would have little NVMe-specific in it at that point,
> so we could name __blk_bios_map_sg() better, export it to drivers and
> call it from nvme_map_bio(), which I think would make everybody happier.

Yes, definitely - and by doing it there we shoudn't even have to split
the bios, we can just process them incrementally. I can write a patch
for it later if you want to test it.
