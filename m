Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 155791055F45
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 08:56:57 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so508946pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 23:56:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 8 Aug 2012 23:56:50 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120809065650.GF2845@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-11-git-send-email-koverstreet@google.com>
	<20120808231552.GJ6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809023811.GJ7262@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120809023811.GJ7262@moria.home.lan>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] Consolidate bio_clone_bioset(), bio_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 07:38:11PM -0700, Kent Overstreet wrote:
> So here's my initial stab at it. Tell me if you think this is too
> contorted:

At the first glance, looks okay to me.

Thanks.

-- 
tejun
