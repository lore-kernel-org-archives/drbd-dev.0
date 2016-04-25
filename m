Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 054351056312
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 22:32:18 +0200 (CEST)
Date: Mon, 25 Apr 2016 22:32:17 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <20160425203217.GC25048@soda.linbit>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
	<1461586077-11581-12-git-send-email-philipp.reisner@linbit.com>
	<571E47C8.5010805@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571E47C8.5010805@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Drbd-dev] [PATCH 11/30] drbd: when receiving P_TRIM,
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

On Mon, Apr 25, 2016 at 09:37:28AM -0700, Bart Van Assche wrote:
> On 04/25/2016 05:13 AM, Philipp Reisner wrote:
> >+	while (nr_sectors >= granularity) {
> >+		nr = min_t(sector_t, nr_sectors, max_discard_sectors);
> >+		err |= blkdev_issue_discard(bdev, start, nr, GFP_NOIO, 0);
> >+		nr_sectors -= nr;
> >+		start += nr;
> >+	}
> 
> Hello Phil,
> 
> In blk_bio_discard_split() the following statement protects against
> block drivers for which max_discard_sectors is not a multiple of the
> discard granularity:
> 
> 	max_discard_sectors -= max_discard_sectors % granularity;
> 
> Do we need something similar in the above loop?

Right. Did not realize that was "legal".

> To Jens: should the drbd_issue_discard_or_zero_out() function go
> upstream or should rather what this function does be integrated in
> blkdev_issue_zeroout() as is done by the patch series
> "[PATCH v2 0/6] Make blkdev_issue_discard() submit aligned discard requests"
> (http://thread.gmane.org/gmane.linux.kernel.device-mapper.devel/23801)?

Thanks,
    Lars


