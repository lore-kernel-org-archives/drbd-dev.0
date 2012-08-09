Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 51EF1105619A
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 4B1A31B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:33 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fsuMzM4JO8pi for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:33 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 31AC91B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:33 +0200 (CEST)
Resent-Message-ID: <20120810203333.GF31190@soda.linbit>
Received: from mail-yw0-f54.google.com (mail-yw0-f54.google.com
	[209.85.213.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 28AFE1045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 05:07:13 +0200 (CEST)
Received: by yhfs35 with SMTP id s35so2323847yhf.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 20:07:12 -0700 (PDT)
Date: Wed, 8 Aug 2012 20:06:38 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120809030638.GL7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-13-git-send-email-koverstreet@google.com>
	<20120808233007.GM6983@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120808233007.GM6983@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 12/12] block: Only clone bio vecs that are
	in use
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 04:30:07PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 06, 2012 at 03:08:41PM -0700, Kent Overstreet wrote:
> > @@ -459,10 +460,10 @@ void __bio_clone(struct bio *bio, struct bio *bio_src)
> >  	bio->bi_sector = bio_src->bi_sector;
> >  	bio->bi_bdev = bio_src->bi_bdev;
> >  	bio->bi_flags |= 1 << BIO_CLONED;
> > +	bio->bi_flags &= ~(1 << BIO_SEG_VALID);
> 
> This isn't obvious at all.  Why no explanation anywhere?  Also it
> would be nice to update comments of the updated functions so that it's
> clear that only partial cloning happens.

Because it's not obvious to me, either - I had to grep around through a
fair amount of code to figure out the semantics of BIO_SEG_VALID and I
doubt I have it 100%. I'm also pretty sure it's not used consistently in
the existing code...

If it means what I think it means, it should be obvious - nr_segs isn't
valid because the number of pages in the iovec changed (though we didn't
bother to copy it over anyways. So it's not necessary if nr_segs = 0
means nr_segs isn't valid, but bleh).

Anyways. yeah. BIO_SEG_VALID should be documented, and if it was I think
this code would be fine.

I will update the comment for the partial cloning thing:

/**
 * 	__bio_clone	-	clone a bio
 * 	@bio: destination bio
 * 	@bio_src: bio to clone
 *
 *	Clone a &bio. Caller will own the returned bio, but not
 *	the actual data it points to. Reference count of returned
 * 	bio will be one.
 *
 *	We don't clone the entire bvec, just the part from bi_idx to b_vcnt
 *	(i.e. what the bio currently points to, so the new bio is still
 *	equivalent to the old bio).
 */
void __bio_clone(struct bio *bio, struct bio *bio_src)
{
	memcpy(bio->bi_io_vec,
	       bio_iovec(bio_src),
	       bio_segments(bio_src) * sizeof(struct bio_vec));

