Return-Path: <martin.petersen@oracle.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20150811033851.GA28533@kmo-pixel> (Kent Overstreet's message of
	"Mon, 10 Aug 2015 19:38:51 -0800")
References: <1439099990.7880.0.camel@hasee>
	<20150809064128.GB2436@infradead.org> <1439103347.7880.3.camel@hasee>
	<20150809070128.GA25739@infradead.org> <1439104707.7880.8.camel@hasee>
	<20150810150216.GA22719@redhat.com>
	<yq1si7rgllc.fsf@sermon.lab.mkp.net> <1439230696.26458.6.camel@ssi>
	<yq1bneeh9df.fsf@sermon.lab.mkp.net>
	<20150811024154.GA26351@redhat.com> <20150811033851.GA28533@kmo-pixel>
Date: Tue, 11 Aug 2015 13:49:50 -0400
Message-ID: <yq11tf9hg01.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@canonical.com>,
	device-mapper development <dm-devel@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>, Nitin Gupta <ngupta@vflare.org>,
	Ming Lin <ming.l@ssi.samsung.com>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Ming Lin <mlin@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, axboe@fb.com,
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

>>>>> "Kent" == Kent Overstreet <kent.overstreet@gmail.com> writes:

Kent> This kind of logic really doesn't belong in dm

Well it does in this case since the thinp personality actually
provisions and unprovisions space.

But there is a difference between what dm thinp acts on for its own
internal provisioning purposes and what it passes down the stack. I am
really against dropping information anywhere along the path. We don't
round off read/write requests either.

The queue limits were meant as hints to mkfs.* so that on-disk data
structures could be laid out in an aligned and storage friendly way. I
never intended for the hints to affect runtime behavior.

Kent> IMO though it belongs in the driver - if a discard needs to be
Kent> dropped because it's too small and the hardware can't do it, that
Kent> should be the driver's responsibility.

I agree except I really don't want to lop off anything unless the device
locks up if we send it partial blocks. There was an array that had
problems a while back but I believe they have been fixed.

The fundamental premise should be that we pass as comprehensive
information as we can. And the device can then decide to ignore all or
parts of the request. That's fundamentally how things work at the
protocol level in both SCSI and SATA. I don't see any reason why the
Linux I/O stack should behave in a different manner.

-- 
Martin K. Petersen	Oracle Linux Engineering
