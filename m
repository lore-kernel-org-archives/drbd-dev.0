Return-Path: <axboe@suse.de>
Received: from virtualhost.dk (ns.virtualhost.dk [195.184.98.160])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3BBF114323
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jan 2005 11:23:18 +0100 (CET)
Date: Mon, 24 Jan 2005 11:23:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Message-ID: <20050124102310.GB2716@suse.de>
References: <20050123161633.GH24350@marowsky-bree.de>
	<20050124091006.GA2716@suse.de>
	<20050124095854.GB5638@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124095854.GB5638@marowsky-bree.de>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Re: drbd uses wrong API for struct bio
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Jan 24 2005, Lars Marowsky-Bree wrote:
> On 2005-01-24T10:10:07, Jens Axboe <axboe@suse.de> wrote:
> 
> > drbd_ee_init() doesn't look good. First of all, it makes assumptions
> > about what bio_init() would do - it doesn't clear the entire bio to 0.
> > This is the type of thing that exposes bugs when we add or change parts
> > of the bio stuff, please uncomment that bio_init() call. It does set
> > bio->bi_max_vecs, however it needs changing to passing the bdev in so we
> > can use bio_add_page() instead. drbd_ee_bio_prepare() looks strange, it
> > sets vec length but doesn't assign the page or offset. Again, it should
> > use the proper api (bio_add_page()). If it had used bio_init(), it would
> > not have to set BIO_UPTODATE manually either.
> 
> I may be missing something here, but the interaction between
> drbd_ee_init() and drbd_ee_bio_prepare() doesn't map neatly to the
> bio_init() + bio_add_page() API. Part of the setup happens in
> _ee_init(), but the other half in _prepare(), so that neither one has
> all information readily available to use the correct bio_*() API.

Yes, that is what would be nice to fix :-)

Make drbd_ee_init() just init the bastard, and add the page in
prepare().

-- 
Jens Axboe

