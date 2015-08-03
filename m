Return-Path: <mlin@kernel.org>
Message-ID: <1438581502.26596.24.camel@hasee>
From: Ming Lin <mlin@kernel.org>
To: Mike Snitzer <snitzer@redhat.com>
Date: Sun, 02 Aug 2015 22:58:22 -0700
In-Reply-To: <20150801163356.GA21478@redhat.com>
References: <1436168690-32102-1-git-send-email-mlin@kernel.org>
	<20150731192337.GA8907@redhat.com>
	<CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com> <1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Brown <neilb@suse.de>, Ming Lei <ming.lei@canonical.com>,
	lkml <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Ming Lin <ming.l@ssi.samsung.com>,
	Drokin <oleg.drokin@intel.com>, Oleg, Viro <viro@zeniv.linux.org.uk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Neil, Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>, Al, Jim Paris <jim@jtan.com>,
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

On Sat, 2015-08-01 at 12:33 -0400, Mike Snitzer wrote:
> On Sat, Aug 01 2015 at  2:58am -0400,
> Ming Lin <mlin@kernel.org> wrote:
> 
> > On Fri, 2015-07-31 at 17:38 -0400, Mike Snitzer wrote:
> > > 
> > > OK, once setup, to run the 2 tests in question directly you'd do
> > > something like:
> > > 
> > > dmtest run --suite thin-provisioning -n discard_a_fragmented_device
> > > 
> > > dmtest run --suite thin-provisioning -n discard_fully_provisioned_device_benchmark
> > > 
> > > Again, these tests pass without this patchset.
> > 
> > It's caused by patch 4.

Typo. I mean patch 5.

> > When discard size >=4G, the bio->bi_iter.bi_size overflows.
> 
> Thanks for tracking this down!

blkdev_issue_write_same() has same problem.

> 
> > Below is the new patch.
> > 
> > Christoph,
> > Could you also help to review it?
> > 
> > Now we still do "misaligned" check in blkdev_issue_discard().
> > So the same code in blk_bio_discard_split() was removed.
> 
> But I don't agree with this approach.  One of the most meaningful
> benefits of late bio splitting is the upper layers shouldn't _need_ to
> depend on the intermediate devices' queue_limits being stacked properly.
> Your solution to mix discard granularity/alignment checks at the upper
> layer(s) but then split based on max_discard_sectors at the lower layer
> defeats that benefit for discards.
> 
> This will translate to all intermediate layers that might split
> discards needing to worry about granularity/alignment
> too (e.g. how dm-thinp will have to care because it must generate
> discard mappings with associated bios based on how blocks were mapped to
> thinp).

I think the important thing is the late splitting for regular bio.
For discard/write_same bio, how about just don't do late splitting?

That is:
1. remove "PATCH 5: block: remove split code in blkdev_issue_discard"
2. Add below changes to PATCH 1

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1f5dfa0..90b085e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -9,59 +9,6 @@
 
 #include "blk.h"
 
-static struct bio *blk_bio_discard_split(struct request_queue *q,
-					 struct bio *bio,
-					 struct bio_set *bs)
-{
-	unsigned int max_discard_sectors, granularity;
-	int alignment;
-	sector_t tmp;
-	unsigned split_sectors;
-
-	/* Zero-sector (unknown) and one-sector granularities are the same.  */
-	granularity = max(q->limits.discard_granularity >> 9, 1U);
-
-	max_discard_sectors = min(q->limits.max_discard_sectors, UINT_MAX >> 9);
-	max_discard_sectors -= max_discard_sectors % granularity;
-
-	if (unlikely(!max_discard_sectors)) {
-		/* XXX: warn */
-		return NULL;
-	}
-
-	if (bio_sectors(bio) <= max_discard_sectors)
-		return NULL;
-
-	split_sectors = max_discard_sectors;
-
-	/*
-	 * If the next starting sector would be misaligned, stop the discard at
-	 * the previous aligned sector.
-	 */
-	alignment = (q->limits.discard_alignment >> 9) % granularity;
-
-	tmp = bio->bi_iter.bi_sector + split_sectors - alignment;
-	tmp = sector_div(tmp, granularity);
-
-	if (split_sectors > tmp)
-		split_sectors -= tmp;
-
-	return bio_split(bio, split_sectors, GFP_NOIO, bs);
-}
-
-static struct bio *blk_bio_write_same_split(struct request_queue *q,
-					    struct bio *bio,
-					    struct bio_set *bs)
-{
-	if (!q->limits.max_write_same_sectors)
-		return NULL;
-
-	if (bio_sectors(bio) <= q->limits.max_write_same_sectors)
-		return NULL;
-
-	return bio_split(bio, q->limits.max_write_same_sectors, GFP_NOIO, bs);
-}
-
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs)
@@ -129,10 +76,8 @@ void blk_queue_split(struct request_queue *q, struct bio **bio,
 {
 	struct bio *split;
 
-	if ((*bio)->bi_rw & REQ_DISCARD)
-		split = blk_bio_discard_split(q, *bio, bs);
-	else if ((*bio)->bi_rw & REQ_WRITE_SAME)
-		split = blk_bio_write_same_split(q, *bio, bs);
+	if ((*bio)->bi_rw & REQ_DISCARD || (*bio)->bi_rw & REQ_WRITE_SAME)
+		split = NULL;
 	else
 		split = blk_bio_segment_split(q, *bio, q->bio_split);
 

> 
> Also, it is unfortunate that IO that doesn't have a payload is being
> artificially split simply because bio->bi_iter.bi_size is 32bits.

Indeed.
Will it be possible to make it 64bits? I guess no.

> 
> Mike


