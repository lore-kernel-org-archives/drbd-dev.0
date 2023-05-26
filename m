Return-Path: <mcgrof@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 642BA4252EC
	for <drbd-dev@lists.linbit.com>; Fri, 26 May 2023 10:20:24 +0200 (CEST)
Date: Fri, 26 May 2023 01:20:16 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <ZHBrwFk0d80IiOfV@bombadil.infradead.org>
References: <20230526073336.344543-1-mcgrof@kernel.org>
	<20230526073336.344543-2-mcgrof@kernel.org>
	<ZHBqGosY0tWkNdIR@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHBqGosY0tWkNdIR@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Cc: djwong@kernel.org, philipp.reisner@linbit.com, linux-mm@kvack.org,
	dm-devel@redhat.com, agk@redhat.com, drbd-dev@lists.linbit.com,
	willy@infradead.org, p.raghav@samsung.com,
	rohan.puri@samsung.com, senozhatsky@chromium.org,
	snitzer@kernel.org, da.gomez@samsung.com, hare@suse.de,
	kbusch@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
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

On Fri, May 26, 2023 at 01:13:14AM -0700, Christoph Hellwig wrote:
> On Fri, May 26, 2023 at 12:33:32AM -0700, Luis Chamberlain wrote:
> > This ensures no other users pop up by mistake easily and provides
> > us a with an easy vehicle to do the same with other routines should
> > we need it later.
> 
> I don't see how this is related to the rest of the seris.

Jessh, sorry it is too late here and that was a typo that the commit
went into the series. I'll go sleep now. This I just had queued
as a reminder for the new annotation for deprecated symbols to be
used in some situations.

Please ignore this patch.

  Luis
