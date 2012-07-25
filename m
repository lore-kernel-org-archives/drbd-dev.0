Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9E9921045C2F
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 972CC1B4369
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:58 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eHuB3KQiKLFX for <drbd-dev@lists.linbit.com>;
	Thu, 26 Jul 2012 11:35:58 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 5A75C1B4368
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:58 +0200 (CEST)
Resent-Message-ID: <20120726093558.GI29767@soda.linbit>
Received: from mail-yw0-f54.google.com (mail-yw0-f54.google.com
	[209.85.213.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 98EDB1005431
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 01:38:35 +0200 (CEST)
Received: by yhfs35 with SMTP id s35so2039207yhf.27
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2012 16:38:34 -0700 (PDT)
Date: Wed, 25 Jul 2012 16:38:29 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Boaz Harrosh <bharrosh@panasas.com>
Message-ID: <20120725233829.GE8673@moria.home.lan>
References: <1343160689-12378-1-git-send-email-koverstreet@google.com>
	<1343160689-12378-2-git-send-email-koverstreet@google.com>
	<500FD32F.2010809@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500FD32F.2010809@panasas.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v4 01/12] block: Generalized bio pool freeing
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Jul 25, 2012 at 02:06:23PM +0300, Boaz Harrosh wrote:
> On 07/24/2012 11:11 PM, Kent Overstreet wrote:
> 
> > With the old code, when you allocate a bio from a bio pool you have to
> > implement your own destructor that knows how to find the bio pool the
> > bio was originally allocated from.
> > 
> > This adds a new field to struct bio (bi_pool) and changes
> > bio_alloc_bioset() to use it. This makes various bio destructors
> > unnecessary, so they're then deleted.
> > 
> > Signed-off-by: Kent Overstreet <koverstreet@google.com>
> 
> <snip>
> 
> > diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
> > index fd47950..be65582 100644
> > --- a/drivers/target/target_core_iblock.c
> > +++ b/drivers/target/target_core_iblock.c
> > @@ -447,14 +447,6 @@ static void iblock_complete_cmd(struct se_cmd *cmd)
> >  	kfree(ibr);
> >  }
> >  
> > -static void iblock_bio_destructor(struct bio *bio)
> > -{
> > -	struct se_cmd *cmd = bio->bi_private;
> > -	struct iblock_dev *ib_dev = cmd->se_dev->dev_ptr;
> > -
> > -	bio_free(bio, ib_dev->ibd_bio_set);
> > -}
> > -
> >  static struct bio *
> >  iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num)
> >  {
> > @@ -475,8 +467,15 @@ iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num)
> >  	}
> >  
> >  	bio->bi_bdev = ib_dev->ibd_bd;
> > +<<<<<<< HEAD
> >  	bio->bi_private = cmd;
> >  	bio->bi_destructor = iblock_bio_destructor;
> > +||||||| merged common ancestors
> > +	bio->bi_private = task;
> > +	bio->bi_destructor = iblock_bio_destructor;
> > +=======
> > +	bio->bi_private = task;
> > +>>>>>>> block: Generalized bio pool freeing
> >  	bio->bi_end_io = &iblock_bio_done;
> >  	bio->bi_sector = lba;
> >  	return bio;
> 
> 
> You left out a rebase merge conflict. Did you allmodconfig compile
> these patches?

Argh, clearly not. And I even fixed that rebase merge conflict at one
point, that's distressing.
