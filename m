Return-Path: <martin.petersen@oracle.com>
To: Mike Snitzer <snitzer@redhat.com>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20150809064128.GB2436@infradead.org>
	<1439103347.7880.3.camel@hasee> <20150809070128.GA25739@infradead.org>
	<1439104707.7880.8.camel@hasee> <20150810150216.GA22719@redhat.com>
	<yq1si7rgllc.fsf@sermon.lab.mkp.net> <1439230696.26458.6.camel@ssi>
	<yq1bneeh9df.fsf@sermon.lab.mkp.net>
	<20150811024154.GA26351@redhat.com>
	<yq17fp1hgm0.fsf@sermon.lab.mkp.net>
	<20150811174717.GA30439@redhat.com>
Date: Tue, 11 Aug 2015 14:01:45 -0400
In-Reply-To: <20150811174717.GA30439@redhat.com> (Mike Snitzer's message of
	"Tue, 11 Aug 2015 13:47:17 -0400")
Message-ID: <yq1wpx1g0vq.fsf@sermon.lab.mkp.net>
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
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v5 01/11] block: make
	generic_make_request handle arbitrarily sized bios
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

Mike> That is the benefit.  And when coupled with the new default
Mike> max_discard of 64K (pending change from Jens for 4.3) this 2GB
Mike> upper limit really isn't such a big deal.  Unless I'm missing
Mike> something...

2GB is fine for current SATA due to the stupid range descriptors. But
there are some changes in the pipeline to support descriptors with
bigger ranges so that will change.

However, we currently do 4GB discards on SCSI so the proposed cap will
cut that in half. I'm OK with that as an interim solution. though.

But I'm a bit concerned about what might be lurking in dm thinp if you
trip over partial blocks like in Ming's example...

-- 
Martin K. Petersen	Oracle Linux Engineering
