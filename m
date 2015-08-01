Return-Path: <msnitzer@redhat.com>
Date: Sat, 1 Aug 2015 12:33:57 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Ming Lin <mlin@kernel.org>
Message-ID: <20150801163356.GA21478@redhat.com>
References: <1436168690-32102-1-git-send-email-mlin@kernel.org>
	<20150731192337.GA8907@redhat.com>
	<CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com>
	<1438412290.26596.14.camel@hasee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438412290.26596.14.camel@hasee>
Cc: Neil Brown <neilb@suse.de>, Ming Lei <ming.lei@canonical.com>,
	dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
	Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Ming Lin <ming.l@ssi.samsung.com>,
	Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
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

On Sat, Aug 01 2015 at  2:58am -0400,
Ming Lin <mlin@kernel.org> wrote:

> On Fri, 2015-07-31 at 17:38 -0400, Mike Snitzer wrote:
> > 
> > OK, once setup, to run the 2 tests in question directly you'd do
> > something like:
> > 
> > dmtest run --suite thin-provisioning -n discard_a_fragmented_device
> > 
> > dmtest run --suite thin-provisioning -n discard_fully_provisioned_device_benchmark
> > 
> > Again, these tests pass without this patchset.
> 
> It's caused by patch 4.
> When discard size >=4G, the bio->bi_iter.bi_size overflows.

Thanks for tracking this down!

> Below is the new patch.
> 
> Christoph,
> Could you also help to review it?
> 
> Now we still do "misaligned" check in blkdev_issue_discard().
> So the same code in blk_bio_discard_split() was removed.

But I don't agree with this approach.  One of the most meaningful
benefits of late bio splitting is the upper layers shouldn't _need_ to
depend on the intermediate devices' queue_limits being stacked properly.
Your solution to mix discard granularity/alignment checks at the upper
layer(s) but then split based on max_discard_sectors at the lower layer
defeats that benefit for discards.

This will translate to all intermediate layers that might split
discards needing to worry about granularity/alignment
too (e.g. how dm-thinp will have to care because it must generate
discard mappings with associated bios based on how blocks were mapped to
thinp).

Also, it is unfortunate that IO that doesn't have a payload is being
artificially split simply because bio->bi_iter.bi_size is 32bits.

Mike
