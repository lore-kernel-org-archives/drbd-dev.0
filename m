Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4FBAB1055F7F
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 497D71B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:29 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KaMEgxx1Kkpg for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:29 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 2B12B1B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:29 +0200 (CEST)
Resent-Message-ID: <20120810203329.GY31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8B9A31045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 02:22:30 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so2798802pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 17:22:28 -0700 (PDT)
Date: Wed, 8 Aug 2012 17:21:54 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120809002154.GE7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-6-git-send-email-koverstreet@google.com>
	<20120808222223.GD6983@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120808222223.GD6983@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 05/12] block: Kill bi_destructor
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 03:22:23PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 06, 2012 at 03:08:34PM -0700, Kent Overstreet wrote:
> > Now that we've got generic code for freeing bios allocated from bio
> > pools, this isn't needed anymore.
> > 
> > This also changes the semantics of bio_free() a bit - it now also frees
> > bios allocated by bio_kmalloc(). It's also no longer exported, as
> > without bi_destructor there should be no need for it to be called
> > anywhere else.
> > 
> > v5: Switch to BIO_KMALLOC_POOL ((void *)~0), per Boaz
> > 
> > Signed-off-by: Kent Overstreet <koverstreet@google.com>
> > ---
> > diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> > index 920ede2..19bf632 100644
> > --- a/drivers/block/drbd/drbd_main.c
> > +++ b/drivers/block/drbd/drbd_main.c
> > @@ -161,23 +161,12 @@ static const struct block_device_operations drbd_ops = {
> >  	.release = drbd_release,
> >  };
> >  
> > -static void bio_destructor_drbd(struct bio *bio)
> > -{
> > -	bio_free(bio, drbd_md_io_bio_set);
> > -}
> > -
> >  struct bio *bio_alloc_drbd(gfp_t gfp_mask)
> >  {
> > -	struct bio *bio;
> > -
> >  	if (!drbd_md_io_bio_set)
> >  		return bio_alloc(gfp_mask, 1);
> >  
> > -	bio = bio_alloc_bioset(gfp_mask, 1, drbd_md_io_bio_set);
> > -	if (!bio)
> > -		return NULL;
> > -	bio->bi_destructor = bio_destructor_drbd;
> > -	return bio;
> > +	return bio_alloc_bioset(gfp_mask, 1, drbd_md_io_bio_set);
> >  }
> 
> Does this chunk belong to this patch?

Hrm, that should've been in the first patch. Will move it.

> 
> > @@ -56,6 +56,8 @@ static struct biovec_slab bvec_slabs[BIOVEC_NR_POOLS] __read_mostly = {
> >   */
> >  struct bio_set *fs_bio_set;
> >  
> > +#define BIO_KMALLOC_POOL ((void *) ~0)
> 
> What's wrong with good ol' NULL?

If it's NULL, we can't distinguish between bios where that field wasn't
set (i.e. bios that were statically allocated somewhere) from bios that
were allocated by bio_kmalloc().

It's just there to make debugging easier - if bi_cnt goes to 0 on a bio
where it shouldn't we'll catch it at the BUG_ON() in bio_free() instead
of kfreeing a bad pointer.

> 
> Thanks.
> 
> -- 
> tejun
