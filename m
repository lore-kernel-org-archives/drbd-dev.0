Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 119EA103B4DA
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 08:52:57 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so502998pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 23:52:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 8 Aug 2012 23:52:51 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120809065251.GD2845@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-12-git-send-email-koverstreet@google.com>
	<20120808232120.GK6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809025610.GK7262@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120809025610.GK7262@moria.home.lan>
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

On Wed, Aug 08, 2012 at 07:56:10PM -0700, Kent Overstreet wrote:
> > So, bio_clone() loses its function comment.  Also, does it even make
> > sense to call bio_clone() from fs_bio_set?
> 
> I'll re add the function comment if you want, just for a single line
> wrapper I don't know if it's worth the cost - comments get out of date,
> and they're more stuff to wade through.

People actually look at docbook generated docs.  I don't know why but
they do.  It's a utility function at block layer.  Please just add the
comment.

> > Let's say it's so, then
> > what's the difference from using _kmalloc variant?
> 
> bio_kmalloc() fails if nr_iovecs > 1024, bio_alloc_bioset() fails if
> nr_iovecs > 256
> 
> and bio_alloc_bioset() is mempool backed, bio_kmalloc() is not.
> 
> AFAICT that's it.

So, the thing is being mempool backed doesn't mean anything if
multiple layers use the pool.  I *suspect* fs_bio_set is supposed to
be used by fs layer - ie. where bios originate.  The reason why I
wondered about bio_clone() is that bio_clone() is almost always used
from stacking drivers and stacking driver tapping into fs reserve is
buggy.  So, I'm wondering whether cloning from fs_bio_set should be
supported at all.

Thanks.

-- 
tejun
