Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2B1751011C0C
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 20A311B4262
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:08 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X85UxheSg1W2 for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 09:04:08 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 001121B4206
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:07 +0200 (CEST)
Resent-Message-ID: <20120525070407.GQ12726@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DB085106DCC0
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 02:31:19 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so1300999pbb.27
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 17:31:17 -0700 (PDT)
Date: Thu, 24 May 2012 17:31:14 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID: <20120525003114.GF22664@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-5-git-send-email-koverstreet@google.com>
	<20120524185919.GE27550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120524185919.GE27550@redhat.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	bharrosh@panasas.com, linux-fsdevel@vger.kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 04/14] block: Add bio_clone_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 24, 2012 at 02:59:19PM -0400, Vivek Goyal wrote:
> On Wed, May 23, 2012 at 05:02:41PM -0700, Kent Overstreet wrote:
> 
> [..]
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index 013c7a5..5a953c6 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -729,7 +729,7 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
> >  	}
> >  
> >  	while (old_chain && (total < len)) {
> > -		tmp = bio_kmalloc(gfpmask, old_chain->bi_max_vecs);
> > +		tmp = bio_clone_kmalloc(old_chain, gfpmask);
> >  		if (!tmp)
> >  			goto err_out;
> >  
> > @@ -751,13 +751,9 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
> >  			if (!bp)
> >  				goto err_out;
> >  
> > -			__bio_clone(tmp, &bp->bio1);
> > -
> >  			*next = &bp->bio2;
> 
> Is this code correct. Now original code might clone bio after split and
> new code will clone the original bio itself and not the split one?

Argh, you're right, I screwed that up.

I'd like to get rid of all the open coded bio_clone()s out there (to
reduce the amount of code that "Only clone bio vecs that are in use" has
to change, but this code is too tricky - I'm just going to drop this
bit.
