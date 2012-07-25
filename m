Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AAC45103B4C9
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 9B90C1B4368
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:56 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gbaIgSmpPelq for <drbd-dev@lists.linbit.com>;
	Thu, 26 Jul 2012 11:35:56 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 644921B4369
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:56 +0200 (CEST)
Resent-Message-ID: <20120726093556.GF29767@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 74D2E1005431
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 01:01:47 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so2690848pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2012 16:01:45 -0700 (PDT)
Date: Wed, 25 Jul 2012 16:01:42 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Boaz Harrosh <bharrosh@panasas.com>
Message-ID: <20120725230142.GB8673@moria.home.lan>
References: <1343160689-12378-1-git-send-email-koverstreet@google.com>
	<1343160689-12378-5-git-send-email-koverstreet@google.com>
	<500FD8B7.9040701@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500FD8B7.9040701@panasas.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v4 04/12] pktcdvd: Switch to bio_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Jul 25, 2012 at 02:29:59PM +0300, Boaz Harrosh wrote:
> On 07/24/2012 11:11 PM, Kent Overstreet wrote:
> 
> > This is prep work for killing bi_destructor - previously, pktcdvd had
> > its own pkt_bio_alloc which was basically duplication bio_kmalloc(),
> > necessitating its own bi_destructor implementation.
> > 
> > Signed-off-by: Kent Overstreet <koverstreet@google.com>
> > ---
> >  drivers/block/pktcdvd.c |  115 ++++++++++++++++-------------------------------
> >  1 files changed, 39 insertions(+), 76 deletions(-)
> > 
> > diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> > index ba66e44..6fe693a 100644
> > --- a/drivers/block/pktcdvd.c
> > +++ b/drivers/block/pktcdvd.c
> > @@ -522,36 +522,38 @@ static void pkt_bio_finished(struct pktcdvd_device *pd)
> >  	}
> >  }
> >  
> > -static void pkt_bio_destructor(struct bio *bio)
> > +static void pkt_end_io_read(struct bio *bio, int err)
> >  {
> > -	kfree(bio->bi_io_vec);
> > -	kfree(bio);
> > -}
> 
> 
> Again here, you decided to move the pkt_end_io_read && pkt_end_io_packet_write
> functions from below, to above here. Which makes it impossible to find
> any bugs by just reviewing the patch.
> 
> So I have not reviewed it. 
> 
> I know that you wanted so you can reference them at pkt_alloc_packet_data.
> I'd use a forward reference, in this case. And a move in a next patch. But
> this is just me. Perhaps the owner of this code can review it?

Yeah, I tend to be pretty anal about unnecessary forward declarations.
Overly anal in this case, I suppose. Here's a better patch:


commit 88cb170314bfa6cc90af37e433c07927b3b79ed2
Author: Kent Overstreet <koverstreet@google.com>
Date:   Wed Jul 25 16:00:00 2012 -0700

    pktcdvd: Switch to bio_kmalloc()
    
    This is prep work for killing bi_destructor - previously, pktcdvd had
    its own pkt_bio_alloc which was basically duplication bio_kmalloc(),
    necessitating its own bi_destructor implementation.
    
    Signed-off-by: Kent Overstreet <koverstreet@google.com>

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index ba66e44..ae55f08 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -101,6 +101,8 @@ static struct dentry	*pkt_debugfs_root = NULL; /* /sys/kernel/debug/pktcdvd */
 static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
 static int pkt_remove_dev(dev_t pkt_dev);
 static int pkt_seq_show(struct seq_file *m, void *p);
+static void pkt_end_io_read(struct bio *bio, int err);
+static void pkt_end_io_packet_write(struct bio *bio, int err);
 
 
 
@@ -522,38 +524,6 @@ static void pkt_bio_finished(struct pktcdvd_device *pd)
 	}
 }
 
