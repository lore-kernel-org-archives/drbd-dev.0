Return-Path: <BATV+42f74f58005807ba5154+7215+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DFFD54252E9
	for <drbd-dev@lists.linbit.com>; Fri, 26 May 2023 10:15:39 +0200 (CEST)
Date: Fri, 26 May 2023 01:13:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <ZHBqGosY0tWkNdIR@infradead.org>
References: <20230526073336.344543-1-mcgrof@kernel.org>
	<20230526073336.344543-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526073336.344543-2-mcgrof@kernel.org>
Cc: djwong@kernel.org, philipp.reisner@linbit.com, linux-mm@kvack.org,
	dm-devel@redhat.com, agk@redhat.com, drbd-dev@lists.linbit.com,
	willy@infradead.org, hch@infradead.org, p.raghav@samsung.com,
	rohan.puri@samsung.com, senozhatsky@chromium.org,
	snitzer@kernel.org, linux-block@vger.kernel.org, hare@suse.de,
	kbusch@kernel.org, axboe@kernel.dk, da.gomez@samsung.com,
	linux-kernel@vger.kernel.org, rpuri.linux@gmail.com,
	linux-xfs@vger.kernel.org, minchan@kernel.org,
	patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	lars.ellenberg@linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 1/5] block: annotate bdev_disk_changed()
 deprecation with a symbol namespace
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

On Fri, May 26, 2023 at 12:33:32AM -0700, Luis Chamberlain wrote:
> This ensures no other users pop up by mistake easily and provides
> us a with an easy vehicle to do the same with other routines should
> we need it later.

I don't see how this is related to the rest of the seris.  I also don't
think it's a good idea.  The APIs isn't deprecated per se.  It just
should not be called by drivers.  The right thing would be an interface
like

EXPORT_SYMBOL_GPL_FOR(bdev_disk_changed, loop.ko, CONFIG_BLK_DEV_LOOP);
EXPORT_SYMBOL_GPL_FOR(bdev_disk_changed, dasd_mod.ko, CONFIG_DASD);

with the modulo code enforcing that no one but the module this is
explicitly exorted for can use the symbol.
