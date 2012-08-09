Return-Path: <htejun@gmail.com>
Received: from mail-yw0-f54.google.com (mail-yw0-f54.google.com
	[209.85.213.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F16261055F45
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 08:55:11 +0200 (CEST)
Received: by yhfs35 with SMTP id s35so159303yhf.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 23:55:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 8 Aug 2012 23:55:04 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120809065504.GE2845@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-11-git-send-email-koverstreet@google.com>
	<20120808231552.GJ6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809015704.GI7262@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120809015704.GI7262@moria.home.lan>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 10/12] block: Add bio_clone_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 06:57:04PM -0700, Kent Overstreet wrote:
> That means bio_clone_kmalloc will just become:
> 
> static inline struct bio *bio_clone_kmalloc(struct bio *bio,
> 					    gfp_t gfp_mask)
> {
> 	return bio_clone_bioset(bio, gfp_mask, BIO_KMALLOC_POOL)
> }
> 
> (or maybe NULL there, I think using NULL for the interface makes sense,
> I just don't want to use it for bi_pool).
> 
> Do you still want the /** for a one line wrapper like that?

I don't know.  But do you think you can do similar thing to alloc
interface too?

Thanks.

-- 
tejun
