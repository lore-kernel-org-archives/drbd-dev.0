Return-Path: <mlin@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150810181325.GA24125@redhat.com>
References: <1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
	<yq18u9liwhj.fsf@sermon.lab.mkp.net>
	<1439099990.7880.0.camel@hasee>
	<20150809064128.GB2436@infradead.org>
	<1439103347.7880.3.camel@hasee>
	<20150809070128.GA25739@infradead.org>
	<1439104707.7880.8.camel@hasee> <20150810150216.GA22719@redhat.com>
	<1439223252.27204.10.camel@hasee>
	<20150810181325.GA24125@redhat.com>
Date: Mon, 10 Aug 2015 15:30:17 -0700
Message-ID: <CAF1ivSYv4iiaiXAwOFLTRCYM0tgvcNsBro=mDN215rkuLSxGFQ@mail.gmail.com>
From: Ming Lin <mlin@kernel.org>
To: Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset=UTF-8
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
	Jens Axboe <axboe@fb.com>, Andreas Dilger <andreas.dilger@intel.com>,
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

On Mon, Aug 10, 2015 at 11:13 AM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Mon, Aug 10 2015 at 12:14pm -0400,
> Ming Lin <mlin@kernel.org> wrote:
>
>> On Mon, 2015-08-10 at 11:02 -0400, Mike Snitzer wrote:
>> >
>> > Aside from that, I'm in favor of seeing this late bio splitting patchset
>> > finally land upstream (hopefully in time for the 4.3 merge, Jens?):
>> >
>> > Acked-by: Mike Snitzer <snitzer@redhat.com>
>>
>> Thanks!
>>
>> May I add your Ack to "PATCH: block: kill merge_bvec_fn() completely"
>> also?
>
> Sure, but please fold in the removal of dm.c comments I made in this
> merge commit:
>
> http://git.kernel.org/cgit/linux/kernel/git/snitzer/linux.git/commit/?h=block-late-bio-splitting&id=d6df875bb65ef1ee10c91cf09cb58d009286321f

Rebased on top of latest Linus tree(4.2-rc6+).

https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/diff/drivers/md/dm.c?h=block-generic-req&id=3dd8509a3f05152cca83bc41c37a8ba3e9119736

>
> thanks.
