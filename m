Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BD101104B1A3
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id B65DF1B4361
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:09 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ird6k934iY1u for <drbd-dev@lists.linbit.com>;
	Thu, 16 Aug 2012 20:17:09 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 96BE31B435E
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:09 +0200 (CEST)
Resent-Message-ID: <20120816181709.GI8189@soda.linbit>
Received: from mail-yw0-f54.google.com (mail-yw0-f54.google.com
	[209.85.213.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 794E81011BE7
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 00:19:41 +0200 (CEST)
Received: by yhfs35 with SMTP id s35so3403866yhf.27
	for <drbd-dev@lists.linbit.com>; Wed, 15 Aug 2012 15:19:40 -0700 (PDT)
Date: Wed, 15 Aug 2012 15:19:36 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120815221936.GC2758@google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-6-git-send-email-koverstreet@google.com>
	<20120808222223.GD6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809002154.GE7262@moria.home.lan>
	<20120809060517.GB2845@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809061214.GA9128@dhcp-172-18-216-138.mtv.corp.google.com>
	<CAOS58YOHZmNWezg0uDhDeKP1dAt8fmmcLjmzKGShrw6PCpCFpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOS58YOHZmNWezg0uDhDeKP1dAt8fmmcLjmzKGShrw6PCpCFpg@mail.gmail.com>
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

On Wed, Aug 08, 2012 at 11:34:09PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 8, 2012 at 11:12 PM, Kent Overstreet <koverstreet@google.com> wrote:
> > But if it's a pointer to heap allocated memory, but the bio was embedded
> > in another struct? I've seen a fair number of instances of that (md, off
> > the top of my head).
> >
> > If you're sure that in a normal config the slab allocator is going to
> > complain right away and not corrupt itself, fine. But I've been bitten
> > way too hard by bugs that could've been caught right away by a simple
> > assert and instead I had to spend hours backtracking, and the block
> > layer is _rife_ with that kind of thing.
> 
> Let's let slab debug code deal with that.  I really don't see much
> benefit in doing this.  The said kind of bugs aren't particularly
> difficult to track down.

The only difference would be changing
#define BIO_KMALLOC_POOL ((void *) ~0)

to
#define BIO_KMALLOC_POOL NULL

We want a define for this - bio_alloc_bioset(GFP_KERNEL, 1, NULL)
doesn't make any sense. I just don't see the argument for changing an
arbitrary constant... If it's just the ~0 pointer you don't like, I
originally used a real statically allocated struct bio_set as a sentinel
value.
