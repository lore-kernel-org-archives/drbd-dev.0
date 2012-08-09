Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C528410561A1
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id B64C01B435E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:35 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XEWr2uncELdh for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:35 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 8A3EF1B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:35 +0200 (CEST)
Resent-Message-ID: <20120810203335.GK31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 550DC1055F45
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 08:59:31 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so512779pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 23:59:29 -0700 (PDT)
Date: Thu, 9 Aug 2012 02:59:31 -0400
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120809065931.GB9128@dhcp-172-18-216-138.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-12-git-send-email-koverstreet@google.com>
	<20120808232120.GK6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809025610.GK7262@moria.home.lan>
	<20120809065251.GD2845@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120809065251.GD2845@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 11/12] block: Add bio_clone_bioset()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 11:52:51PM -0700, Tejun Heo wrote:
> On Wed, Aug 08, 2012 at 07:56:10PM -0700, Kent Overstreet wrote:
> > > So, bio_clone() loses its function comment.  Also, does it even make
> > > sense to call bio_clone() from fs_bio_set?
> > 
> > I'll re add the function comment if you want, just for a single line
> > wrapper I don't know if it's worth the cost - comments get out of date,
> > and they're more stuff to wade through.
> 
> People actually look at docbook generated docs.  I don't know why but
> they do.  It's a utility function at block layer.  Please just add the
> comment.

Will do then.

> > > Let's say it's so, then
> > > what's the difference from using _kmalloc variant?
> > 
> > bio_kmalloc() fails if nr_iovecs > 1024, bio_alloc_bioset() fails if
> > nr_iovecs > 256
> > 
> > and bio_alloc_bioset() is mempool backed, bio_kmalloc() is not.
> > 
> > AFAICT that's it.
> 
> So, the thing is being mempool backed doesn't mean anything if
> multiple layers use the pool. 

It's worse than just using kmalloc, because then you've introduced the
possibility of deadlock.

> I *suspect* fs_bio_set is supposed to
> be used by fs layer - ie. where bios originate.  The reason why I
> wondered about bio_clone() is that bio_clone() is almost always used
> from stacking drivers and stacking driver tapping into fs reserve is
> buggy.  So, I'm wondering whether cloning from fs_bio_set should be
> supported at all.

That's actually a really good point.

I just grepped and there's actually only 3 callers - I thought there'd
be more.  That should be easy to fix, at least.
