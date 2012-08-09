Return-Path: <htejun@gmail.com>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
	[209.85.217.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AE95B103B4DA
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 08:34:10 +0200 (CEST)
Received: by lbbgk8 with SMTP id gk8so178927lbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 23:34:09 -0700 (PDT)
MIME-Version: 1.0
Sender: htejun@gmail.com
In-Reply-To: <20120809061214.GA9128@dhcp-172-18-216-138.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-6-git-send-email-koverstreet@google.com>
	<20120808222223.GD6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809002154.GE7262@moria.home.lan>
	<20120809060517.GB2845@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809061214.GA9128@dhcp-172-18-216-138.mtv.corp.google.com>
Date: Wed, 8 Aug 2012 23:34:09 -0700
Message-ID: <CAOS58YOHZmNWezg0uDhDeKP1dAt8fmmcLjmzKGShrw6PCpCFpg@mail.gmail.com>
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Hello,

On Wed, Aug 8, 2012 at 11:12 PM, Kent Overstreet <koverstreet@google.com> wrote:
> But if it's a pointer to heap allocated memory, but the bio was embedded
> in another struct? I've seen a fair number of instances of that (md, off
> the top of my head).
>
> If you're sure that in a normal config the slab allocator is going to
> complain right away and not corrupt itself, fine. But I've been bitten
> way too hard by bugs that could've been caught right away by a simple
> assert and instead I had to spend hours backtracking, and the block
> layer is _rife_ with that kind of thing.

Let's let slab debug code deal with that.  I really don't see much
benefit in doing this.  The said kind of bugs aren't particularly
difficult to track down.

Thanks.

-- 
tejun
