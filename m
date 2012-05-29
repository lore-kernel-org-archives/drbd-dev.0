Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5E3AE100542E
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 3436B1B4361
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:12 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NcojMXeF52Bn for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:41:12 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 142E71B435B
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:12 +0200 (CEST)
Resent-Message-ID: <20120530084112.GU4141@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 067811019A78
	for <drbd-dev@lists.linbit.com>; Tue, 29 May 2012 04:15:20 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so6638315pbb.27
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 19:15:19 -0700 (PDT)
Date: Mon, 28 May 2012 22:15:15 -0400
From: Kent Overstreet <koverstreet@google.com>
To: Boaz Harrosh <bharrosh@panasas.com>
Message-ID: <20120529021515.GB6472@dhcp-172-18-216-138.mtv.corp.google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-8-git-send-email-koverstreet@google.com>
	<4FC3504B.7000903@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FC3504B.7000903@panasas.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	vgoyal@redhat.com, yehuda@hq.newdream.net,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 07/16] block: Rename bio_split() ->
	bio_pair_split()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, May 28, 2012 at 01:15:39PM +0300, Boaz Harrosh wrote:
> On 05/25/2012 11:25 PM, Kent Overstreet wrote:
> 
> > This is prep work for introducing a more general bio_split()
> > 
> > Change-Id: Ib9c4ff691af889d26bc9ec9fb42a2f3068f34ad9
> > 
> 
> 
> Since these patches will go through Jens tree this kind of
> comment can *never* be true/correct. And it is plenty unwanted
> for sure.

That's from a gerrit hook, which I always forget to delete so I just
disabled the hook on my work machine. Apologies.

> Here:
> bio_do means an operation on bio. But here we are actually operating
> on a bio_pair. So rename it it to bio_pair_do.

I don't follow what you mean by bio_do... but I think I get what you're
after, comment wise.

> 
> We will later introduce a real bio_split() function that receives
> a bio and splits it.
> 
> Or something like that.
> Thanks
> Boaz
> 
> > Signed-off-by: Kent Overstreet <koverstreet@google.com>
> 
> <snip>
> 
> > @@ -201,7 +201,7 @@ struct bio_pair {
> >  	atomic_t			cnt;
> >  	int				error;
> >  };
> > -extern struct bio_pair *bio_split(struct bio *bi, int first_sectors);
> > +extern struct bio_pair *bio_pair_split(struct bio *bi, int first_sectors);
> >  extern void bio_pair_release(struct bio_pair *dbio);
> >  
> >  extern struct bio_set *bioset_create(unsigned int, unsigned int);
> 
> 
