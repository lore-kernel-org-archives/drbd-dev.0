Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CB1951056186
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id C27AD1B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:29 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J7j+ZJgSmtHM for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:29 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id A5F921B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:29 +0200 (CEST)
Resent-Message-ID: <20120810203329.GZ31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AB0E31045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 02:27:29 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so2805491pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 17:27:27 -0700 (PDT)
Date: Wed, 8 Aug 2012 17:26:53 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120809002653.GF7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-2-git-send-email-koverstreet@google.com>
	<20120808222515.GE6983@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120808222515.GE6983@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 01/12] block: Generalized bio pool freeing
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 03:25:15PM -0700, Tejun Heo wrote:
> On Mon, Aug 06, 2012 at 03:08:30PM -0700, Kent Overstreet wrote:
> > @@ -422,7 +409,11 @@ void bio_put(struct bio *bio)
> >  	if (atomic_dec_and_test(&bio->bi_cnt)) {
> >  		bio_disassociate_task(bio);
> >  		bio->bi_next = NULL;
> > -		bio->bi_destructor(bio);
> > +
> > +		if (bio->bi_pool)
> > +			bio_free(bio, bio->bi_pool);
> > +		else
> > +			bio->bi_destructor(bio);
> 
> So, this bi_pool overriding caller specified custom bi_destructor is
> rather unusual.  I know why it's like that - the patch series is
> gradually replacing bi_destructor with bi_pool and removes
> bi_destructor eventually, but it would be far better if at least patch
> description says why this is unusual like this.

Ok, I'll stick a comment in there:

	if (atomic_dec_and_test(&bio->bi_cnt)) {
		bio_disassociate_task(bio);
		bio->bi_next = NULL;

		/*
		 * This if statement is temporary - bi_pool is replacing
		 * bi_destructor, but bi_destructor will be taken out in another
		 * patch.
		 */
		if (bio->bi_pool)
			bio_free(bio, bio->bi_pool);
		else
			bio->bi_destructor(bio);
	}

> 
> Thanks.
> 
> -- 
> tejun
