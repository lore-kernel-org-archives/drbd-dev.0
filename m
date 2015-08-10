Return-Path: <msnitzer@redhat.com>
Date: Mon, 10 Aug 2015 14:13:25 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Ming Lin <mlin@kernel.org>
Message-ID: <20150810181325.GA24125@redhat.com>
References: <1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
	<yq18u9liwhj.fsf@sermon.lab.mkp.net>
	<1439099990.7880.0.camel@hasee>
	<20150809064128.GB2436@infradead.org>
	<1439103347.7880.3.camel@hasee>
	<20150809070128.GA25739@infradead.org>
	<1439104707.7880.8.camel@hasee> <20150810150216.GA22719@redhat.com>
	<1439223252.27204.10.camel@hasee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1439223252.27204.10.camel@hasee>
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
	axboe@fb.com, Andreas Dilger <andreas.dilger@intel.com>,
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

On Mon, Aug 10 2015 at 12:14pm -0400,
Ming Lin <mlin@kernel.org> wrote:

> On Mon, 2015-08-10 at 11:02 -0400, Mike Snitzer wrote:
> > 
> > Aside from that, I'm in favor of seeing this late bio splitting patchset
> > finally land upstream (hopefully in time for the 4.3 merge, Jens?):
> > 
> > Acked-by: Mike Snitzer <snitzer@redhat.com>
> 
> Thanks!
> 
> May I add your Ack to "PATCH: block: kill merge_bvec_fn() completely"
> also?

Sure, but please fold in the removal of dm.c comments I made in this
merge commit:

http://git.kernel.org/cgit/linux/kernel/git/snitzer/linux.git/commit/?h=block-late-bio-splitting&id=d6df875bb65ef1ee10c91cf09cb58d009286321f

thanks.
