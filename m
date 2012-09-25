Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3054A1013804
	for <drbd-dev@lists.linbit.com>; Wed, 26 Sep 2012 17:13:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 255111B435D
	for <drbd-dev@lists.linbit.com>; Wed, 26 Sep 2012 17:13:04 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1BggBUqBZH3F for <drbd-dev@lists.linbit.com>;
	Wed, 26 Sep 2012 17:13:04 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 035D61B435C
	for <drbd-dev@lists.linbit.com>; Wed, 26 Sep 2012 17:13:04 +0200 (CEST)
Resent-Message-ID: <20120926151303.GA17722@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A0C3C1045C29
	for <drbd-dev@lists.linbit.com>; Wed, 26 Sep 2012 00:11:38 +0200 (CEST)
Received: by pbbrp8 with SMTP id rp8so999401pbb.27
	for <drbd-dev@lists.linbit.com>; Tue, 25 Sep 2012 15:11:36 -0700 (PDT)
Date: Tue, 25 Sep 2012 15:06:24 -0700
From: Kent Overstreet <koverstreet@google.com>
To: linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com, axboe@kernel.dk, linux-s390@vger.kernel.org,
	Chris Mason <chris.mason@fusionio.com>, neilb@suse.de,
	Jiri Kosina <jkosina@suse.cz>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, tj@kernel.org,
	Steven Whitehouse <swhiteho@redhat.com>, vgoyal@redhat.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <20120925220624.GC22647@google.com>
References: <1348526106-17074-1-git-send-email-koverstreet@google.com>
	<1348526106-17074-7-git-send-email-koverstreet@google.com>
	<20120925115452.GF8143@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120925115452.GF8143@soda.linbit>
Subject: Re: [Drbd-dev] [PATCH v3 06/26] block: Add bio_end_sector()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 25, 2012 at 01:54:52PM +0200, Lars Ellenberg wrote:
> On Mon, Sep 24, 2012 at 03:34:46PM -0700, Kent Overstreet wrote:
> > Just a little convenience macro - main reason to add it now is preparing
> > for immutable bio vecs, it'll reduce the size of the patch that puts
> > bi_sector/bi_size/bi_idx into a struct bvec_iter.
> 
> 
> For the DRBD part:
> 
> > diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> > index 01b2ac6..d90a1fd 100644
> > --- a/drivers/block/drbd/drbd_req.c
> > +++ b/drivers/block/drbd/drbd_req.c
> > @@ -1144,7 +1144,7 @@ void drbd_make_request(struct request_queue *q, struct bio *bio)
> >  	/* to make some things easier, force alignment of requests within the
> >  	 * granularity of our hash tables */
> >  	s_enr = bio->bi_sector >> HT_SHIFT;
> > -	e_enr = bio->bi_size ? (bio->bi_sector+(bio->bi_size>>9)-1) >> HT_SHIFT : s_enr;
> > +	e_enr = (bio_end_sector(bio) - 1) >> HT_SHIFT;
> 
> You ignored the bio->bi_size ? : ;
> 
> #define bio_end_sector(bio)	((bio)->bi_sector + bio_sectors(bio))
> which turns out (bio->bi_sector + (bio->bi_size >> 9))
> 
> Note that bi_size may be 0, bio_end_sector(bio)-1 then is bi_sector -1,
> for an empty flush with bi_sector == 0, this ends up as (sector_t)-1ULL,
> and this code path breaks horribly.

Man, that was dumb of me - thanks for catching it. Version below look
good?

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 01b2ac6..47f55db 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1144,7 +1144,7 @@ void drbd_make_request(struct request_queue *q, struct bio *bio)
 	/* to make some things easier, force alignment of requests within the
 	 * granularity of our hash tables */
 	s_enr = bio->bi_sector >> HT_SHIFT;
-	e_enr = bio->bi_size ? (bio->bi_sector+(bio->bi_size>>9)-1) >> HT_SHIFT : s_enr;
+	e_enr = bio->bi_size ? (bio_end_sector(bio) - 1) >> HT_SHIFT : s_enr;
 
 	if (likely(s_enr == e_enr)) {
 		do {
