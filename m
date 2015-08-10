Return-Path: <mlin@kernel.org>
Message-ID: <1439230696.26458.6.camel@ssi>
From: Ming Lin <mlin@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Mon, 10 Aug 2015 11:18:16 -0700
In-Reply-To: <yq1si7rgllc.fsf@sermon.lab.mkp.net>
References: <CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com> <1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
	<yq18u9liwhj.fsf@sermon.lab.mkp.net>
	<1439099990.7880.0.camel@hasee> <20150809064128.GB2436@infradead.org>
	<1439103347.7880.3.camel@hasee> <20150809070128.GA25739@infradead.org>
	<1439104707.7880.8.camel@hasee> <20150810150216.GA22719@redhat.com>
	<yq1si7rgllc.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Mike Snitzer <snitzer@redhat.com>, Lei <ming.lei@canonical.com>,
	device-mapper development <dm-devel@redhat.com>, Alasdair,
	Christoph Hellwig <hch@lst.de>, Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>, Philip,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Ming Lin <ming.l@ssi.samsung.com>,
	Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	axboe@fb.com, Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Ming, Minchan Kim <minchan@kernel.org>,
	Joe Thornber <ejt@redhat.com>, Dongsu Park <dpark@posteo.net>,
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

On Mon, 2015-08-10 at 12:22 -0400, Martin K. Petersen wrote:
> >>>>> "Mike" == Mike Snitzer <snitzer@redhat.com> writes:
> 
> Mike> Shouldn't we also be using MAX_BIO_SECTORS in
> Mike> blkdev_issue_write_same (instead of UINT_MAX >> 9)?
> 
> The granularity of WRITE SAME is always 1 logical block and there is no
> reason to round it down to the next power of two.
> 
> +/*
> + * Ensure that max discard sectors doesn't overflow bi_size and hopefully
> + * it is of the proper granularity as long as the granularity is a power
> + * of two.
> + */
> +#define MAX_DISCARD_SECTORS ((1U << 31) >> 9)
> +
> 
> That's fine for SATA since we're already capping at 2TB minus change.
> But it means we'll be capping unnecessarily on SCSI. And larger range
> counts are impending in SATA as well.
> 
> So this goes back to my original comment: The only place there can be a
> discard granularity is for SCSI UNMAP. And consequently, we should only
> enforce alignment and granularity when that code path is taken in sd.c.
> 
> I'm OK with Ming's patch series in general. Let's leave the discard cap
> at UINT_MAX and I'll twiddle the rest in SCSI.

Just to make sure I didn't misunderstand it.

Did you mean still use (UINT_MAX >> 9) in blkdev_issue_discard()?

	req_sects = min_t(sector_t, nr_sects, UINT_MAX >> 9);
instead of:
	req_sects = min_t(sector_t, nr_sects, MAX_DISCARD_SECTORS);

But that doesn't work for dm-thinp. See Kent's suggestion to use 1<<31.
https://www.redhat.com/archives/dm-devel/2015-August/msg00053.html

> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> 

Thanks!


