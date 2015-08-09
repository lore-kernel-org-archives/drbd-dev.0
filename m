Return-Path: <mlin@kernel.org>
Message-ID: <1439099990.7880.0.camel@hasee>
From: Ming Lin <mlin@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Sat, 08 Aug 2015 22:59:50 -0700
In-Reply-To: <yq18u9liwhj.fsf@sermon.lab.mkp.net>
References: <1436168690-32102-1-git-send-email-mlin@kernel.org>
	<20150731192337.GA8907@redhat.com>
	<CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com> <1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
	<yq18u9liwhj.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@canonical.com>,
	device-mapper development <dm-devel@redhat.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>, Nitin,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Gupta <ngupta@vflare.org>, Ming Lin <ming.l@ssi.samsung.com>,
	Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Dongsu Park <dpark@posteo.net>,
	drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v5 01/11] block: make
 generic_make_request handle arbitrarily sized bios
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

On Sat, 2015-08-08 at 12:19 -0400, Martin K. Petersen wrote:
> >>>>> "Mike" == Mike Snitzer <snitzer@redhat.com> writes:
> 
> Mike> This will translate to all intermediate layers that might split
> Mike> discards needing to worry about granularity/alignment too
> Mike> (e.g. how dm-thinp will have to care because it must generate
> Mike> discard mappings with associated bios based on how blocks were
> Mike> mapped to thinp).
> 
> The fundamental issue here is that alignment and granularity should
> never, ever have been enforced at the top of the stack. Horrendous idea
> from the very beginning.
> 
> For the < handful of braindead devices that get confused when you do
> partial or misaligned blocks we should have had a quirk that did any
> range adjusting at the bottom in sd_setup_discard_cmnd().
> 
> There's a reason I turned discard_zeroes_data off for UNMAP!
> 
> Wrt. the range size I don't have a problem with capping at the 32-bit
> bi_size limit. We probably don't want to send commands much bigger than
> that anyway.

How about below?

commit b8ca440bd77653d4d2bac90b7fd1599e9e0e150a
Author: Ming Lin <ming.l@ssi.samsung.com>
Date:   Fri Aug 7 15:07:07 2015 -0700

    block: remove split code in blkdev_issue_{discard,write_same}
    
    The split code in blkdev_issue_{discard,write_same} can go away
    now that any driver that cares does the split. We have to make
    sure bio size doesn't overflow.
    
    For discard, we set max discard sectors to (1<<31)>>9 to ensure
    it doesn't overflow bi_size and hopefully it is of the proper
    granularity as long as the granularity is a power of two.
    
    Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
---
 block/blk-lib.c | 47 +++++++++++------------------------------------
 1 file changed, 11 insertions(+), 36 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 7688ee3..4859e4b 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -26,6 +26,13 @@ static void bio_batch_end_io(struct bio *bio, int err)
 	bio_put(bio);
 }
 
+/*
+ * Ensure that max discard sectors doesn't overflow bi_size and hopefully
+ * it is of the proper granularity as long as the granularity is a power
+ * of two.
+ */
+#define MAX_DISCARD_SECTORS ((1U << 31) >> 9)
+
 /**
  * blkdev_issue_discard - queue a discard
  * @bdev:	blockdev to issue discard for
@@ -43,8 +50,6 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	DECLARE_COMPLETION_ONSTACK(wait);
 	struct request_queue *q = bdev_get_queue(bdev);
 	int type = REQ_WRITE | REQ_DISCARD;
-	unsigned int max_discard_sectors, granularity;
-	int alignment;
 	struct bio_batch bb;
 	struct bio *bio;
 	int ret = 0;
@@ -56,21 +61,6 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	if (!blk_queue_discard(q))
 		return -EOPNOTSUPP;
 
-	/* Zero-sector (unknown) and one-sector granularities are the same.  */
-	granularity = max(q->limits.discard_granularity >> 9, 1U);
-	alignment = (bdev_discard_alignment(bdev) >> 9) % granularity;
-
-	/*
-	 * Ensure that max_discard_sectors is of the proper
-	 * granularity, so that requests stay aligned after a split.
-	 */
-	max_discard_sectors = min(q->limits.max_discard_sectors, UINT_MAX >> 9);
-	max_discard_sectors -= max_discard_sectors % granularity;
-	if (unlikely(!max_discard_sectors)) {
-		/* Avoid infinite loop below. Being cautious never hurts. */
-		return -EOPNOTSUPP;
-	}
-
 	if (flags & BLKDEV_DISCARD_SECURE) {
 		if (!blk_queue_secdiscard(q))
 			return -EOPNOTSUPP;
@@ -84,7 +74,7 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	blk_start_plug(&plug);
 	while (nr_sects) {
 		unsigned int req_sects;
-		sector_t end_sect, tmp;
+		sector_t end_sect;
 
 		bio = bio_alloc(gfp_mask, 1);
 		if (!bio) {
@@ -92,21 +82,8 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 			break;
 		}
 
-		req_sects = min_t(sector_t, nr_sects, max_discard_sectors);
-
-		/*
-		 * If splitting a request, and the next starting sector would be
-		 * misaligned, stop the discard at the previous aligned sector.
-		 */
+		req_sects = min_t(sector_t, nr_sects, MAX_DISCARD_SECTORS);
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
@@ -166,10 +143,8 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
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


