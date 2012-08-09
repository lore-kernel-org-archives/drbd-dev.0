Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3D178103B4C9
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 324451B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:35 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hB6Y96IytrRK for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:35 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 102651B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:35 +0200 (CEST)
Resent-Message-ID: <20120810203335.GJ31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C0EEB104C146
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 08:12:14 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so442794pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 23:12:12 -0700 (PDT)
Date: Thu, 9 Aug 2012 02:12:14 -0400
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120809061214.GA9128@dhcp-172-18-216-138.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-6-git-send-email-koverstreet@google.com>
	<20120808222223.GD6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809002154.GE7262@moria.home.lan>
	<20120809060517.GB2845@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120809060517.GB2845@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 05/12] block: Kill bi_destructor
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 11:05:17PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 08, 2012 at 05:21:54PM -0700, Kent Overstreet wrote:
> > > What's wrong with good ol' NULL?
> > 
> > If it's NULL, we can't distinguish between bios where that field wasn't
> > set (i.e. bios that were statically allocated somewhere) from bios that
> > were allocated by bio_kmalloc().
> > 
> > It's just there to make debugging easier - if bi_cnt goes to 0 on a bio
> > where it shouldn't we'll catch it at the BUG_ON() in bio_free() instead
> > of kfreeing a bad pointer.
> 
> I fail to see how that improves anything.  slab will complain clearly
> if it gets passed in a pointer to static area.  The benefit is
> imaginery.  If there's no bioset, it's NULL.  Let's please keep things
> usual.

But if it's a pointer to heap allocated memory, but the bio was embedded
in another struct? I've seen a fair number of instances of that (md, off
the top of my head).

If you're sure that in a normal config the slab allocator is going to
complain right away and not corrupt itself, fine. But I've been bitten
way too hard by bugs that could've been caught right away by a simple
assert and instead I had to spend hours backtracking, and the block
layer is _rife_ with that kind of thing.
