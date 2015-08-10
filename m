Return-Path: <martin.petersen@oracle.com>
To: Ming Lin <mlin@kernel.org>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com> <1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
	<yq18u9liwhj.fsf@sermon.lab.mkp.net> <1439099990.7880.0.camel@hasee>
	<20150809064128.GB2436@infradead.org> <1439103347.7880.3.camel@hasee>
	<20150809070128.GA25739@infradead.org> <1439104707.7880.8.camel@hasee>
	<20150810150216.GA22719@redhat.com> <1439223252.27204.10.camel@hasee>
Date: Mon, 10 Aug 2015 12:40:52 -0400
In-Reply-To: <1439223252.27204.10.camel@hasee> (Ming Lin's message of "Mon, 10
	Aug 2015 09:14:12 -0700")
Message-ID: <yq1k2t3gkq3.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@canonical.com>,
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

>>>>> "Ming" == Ming Lin <mlin@kernel.org> writes:

Ming,

Ming> I also prefer using MAX_BIO_SECTORS.  Otherwise, we may have non
Ming> page size aligned splits.

This does not matter for write same and discard since there is only a
single logical block of payload. Also, given limitations in SATA we're
always issuing 2GB-32KB sized discards. Rounding those down to an even
1GB would impact performance.

I am sympathetic to wanting to issue I/Os that are aligned to powers of
two. But for most devices this matters little since the additional cost
is limited to misaligned head and tail blocks.

One thing that may be worth considering is switching bi_size from bytes
to blocks for REQ_FS. That would give us some headroom without
increasing bi_size beyond 32 bits. But I'm not entirely sure it's worth
the pain.

-- 
Martin K. Petersen	Oracle Linux Engineering
