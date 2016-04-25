Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3331C1056445
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 23:23:26 +0200 (CEST)
Date: Mon, 25 Apr 2016 23:23:25 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Message-ID: <20160425212325.GA20950@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160425203217.GC25048@soda.linbit>
	<1461586077-11581-12-git-send-email-philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] [PATCH 11/30] drbd: when receiving P_TRIM,
 zero-out partial unaligned chunks
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Apr 25, 2016 at 02:07:38PM +0200, Philipp Reisner wrote:
> +	max_discard_sectors = min(q->limits.max_discard_sectors, (1U << 22));
> +	max_discard_sectors -= max_discard_sectors % granularity;

^^^^ there

On Mon, Apr 25, 2016 at 10:32:17PM +0200, Lars Ellenberg wrote:
> On Mon, Apr 25, 2016 at 09:37:28AM -0700, Bart Van Assche wrote:
> > On 04/25/2016 05:13 AM, Philipp Reisner wrote:
> > >+	while (nr_sectors >= granularity) {
> > >+		nr = min_t(sector_t, nr_sectors, max_discard_sectors);
> > >+		err |= blkdev_issue_discard(bdev, start, nr, GFP_NOIO, 0);
> > >+		nr_sectors -= nr;
> > >+		start += nr;
> > >+	}
> > 
> > Hello Phil,
> > 
> > In blk_bio_discard_split() the following statement protects against
> > block drivers for which max_discard_sectors is not a multiple of the
> > discard granularity:
> > 
> > 	max_discard_sectors -= max_discard_sectors % granularity;
> > 
> > Do we need something similar in the above loop?
> 
> Right. Did not realize that was "legal".

Wait. We already have that. see above.

    Lars

