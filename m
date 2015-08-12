Return-Path: <martin.petersen@oracle.com>
To: Ming Lin <mlin@kernel.org>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1439099990.7880.0.camel@hasee>
	<20150809064128.GB2436@infradead.org> <1439103347.7880.3.camel@hasee>
	<20150809070128.GA25739@infradead.org> <1439104707.7880.8.camel@hasee>
	<20150810150216.GA22719@redhat.com>
	<yq1si7rgllc.fsf@sermon.lab.mkp.net> <1439230696.26458.6.camel@ssi>
	<yq1bneeh9df.fsf@sermon.lab.mkp.net>
	<20150811024154.GA26351@redhat.com> <20150811033851.GA28533@kmo-pixel>
	<yq11tf9hg01.fsf@sermon.lab.mkp.net>
	<yq1si7pg0px.fsf@sermon.lab.mkp.net> <1439326568.19144.11.camel@ssi>
Date: Tue, 11 Aug 2015 20:24:40 -0400
In-Reply-To: <1439326568.19144.11.camel@ssi> (Ming Lin's message of "Tue, 11
	Aug 2015 13:56:08 -0700")
Message-ID: <yq137zpfj5j.fsf@sermon.lab.mkp.net>
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

Ming> Do you still agree we cap discard to 2G as an interim solution?

I can live with the 2G cap for 4.3 but would like to see it fixed
properly in 4.4.

-- 
Martin K. Petersen	Oracle Linux Engineering
