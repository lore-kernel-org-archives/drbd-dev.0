Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A8FED4203D0
	for <drbd-dev@lists.linbit.com>; Mon, 27 Jul 2020 09:58:54 +0200 (CEST)
Date: Mon, 27 Jul 2020 09:58:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Minchan Kim <minchan@kernel.org>
Message-ID: <20200727075822.GA5355@lst.de>
References: <20200726150333.305527-1-hch@lst.de>
	<20200726150333.305527-11-hch@lst.de>
	<20200726190639.GA560221@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726190639.GA560221@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>, Richard Weinberger <richard@nod.at>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	linux-mtd@lists.infradead.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 10/14] bdi: remove BDI_CAP_SYNCHRONOUS_IO
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

On Sun, Jul 26, 2020 at 12:06:39PM -0700, Minchan Kim wrote:
> > @@ -528,8 +530,7 @@ static ssize_t backing_dev_store(struct device *dev,
> >  	 * freely but in fact, IO is going on so finally could cause
> >  	 * use-after-free when the IO is really done.
> >  	 */
> > -	zram->disk->queue->backing_dev_info->capabilities &=
> > -			~BDI_CAP_SYNCHRONOUS_IO;
> > +	zram->disk->fops = &zram_wb_devops;
> >  	up_write(&zram->init_lock);
> 
> For zram, regardless of BDI_CAP_SYNCHRONOUS_IO, it have used rw_page
> every time on read/write path. This one with next patch will make zram
> use bio instead of rw_page when it's declared !BDI_CAP_SYNCHRONOUS_IO,
> which introduce regression for performance.

It really should not matter, as the overhead of setting up a bio
is minimal.  It also is only used in the legacy mpage buffered I/O
code outside of the swap code, which has so many performance issues on
its own that even if this made a difference it wouldn't matter.

If you want magic treatment for your zram swap code you really need
to integrate it with the swap code instead of burding the block layer
with all this mess.
