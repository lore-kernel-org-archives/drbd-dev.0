Return-Path: <axboe@suse.de>
Received: from virtualhost.dk (ns.virtualhost.dk [195.184.98.160])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id AB26F1431F
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jan 2005 10:10:07 +0100 (CET)
Date: Mon, 24 Jan 2005 10:10:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Message-ID: <20050124091006.GA2716@suse.de>
References: <20050123161633.GH24350@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123161633.GH24350@marowsky-bree.de>
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

On Sun, Jan 23 2005, Lars Marowsky-Bree wrote:
> Hi all,
> 
> drbd is a quite bad offender for using bio's on stack or embedded in
> other internal structs instead of the pointer interface.
> 
> The attached patch shows the 'right' way as an example, which was pretty easy
> because I could use Jens' patch for md with minimal modifications ;-) However,
> the other offending code lines are within the transfer log and other places,
> and I'm not sure Philipp wants me to mess around with that.
> 
> Jens, on chip.suse.de:/local/lmb/drbd-07/drbd/ you can find the most
> recent drbd kernel code. Could you look over drbd_compat_wrappers.h
> line 326ff in particular and give me a rough rundown of what's broken?
> We need to fix this by Tuesday latest :-(

drbd_ee_init() doesn't look good. First of all, it makes assumptions
about what bio_init() would do - it doesn't clear the entire bio to 0.
This is the type of thing that exposes bugs when we add or change parts
of the bio stuff, please uncomment that bio_init() call. It does set
bio->bi_max_vecs, however it needs changing to passing the bdev in so we
can use bio_add_page() instead. drbd_ee_bio_prepare() looks strange, it
sets vec length but doesn't assign the page or offset. Again, it should
use the proper api (bio_add_page()). If it had used bio_init(), it would
not have to set BIO_UPTODATE manually either.

bio->bi_next is a pointer, not an integer. Use NULL.

drbd_blk_run_queue() doesn't look legal, unless it's only ever run on
drbd's own queue. Even if so, it should remove the plug. I'd suggest
just using generic_unplug_device().

drdb should just use bio_iovec(bio) when it uses bio->bi_idx as the
index anyways.

The bio embedding may not be the best idea or the prettiest, but as long
as it sets ->bi_max_vecs it should be ok. In general the code could
really do with someone cleaning it up in preperation for submitting to
mainline...

-- 
Jens Axboe

