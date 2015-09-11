Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F12DB105570E
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id AD9C62BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id pYoshgZ8EvHJ for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 805BE2BEE3E
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4rTKFogp_EtA for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:05 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 19F8F2BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:03 +0200 (CEST)
Resent-Message-ID: <20150911132003.GR3436@soda.linbit>
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Ming Lin <mlin@kernel.org>
Message-ID: <20150808003057.GA1811@kmo-pixel>
References: <20150731192337.GA8907@redhat.com>
	<CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com>
	<1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
	<1438581502.26596.24.camel@hasee> <20150804113626.GA12682@lst.de>
	<1438754604.29731.31.camel@hasee> <20150807073001.GA17485@lst.de>
	<1438990806.24452.8.camel@ssi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438990806.24452.8.camel@ssi>
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>, dm-devel@redhat.com,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>, Nitin Gupta <ngupta@vflare.org>,
	Ming Lin <ming.l@ssi.samsung.com>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Dongsu Park <dpark@posteo.net>,
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
Date: Fri, 11 Sep 2015 13:20:07 -0000

On Fri, Aug 07, 2015 at 04:40:06PM -0700, Ming Lin wrote:
> 
> On Fri, 2015-08-07 at 09:30 +0200, Christoph Hellwig wrote:
> > I'm for solution 3:
> > 
> >  - keep blk_bio_{discard,write_same}_split, but ensure we never built
> >    a > 4GB bio in blkdev_issue_{discard,write_same}.
> 
> This has problem as I mentioned in solution 1.
> We need to also make sure max discard size is of proper granularity.
> See below example.
> 
>       4G: 8388608 sectors
> UINT_MAX: 8388607 sectors
> 
> dm-thinp block size = default discard granularity = 128 sectors
> 
> blkdev_issue_discard(sector=0, nr_sectors=8388608)
> 
> 1. Only ensure bi_size not overflow
> 
> It doesn't work.
> 
> [start_sector, end_sector]
> [0, 8388607]
>     [0, 8388606], then dm-thinp splits it to 2 bios
>         [0, 8388479]
>         [8388480, 8388606] ---> this has problem in process_discard_bio(),
>                                 because the discard size(7 sectors) covers less than a block(128 sectors)
>     [8388607, 8388607] ---> same problem 
> 
> 2. Ensure bi_size not overflow and max discard size is of proper granularity

Ideally we'd get upper layers out of the business of knowing about the queue
limits at all - that was the point of the patch series, after all.

Instead of using UINT_MAX, would it work to just make the max 1 << 31 sectors?
