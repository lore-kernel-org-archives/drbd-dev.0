Return-Path: <martin.petersen@oracle.com>
To: Mike Snitzer <snitzer@redhat.com>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <yq18u9liwhj.fsf@sermon.lab.mkp.net>
	<1439099990.7880.0.camel@hasee> <20150809064128.GB2436@infradead.org>
	<1439103347.7880.3.camel@hasee> <20150809070128.GA25739@infradead.org>
	<1439104707.7880.8.camel@hasee> <20150810150216.GA22719@redhat.com>
	<yq1si7rgllc.fsf@sermon.lab.mkp.net> <1439230696.26458.6.camel@ssi>
	<yq1bneeh9df.fsf@sermon.lab.mkp.net>
	<20150811024154.GA26351@redhat.com>
Date: Tue, 11 Aug 2015 13:36:39 -0400
In-Reply-To: <20150811024154.GA26351@redhat.com> (Mike Snitzer's message of
	"Mon, 10 Aug 2015 22:41:55 -0400")
Message-ID: <yq17fp1hgm0.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Ming Lei <ming.lei@canonical.com>,
	device-mapper development <dm-devel@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Ming Lin <ming.l@ssi.samsung.com>,
	Oleg Drokin <oleg.drokin@intel.com>,
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

>>>>> "Mike" == Mike Snitzer <snitzer@redhat.com> writes:

Mike> DM-thinp processes discards internally before it passes them down
Mike> (if configured to do so).  If a discard is smaller than the
Mike> granularity of a thinp block (whose size is configurable) or if
Mike> the start and end of the discard's extent is misaligned (relative
Mike> to the thinp blocks mapped to the logical extent) then the discard
Mike> won't actually discard partial thinp blocks.

That's fine. You can throw away anything you don't like as long as
discard_zeroes_data=0.

But I don't understand why having an artificial cap at 2GB fixes
things. Other than making it less likely for you to receive a runt by
virtue of being aligned to a power of two.

-- 
Martin K. Petersen	Oracle Linux Engineering
