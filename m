Return-Path: <BATV+e16e2fc4419b117693a1+7183+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9E69C4202BE
	for <drbd-dev@lists.linbit.com>; Mon, 24 Apr 2023 08:22:24 +0200 (CEST)
Date: Sun, 23 Apr 2023 22:55:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Message-ID: <ZEYZ4ScVDXviFJ/J@infradead.org>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
	<20230421195807.2804512-4-mcgrof@kernel.org>
	<ZELuiBNNHTk4EdxH@casper.infradead.org>
	<ZEMH9h/cd9Cp1t+X@bombadil.infradead.org>
	<20230421223420.GH3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421223420.GH3223426@dread.disaster.area>
Cc: djwong@kernel.org, philipp.reisner@linbit.com, linux-mm@kvack.org,
	dm-devel@redhat.com, agk@redhat.com, drbd-dev@lists.linbit.com,
	Matthew Wilcox <willy@infradead.org>, hch@infradead.org,
	p.raghav@samsung.com, senozhatsky@chromium.org,
	snitzer@kernel.org, linux-block@vger.kernel.org, hare@suse.de,
	kbusch@kernel.org, axboe@kernel.dk, da.gomez@samsung.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	minchan@kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	lars.ellenberg@linbit.com
Subject: Re: [Drbd-dev] [PATCH 3/5] iomap: simplify iomap_init() with
	PAGE_SECTORS
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Apr 22, 2023 at 08:34:20AM +1000, Dave Chinner wrote:
> > 
> > -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> > +	return bioset_init(&iomap_ioend_bioset, 4 * PAGE_SECTORS,
> 
> Yes, please.
> 
> > The shift just seemed optimal if we're just going to change it.
> 
> Nope, it's just premature optimisation at the expense of
> maintainability. The compiler will optimise the multiplication into
> shifts if that is the fastest way to do it for the given
> architecture the code is being compiled to.

We still had cases of the compiler not doing obvious
multiplication/division to shift conversion lately.  That being said:

 1) this is an initialization path, no one actually cares
 2) we're dealing with constants here, and compilers are really good
    at constant folding

so yes, this should be using the much more readable version.

