Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 09F641011BE7
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id ABF161B435D
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:11 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wWyH19vKg1Oy for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:41:11 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 798AF1B435B
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:11 +0200 (CEST)
Resent-Message-ID: <20120530084111.GT4141@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E3ABE1019A78
	for <drbd-dev@lists.linbit.com>; Tue, 29 May 2012 04:10:48 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so6632813pbb.27
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 19:10:46 -0700 (PDT)
Date: Mon, 28 May 2012 22:10:42 -0400
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120529021042.GA6472@dhcp-172-18-216-138.mtv.corp.google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-6-git-send-email-koverstreet@google.com>
	<20120528013608.GE9891@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120528013608.GE9891@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 05/16] block: Kill bi_destructor
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, May 28, 2012 at 10:36:08AM +0900, Tejun Heo wrote:
> On Fri, May 25, 2012 at 01:25:28PM -0700, Kent Overstreet wrote:
> > Now that we've got generic code for freeing bios allocated from bio
> > pools, this isn't needed anymore.
> > 
> > This also changes the semantics of bio_free() a bit - it now also frees
> > bios allocated by bio_kmalloc(). It's also no longer exported, as
> > without bi_destructor there should be no need for it to be called
> > anywhere else.
> 
> I like this patch but I'd *really* like to see the patch description
> giving some background and explains *why* this is a good change.

Heh. Well, in my view deleting stuff is good by default, and if you can
delete things without user visible effects and without making the code
more complicated... 

So I guess given the simplicity of this particular patch in the series
I'm not sure what there is to justify here. Any suggestions on what
would make sense to put in...?

> 
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index 6b7daf3..b6ddbf1 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -74,11 +74,8 @@ struct bio {
> >  	struct bio_integrity_payload *bi_integrity;  /* data integrity */
> >  #endif
> >  
> > -	/* If bi_pool is non NULL, bi_destructor is not called */
> >  	struct bio_set		*bi_pool;
> 
> Maybe explain that %NULL bi_pool indicates kmalloc backed allocation?

Yeah, I'll update that comment.
