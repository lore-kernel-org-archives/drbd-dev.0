Return-Path: <mlin@kernel.org>
Message-ID: <1439326568.19144.11.camel@ssi>
From: Ming Lin <mlin@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Tue, 11 Aug 2015 13:56:08 -0700
In-Reply-To: <yq1si7pg0px.fsf@sermon.lab.mkp.net>
References: <1439099990.7880.0.camel@hasee>
	<20150809064128.GB2436@infradead.org> <1439103347.7880.3.camel@hasee>
	<20150809070128.GA25739@infradead.org> <1439104707.7880.8.camel@hasee>
	<20150810150216.GA22719@redhat.com>
	<yq1si7rgllc.fsf@sermon.lab.mkp.net>
	<1439230696.26458.6.camel@ssi> <yq1bneeh9df.fsf@sermon.lab.mkp.net>
	<20150811024154.GA26351@redhat.com> <20150811033851.GA28533@kmo-pixel>
	<yq11tf9hg01.fsf@sermon.lab.mkp.net>
	<yq1si7pg0px.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Andreas, Mike Snitzer <snitzer@redhat.com>,
	Ming Lei <ming.lei@canonical.com>, lkml <linux-kernel@vger.kernel.org>,
	device-mapper development <dm-devel@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Minchan Kim <minchan@kernel.org>, Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>, Philip,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Ming Lin <ming.l@ssi.samsung.com>,
	Oleg Drokin <oleg.drokin@intel.com>,
	Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	axboe@fb.com, Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Kosina <jkosina@suse.cz>, Al,
	Jim Paris <jim@jtan.com>, Jiri, Joe Thornber <ejt@redhat.com>,
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

On Tue, 2015-08-11 at 14:05 -0400, Martin K. Petersen wrote:
> >>>>> "Martin" == Martin K Petersen <martin.petersen@oracle.com> writes:
> 
> Martin> I agree except I really don't want to lop off anything unless
> Martin> the device locks up if we send it partial blocks. There was an
> Martin> array that had problems a while back but I believe they have
> Martin> been fixed.
> 
> Oh, and there are several arrays out there that have allocation units
> that are not powers of two. *sigh*

Do you still agree we cap discard to 2G as an interim solution?
https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/commit/?h=block-generic-req&id=39d2f5f

If OK, I'll send out new version asking Jens to apply.


