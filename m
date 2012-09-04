Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 09FF31017A2C
	for <drbd-dev@lists.linbit.com>; Tue,  4 Sep 2012 14:32:02 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>
Date: Tue, 04 Sep 2012 14:32:01 +0200
Message-ID: <8439412.RChiDciQdh@fat-tyre>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] FLUSH/FUA documentation & code discrepancy
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

I think commit 1e87901e18 was wrong. Starting with that commit the REQ_FLUSH 
and REQ_FUA bits get stripped away if the queue does not advertise REQ_FLUSH
or REQ_FUA support.

But the REQ_FLUSH bit is also tested for when not merging requests
(blk_queue_bio()) or when it comes to the elevator (blk_flush_plug_list()).

So, since this patch the elevator reorders write requests on queues that 
do not have REQ_FLUSH or REQ_FUA set.

While on queues that have REQ_FLUSH or REQ_FUA set, the elevator does
not reorder writes across FLUSHes.

The Documentation/block/writeback_cache_control.txt file says:
--snip--
Implementation details for filesystems
--------------------------------------

Filesystems can simply set the REQ_FLUSH and REQ_FUA bits and do not have to
worry if the underlying devices need any explicit cache flushing and how
the Forced Unit Access is implemented.  The REQ_FLUSH and REQ_FUA flags
may both be set on a single bio.
--snap--

I have the impression every file system lets IO drain, and issues a
flush afterwards with the blkdev_issue_flush() function. BTW that
function turns into a non-obvious no-op as soon as the queue does not
have the REQ_FUA or REQ_FLUSH bits set. It does not look like it is
a no-op by intention.

The file systems seem to be all fine, only in DRBD we have a mode were
we depend on REQ_FUA/REQ_FLUSH requests being real boundaries for reordering
of writes. This is broken since the mentioned commit as we recently found out.

I suggest that either this commit gets reverted, or the documentation
is updated. I am ready to prepare such a patch, but I need directions
how it should be fixed.

Best regards,
 Phil
