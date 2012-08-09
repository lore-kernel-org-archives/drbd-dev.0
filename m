Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 622371055F67
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 4E1661B435E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:28 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5OAVkgTTVdGj for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:28 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 1EB9A1B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:28 +0200 (CEST)
Resent-Message-ID: <20120810203328.GW31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CD7F61045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 02:09:26 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so2780703pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 17:09:24 -0700 (PDT)
Date: Wed, 8 Aug 2012 17:08:50 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120809000850.GC7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-5-git-send-email-koverstreet@google.com>
	<20120808221359.GC6983@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120808221359.GC6983@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	vgoyal@redhat.com, yehuda@hq.newdream.net, sage@newdream.net,
	agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 04/12] pktcdvd: Switch to bio_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 03:13:59PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 06, 2012 at 03:08:33PM -0700, Kent Overstreet wrote:
> > This is prep work for killing bi_destructor - previously, pktcdvd had
> > its own pkt_bio_alloc which was basically duplication bio_kmalloc(),
> > necessitating its own bi_destructor implementation.
> > 
> > v5: Un-reorder some functions, to make the patch easier to review
> > 
> > Signed-off-by: Kent Overstreet <koverstreet@google.com>
> 
> Please Cc: the maintainers.  Cc'ing Peter Osterlund and keeping the
> whole body for him.

Whoops, thanks.

> Generally looks good to me.  How is this tested?

Untested - no hardware for it.

> 
> Thanks.
> 
> > ---
> >  drivers/block/pktcdvd.c |   67 +++++++++++-----------------------------------
> >  1 files changed, 16 insertions(+), 51 deletions(-)
> > 
> > diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> > index ba66e44..ae55f08 100644
> > --- a/drivers/block/pktcdvd.c
> > +++ b/drivers/block/pktcdvd.c
> > @@ -101,6 +101,8 @@ static struct dentry	*pkt_debugfs_root = NULL; /* /sys/kernel/debug/pktcdvd */
> >  static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
> >  static int pkt_remove_dev(dev_t pkt_dev);
> >  static int pkt_seq_show(struct seq_file *m, void *p);
> > +static void pkt_end_io_read(struct bio *bio, int err);
> > +static void pkt_end_io_packet_write(struct bio *bio, int err);
> >  
> >  
> >  
> > @@ -522,38 +524,6 @@ static void pkt_bio_finished(struct pktcdvd_device *pd)
> >  	}
> >  }
> >  
> > -static void pkt_bio_destructor(struct bio *bio)
> > -{
> > -	kfree(bio->bi_io_vec);
> > -	kfree(bio);
> > -}
> > -
> > -static struct bio *pkt_bio_alloc(int nr_iovecs)
> > -{
> > -	struct bio_vec *bvl = NULL;
> > -	struct bio *bio;
> > -
> > -	bio = kmalloc(sizeof(struct bio), GFP_KERNEL);
> > -	if (!bio)
> > -		goto no_bio;
> > -	bio_init(bio);
> > -
> > -	bvl = kcalloc(nr_iovecs, sizeof(struct bio_vec), GFP_KERNEL);
> > -	if (!bvl)
> > -		goto no_bvl;
> > -
> > -	bio->bi_max_vecs = nr_iovecs;
> > -	bio->bi_io_vec = bvl;
> > -	bio->bi_destructor = pkt_bio_destructor;
> > -
> > -	return bio;
> > -
> > - no_bvl:
> > -	kfree(bio);
> > - no_bio:
> > -	return NULL;
> > -}
> > -
> >  /*
> >   * Allocate a packet_data struct
> >   */
> > @@ -567,10 +537,13 @@ static struct packet_data *pkt_alloc_packet_data(int frames)
> >  		goto no_pkt;
> >  
> >  	pkt->frames = frames;
> > -	pkt->w_bio = pkt_bio_alloc(frames);
> > +	pkt->w_bio = bio_kmalloc(GFP_KERNEL, frames);
> >  	if (!pkt->w_bio)
> >  		goto no_bio;
> >  
> > +	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
> > +	pkt->w_bio->bi_private = pkt;
> > +
> >  	for (i = 0; i < frames / FRAMES_PER_PAGE; i++) {
> >  		pkt->pages[i] = alloc_page(GFP_KERNEL|__GFP_ZERO);
> >  		if (!pkt->pages[i])
> > @@ -581,9 +554,12 @@ static struct packet_data *pkt_alloc_packet_data(int frames)
> >  	bio_list_init(&pkt->orig_bios);
> >  
> >  	for (i = 0; i < frames; i++) {
> > -		struct bio *bio = pkt_bio_alloc(1);
> > +		struct bio *bio = bio_kmalloc(GFP_KERNEL, 1);
> >  		if (!bio)
> >  			goto no_rd_bio;
> > +
> > +		bio->bi_end_io = pkt_end_io_read;
> > +		bio->bi_private = pkt;
> >  		pkt->r_bios[i] = bio;
> >  	}
> >  
> > @@ -1111,21 +1087,15 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
> >  	 * Schedule reads for missing parts of the packet.
> >  	 */
> >  	for (f = 0; f < pkt->frames; f++) {
> > -		struct bio_vec *vec;
> > -
> >  		int p, offset;
> > +
> >  		if (written[f])
> >  			continue;
> > +
> >  		bio = pkt->r_bios[f];
> > -		vec = bio->bi_io_vec;
> > -		bio_init(bio);
> > -		bio->bi_max_vecs = 1;
> > -		bio->bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
> > -		bio->bi_bdev = pd->bdev;
> > -		bio->bi_end_io = pkt_end_io_read;
> > -		bio->bi_private = pkt;
> > -		bio->bi_io_vec = vec;
> > -		bio->bi_destructor = pkt_bio_destructor;
> > +		bio_reset(bio);
> > +		bio->bi_sector	= pkt->sector + f * (CD_FRAMESIZE >> 9);
> > +		bio->bi_bdev	= pd->bdev;
> >  
> >  		p = (f * CD_FRAMESIZE) / PAGE_SIZE;
> >  		offset = (f * CD_FRAMESIZE) % PAGE_SIZE;
> > @@ -1418,14 +1388,9 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
> >  	}
> >  
> >  	/* Start the write request */
> > -	bio_init(pkt->w_bio);
> > -	pkt->w_bio->bi_max_vecs = PACKET_MAX_SIZE;
> > +	bio_reset(pkt->w_bio);
> >  	pkt->w_bio->bi_sector = pkt->sector;
> >  	pkt->w_bio->bi_bdev = pd->bdev;
> > -	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
> > -	pkt->w_bio->bi_private = pkt;
> > -	pkt->w_bio->bi_io_vec = bvec;
> > -	pkt->w_bio->bi_destructor = pkt_bio_destructor;
> >  	for (f = 0; f < pkt->frames; f++)
> >  		if (!bio_add_page(pkt->w_bio, bvec[f].bv_page, CD_FRAMESIZE, bvec[f].bv_offset))
> >  			BUG();
> > -- 
> > 1.7.7.3
> > 
> 
> -- 
> tejun
