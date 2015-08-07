Return-Path: <mlin@kernel.org>
Message-ID: <1438990806.24452.8.camel@ssi>
From: Ming Lin <mlin@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Date: Fri, 07 Aug 2015 16:40:06 -0700
In-Reply-To: <20150807073001.GA17485@lst.de>
References: <1436168690-32102-1-git-send-email-mlin@kernel.org>
	<20150731192337.GA8907@redhat.com>
	<CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com> <1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com> <1438581502.26596.24.camel@hasee>
	<20150804113626.GA12682@lst.de> <1438754604.29731.31.camel@hasee>
	<20150807073001.GA17485@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Mike Snitzer <snitzer@redhat.com>, Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>, Al, dm-devel@redhat.com,
	Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Ming Lin <ming.l@ssi.samsung.com>,
	Oleg Drokin <oleg.drokin@intel.com>, Viro <viro@zeniv.linux.org.uk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Neil, Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Dongsu Park <dpark@posteo.net>,
	drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 01/11] block: make generic_make_request
 handle arbitrarily sized bios
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


On Fri, 2015-08-07 at 09:30 +0200, Christoph Hellwig wrote:
> I'm for solution 3:
> 
>  - keep blk_bio_{discard,write_same}_split, but ensure we never built
>    a > 4GB bio in blkdev_issue_{discard,write_same}.

This has problem as I mentioned in solution 1.
We need to also make sure max discard size is of proper granularity.
See below example.

      4G: 8388608 sectors
UINT_MAX: 8388607 sectors

dm-thinp block size = default discard granularity = 128 sectors

blkdev_issue_discard(sector=0, nr_sectors=8388608)

1. Only ensure bi_size not overflow

It doesn't work.

[start_sector, end_sector]
[0, 8388607]
    [0, 8388606], then dm-thinp splits it to 2 bios
        [0, 8388479]
        [8388480, 8388606] ---> this has problem in process_discard_bio(),
                                because the discard size(7 sectors) covers less than a block(128 sectors)
    [8388607, 8388607] ---> same problem 

2. Ensure bi_size not overflow and max discard size is of proper granularity

It works.

[start_sector, end_sector]
[0, 8388607]
    [0, 8388479]
    [8388480, 8388607]


So how about below patch?

commit 1ca2ad977255efb3c339f4ca16fb798ed5ec54f7
Author: Ming Lin <ming.l@ssi.samsung.com>
Date:   Fri Aug 7 15:07:07 2015 -0700

    block: remove split code in blkdev_issue_{discard,write_same}
    
    The split code in blkdev_issue_{discard,write_same} can go away
    now that any driver that cares does the split. We have to make
    sure bio size doesn't overflow.
    
    For discard, we ensure max_discard_sectors is of the proper
    granularity. So if discard size > 4G, blkdev_issue_discard() always
    send multiple granularity requests to lower level, except that the
    last one may be not multiple granularity.
    
    Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
---
 block/blk-lib.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 7688ee3..e178a07 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -44,7 +44,6 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	struct request_queue *q = bdev_get_queue(bdev);
 	int type = REQ_WRITE | REQ_DISCARD;
 	unsigned int max_discard_sectors, granularity;
-	int alignment;
 	struct bio_batch bb;
 	struct bio *bio;
 	int ret = 0;
@@ -58,18 +57,15 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 	/* Zero-sector (unknown) and one-sector granularities are the same.  */
 	granularity = max(q->limits.discard_granularity >> 9, 1U);
-	alignment = (bdev_discard_alignment(bdev) >> 9) % granularity;
 
 	/*
-	 * Ensure that max_discard_sectors is of the proper
-	 * granularity, so that requests stay aligned after a split.
-	 */
-	max_discard_sectors = min(q->limits.max_discard_sectors, UINT_MAX >> 9);
+	 * Ensure that max_discard_sectors doesn't overflow bi_size and is of
+	 * the proper granularity. So if discard size > 4G, blkdev_issue_discard()
+	 * always split and send multiple granularity requests to lower level,
+	 * except that the last one may be not multiple granularity.
+         */
+	max_discard_sectors = UINT_MAX >> 9;
 	max_discard_sectors -= max_discard_sectors % granularity;
-	if (unlikely(!max_discard_sectors)) {
-		/* Avoid infinite loop below. Being cautious never hurts. */
-		return -EOPNOTSUPP;
-	}
 
 	if (flags & BLKDEV_DISCARD_SECURE) {
 		if (!blk_queue_secdiscard(q))
@@ -84,7 +80,7 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	blk_start_plug(&plug);
 	while (nr_sects) {
 		unsigned int req_sects;
-		sector_t end_sect, tmp;
+		sector_t end_sect;
 
 		bio = bio_alloc(gfp_mask, 1);
 		if (!bio) {
@@ -93,20 +89,7 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		}
 
 		req_sects = min_t(sector_t, nr_sects, max_discard_sectors);
-
-		/*
-		 * If splitting a request, and the next starting sector would be
-		 * misaligned, stop the discard at the previous aligned sector.
-		 */
 		end_sect = sector + req_sects;
-		tmp = end_sect;
-		if (req_sects < nr_sects &&
-		    sector_div(tmp, granularity) != alignment) {
-			end_sect = end_sect - alignment;
-			sector_div(end_sect, granularity);
-			end_sect = end_sect * granularity + alignment;
-			req_sects = end_sect - sector;
-		}
 
 		bio->bi_iter.bi_sector = sector;
 		bio->bi_end_io = bio_batch_end_io;
@@ -166,10 +149,8 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 	if (!q)
 		return -ENXIO;
 
-	max_write_same_sectors = q->limits.max_write_same_sectors;
-
-	if (max_write_same_sectors == 0)
-		return -EOPNOTSUPP;
+	/* Ensure that max_write_same_sectors doesn't overflow bi_size */
+	max_write_same_sectors = UINT_MAX >> 9;
 
 	atomic_set(&bb.done, 1);
 	bb.flags = 1 << BIO_UPTODATE;


> 
> Note that this isn't special casing, we can't build > 4GB bios for
> data either, it's just implemented as a side effect right now instead
> of checked explicitly.




