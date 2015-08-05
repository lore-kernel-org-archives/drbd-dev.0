Return-Path: <mlin@kernel.org>
Message-ID: <1438754604.29731.31.camel@hasee>
From: Ming Lin <mlin@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Date: Tue, 04 Aug 2015 23:03:24 -0700
In-Reply-To: <20150804113626.GA12682@lst.de>
References: <1436168690-32102-1-git-send-email-mlin@kernel.org>
	<20150731192337.GA8907@redhat.com>
	<CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com> <1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com> <1438581502.26596.24.camel@hasee>
	<20150804113626.GA12682@lst.de>
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

On Tue, 2015-08-04 at 13:36 +0200, Christoph Hellwig wrote:
> On Sun, Aug 02, 2015 at 10:58:22PM -0700, Ming Lin wrote:
> > I think the important thing is the late splitting for regular bio.
> > For discard/write_same bio, how about just don't do late splitting?
> 
> I'd hate having to special case them even more.  Especially as the
> discard splitting is nasty and we really don't want to send giant
> discards by default anyway (see Jens' patches to limit discard size
> by default).
> 
> So I'd recommend to keep everything as-is, just make sure we don't
> overflow bi_size.

Did you mean to remove "PATCH 4 block: remove split code in
blkdev_issue_discard" or to keep it?

Which of below 2 solutions you prefer?

- Solution 1

remove splits in blkdev_issue_{discard,write_same} and keep
blk_bio_{discard,write_same}_split

But for blkdev_issue_discard(), it's not enough if only make sure
bi_size not overflow, for example, discard 4G

4G bytes = 8388608 sectors
UINT_MAX = 8388607 sectors

So blkdev_issue_discard() will send 2 discard bios.
First bio: sector 0 .. 8388606
Second bio: sector 8388607 .. 8388607

In this case, the 2 discard tests in device-mapper-test-suite still
fail, probably because the second bio start sector is not aligned with
discard_granularity.

So I have to take into account discard_granularity(assume 32 sectors),
then blkdev_issue_discard() will send 2 discard bios, as

First bio: sector 0 .. 8388575
Second bio: sector 8388576 .. 8388607

In this case, both discard tests passed.

- Solution 2

special case discard/write_same bios(You said you hate it).

That is to keep splits in blkdev_issue_{discard,write_same} and remove
blk_bio_{discard,write_same}_split

I think this is more clean way because blkdev_issue_{discard,write_same}
already make sure we don't overflow bi_size.

And blk_bio_{discard,write_same}_split are actually duplicated with the
splits in blkdev_issue_{discard,write_same}. It's OK to remove it.

