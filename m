Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id DCFF32E11059
	for <drbd-dev@lists.linbit.com>; Mon, 14 Apr 2008 10:55:19 +0200 (CEST)
Date: Mon, 14 Apr 2008 10:55:19 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Problems with DRBD merge-bvec function
Message-ID: <20080414085519.GA32260@soda.linbit>
References: <342BAC0A5467384983B586A6B0B3767108F030CD@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767108F030CD@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Apr 13, 2008 at 05:38:10PM -0400, Graham, Simon wrote:
> > > That's what I'm testing at the moment -- I reverted the checks in
> > both
> > > drbd_merge_bvec and drbd_make_request_26.
> > 
> > let us know what the impact on performance is.
> > 
> 
> It makes things a little better but not much -- after staring at this
> for a while, I realized that I've been looking at the disk stats for the
> LVM device underneath DRBD (because DRBD currently doesn't implement the
> counters exposed in /proc/diskstats) -- at this level, the average size
> of a transfer is reduced because of the meta data updates that are going
> on; with the specific workload I am testing, I see about 50 AL cache
> misses per second - obviously not good (and yes I am experimenting with
> increasing the size, but this test is vicious and does random writes all
> over the disk).
> 
> I've actually been working on adding support for the standard disk
> counters - will probably submit a patch for that shortly on the
> assumption that it's generally interesting.

great.

> > but maybe this had not been your problem at all?
> > if any of the lower level devices has a merge_bvec function itself,
> > drbd falls back to "PAGE_SIZE" max-segments, unless you have
> "use-bmbv"
> > enabled, because we currently cannot cope with bios that need not be
> > split on the Primary, but would suddenly be split on the Secondary due
> > to different lower level constraints.
> 
> They don't. However, I don't think the code actually behaves the way you
> describe, unless I'm missing something -- in the merge-bvec routine (in
> 8.0) it has:
> 
> 	limit = DRBD_MAX_SEGMENT_SIZE - ((bio_offset &
> (DRBD_MAX_SEGMENT_SIZE-1)) + bio_size);
> 
> 	if (limit < 0) limit = 0;
> 	if (bio_size == 0) {
> 		if (limit <= bvec->bv_len) limit = bvec->bv_len;
> 	} else if (limit && inc_local(mdev)) {
> 		struct request_queue * const b =
> mdev->bc->backing_bdev->bd_disk->queue;
> 		if(b->merge_bvec_fn && mdev->bc->dc.use_bmbv) {
> 			backing_limit = b->merge_bvec_fn(b,bio,bvec);
> 			limit = min(limit,backing_limit);
> 		}
> 		dec_local(mdev);
> 	}
> 
> To me, this says it will use the normal 32KB boundary unless use_bmbv is
> set in which case it uses the minimum of ours and the lower devices
> value... I don't see anything here that would limit the size to 4K.

right. only, that code will not be used.
if the lover level device has a bio merge bvec fn,
drbd announces a fixed maximum segment size of PAGE_SIZE, since that
is the common denominator and all block devices are required to handle
that. there just will not be any merge_bvec fn announced then.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
