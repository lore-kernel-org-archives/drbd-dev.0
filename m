Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D0EAE10003F4
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id CA4761B4262
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:42 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ufZ04tET1z-0 for <drbd-dev@lists.linbit.com>;
	Thu, 24 May 2012 18:15:42 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id A7A7F1B40FA
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:42 +0200 (CEST)
Resent-Message-ID: <20120524161542.GR5734@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 65D7B1013802
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 02:39:27 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so13684410pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2012 17:39:19 -0700 (PDT)
Date: Wed, 23 May 2012 17:39:16 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Message-ID: <20120524003915.GA27443@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-3-git-send-email-koverstreet@google.com>
	<4FBD7E80.4020005@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FBD7E80.4020005@ce.jp.nec.com>
Cc: axboe@kernel.dk, device-mapper development <dm-devel@redhat.com>,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	agk@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, yehuda@hq.newdream.net,
	drbd-dev@lists.linbit.com, vgoyal@redhat.com, sage@newdream.net
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v2 02/14] dm: kill
	dm_rq_bio_destructor
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 24, 2012 at 09:19:12AM +0900, Jun'ichi Nomura wrote:
> Hi,
> 
> On 05/24/12 09:02, Kent Overstreet wrote:
> > @@ -1438,15 +1439,6 @@ void dm_dispatch_request(struct request *rq)
> >  }
> >  EXPORT_SYMBOL_GPL(dm_dispatch_request);
> >  
> > -static void dm_rq_bio_destructor(struct bio *bio)
> > -{
> > -	struct dm_rq_clone_bio_info *info = bio->bi_private;
> > -	struct mapped_device *md = info->tio->md;
> > -
> > -	free_bio_info(info);
> > -	bio_free(bio, md->bs);
> > -}
> > -
> >  static int dm_rq_bio_constructor(struct bio *bio, struct bio *bio_orig,
> >  				 void *data)
> >  {
> > @@ -1461,7 +1453,6 @@ static int dm_rq_bio_constructor(struct bio *bio, struct bio *bio_orig,
> >  	info->tio = tio;
> >  	bio->bi_end_io = end_clone_bio;
> >  	bio->bi_private = info;
> > -	bio->bi_destructor = dm_rq_bio_destructor;
> 
> The destructor may also be called from blk_rq_unprep_clone(),
> which just puts bio.
> So this patch will introduce a memory leak.

Well, keeping around bi_destructor solely for that reason would be
pretty lousy. Can you come up with a better solution?