-static void pkt_bio_destructor(struct bio *bio)
-{
-	kfree(bio->bi_io_vec);
-	kfree(bio);
-}
-
-static struct bio *pkt_bio_alloc(int nr_iovecs)
-{
-	struct bio_vec *bvl = NULL;
-	struct bio *bio;
-
-	bio = kmalloc(sizeof(struct bio), GFP_KERNEL);
-	if (!bio)
-		goto no_bio;
-	bio_init(bio);
-
-	bvl = kcalloc(nr_iovecs, sizeof(struct bio_vec), GFP_KERNEL);
-	if (!bvl)
-		goto no_bvl;
-
-	bio->bi_max_vecs = nr_iovecs;
-	bio->bi_io_vec = bvl;
-	bio->bi_destructor = pkt_bio_destructor;
-
-	return bio;
-
- no_bvl:
-	kfree(bio);
- no_bio:
-	return NULL;
-}
-
 /*
  * Allocate a packet_data struct
  */
@@ -567,10 +537,13 @@ static struct packet_data *pkt_alloc_packet_data(int frames)
 		goto no_pkt;
 
 	pkt->frames = frames;
-	pkt->w_bio = pkt_bio_alloc(frames);
+	pkt->w_bio = bio_kmalloc(GFP_KERNEL, frames);
 	if (!pkt->w_bio)
 		goto no_bio;
 
+	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
+	pkt->w_bio->bi_private = pkt;
+
 	for (i = 0; i < frames / FRAMES_PER_PAGE; i++) {
 		pkt->pages[i] = alloc_page(GFP_KERNEL|__GFP_ZERO);
 		if (!pkt->pages[i])
@@ -581,9 +554,12 @@ static struct packet_data *pkt_alloc_packet_data(int frames)
 	bio_list_init(&pkt->orig_bios);
 
 	for (i = 0; i < frames; i++) {
-		struct bio *bio = pkt_bio_alloc(1);
+		struct bio *bio = bio_kmalloc(GFP_KERNEL, 1);
 		if (!bio)
 			goto no_rd_bio;
+
+		bio->bi_end_io = pkt_end_io_read;
+		bio->bi_private = pkt;
 		pkt->r_bios[i] = bio;
 	}
 
@@ -1111,21 +1087,15 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 	 * Schedule reads for missing parts of the packet.
 	 */
 	for (f = 0; f < pkt->frames; f++) {
-		struct bio_vec *vec;
-
 		int p, offset;
+
 		if (written[f])
 			continue;
+
 		bio = pkt->r_bios[f];
-		vec = bio->bi_io_vec;
-		bio_init(bio);
-		bio->bi_max_vecs = 1;
-		bio->bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
-		bio->bi_bdev = pd->bdev;
-		bio->bi_end_io = pkt_end_io_read;
-		bio->bi_private = pkt;
-		bio->bi_io_vec = vec;
-		bio->bi_destructor = pkt_bio_destructor;
+		bio_reset(bio);
+		bio->bi_sector	= pkt->sector + f * (CD_FRAMESIZE >> 9);
+		bio->bi_bdev	= pd->bdev;
 
 		p = (f * CD_FRAMESIZE) / PAGE_SIZE;
 		offset = (f * CD_FRAMESIZE) % PAGE_SIZE;
@@ -1418,14 +1388,9 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 	}
 
 	/* Start the write request */
-	bio_init(pkt->w_bio);
-	pkt->w_bio->bi_max_vecs = PACKET_MAX_SIZE;
+	bio_reset(pkt->w_bio);
 	pkt->w_bio->bi_sector = pkt->sector;
 	pkt->w_bio->bi_bdev = pd->bdev;
-	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
-	pkt->w_bio->bi_private = pkt;
-	pkt->w_bio->bi_io_vec = bvec;
-	pkt->w_bio->bi_destructor = pkt_bio_destructor;
 	for (f = 0; f < pkt->frames; f++)
 		if (!bio_add_page(pkt->w_bio, bvec[f].bv_page, CD_FRAMESIZE, bvec[f].bv_offset))
 			BUG();
