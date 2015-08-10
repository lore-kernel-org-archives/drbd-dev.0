Return-Path: <msnitzer@redhat.com>
Date: Mon, 10 Aug 2015 11:02:17 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Ming Lin <mlin@kernel.org>, axboe@fb.com
Message-ID: <20150810150216.GA22719@redhat.com>
References: <CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com>
	<1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
	<yq18u9liwhj.fsf@sermon.lab.mkp.net>
	<1439099990.7880.0.camel@hasee>
	<20150809064128.GB2436@infradead.org>
	<1439103347.7880.3.camel@hasee>
	<20150809070128.GA25739@infradead.org>
	<1439104707.7880.8.camel@hasee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1439104707.7880.8.camel@hasee>
Cc: Ming Lei <ming.lei@canonical.com>,
	device-mapper development <dm-devel@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Ming Lin <ming.l@ssi.samsung.com>,
	Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Joe Thornber <ejt@redhat.com>,
	Dongsu Park <dpark@posteo.net>, drbd-user@lists.linbit.com
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

On Sun, Aug 09 2015 at  3:18am -0400,
Ming Lin <mlin@kernel.org> wrote:

> On Sun, 2015-08-09 at 00:01 -0700, Christoph Hellwig wrote:
> > On Sat, Aug 08, 2015 at 11:55:47PM -0700, Ming Lin wrote:
> > > Will change it to MAX_BIO_SECTORS.
> > > May I add your ACK?
> > 
> > Yes, please go ahead.
> 
> Thanks. I'll send a new version of the series once device-mapper guy
> acks.
> 
> Hi Mike,
> 
> I have updated my tree. Could you pull and re-test?
> https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=block-generic-req
> 
> The 2 thin-provisioning tests passed.

I've merged your latest branch with my dm-4.3 branch, I had one conflict
in the merge due to the dm_merge_bvec() change from 4.2-rc6 (no
surprise).  I've published the result here:
http://git.kernel.org/cgit/linux/kernel/git/snitzer/linux.git/log/?h=block-late-bio-splitting

It passes the device-mapper-test-suite's 'thin-provisioning' tests.

> Hope I can have your ACK soon.

Shouldn't we also be using MAX_BIO_SECTORS in blkdev_issue_write_same
(instead of UINT_MAX >> 9)?

Aside from that, I'm in favor of seeing this late bio splitting patchset
finally land upstream (hopefully in time for the 4.3 merge, Jens?):

Acked-by: Mike Snitzer <snitzer@redhat.com>

p.s. I'll be working with Joe Thornber on optimizing DM (particularly
dm-thinp and dm-cache) once this patchset is included upstream.  You'll
see I've already added a couple WIP dm-thinp patches ontop.
