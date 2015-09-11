Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1388E105573E
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 0C0792BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:20 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id CeocdzPPk1pW for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DDCB02BEE40
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:19 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jTrZTK9Cj6mK for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:19 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 4B9312BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:19 +0200 (CEST)
Resent-Message-ID: <20150911132018.GV3436@soda.linbit>
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <20150811033851.GA28533@kmo-pixel>
References: <1439099990.7880.0.camel@hasee>
	<20150809064128.GB2436@infradead.org>
	<1439103347.7880.3.camel@hasee>
	<20150809070128.GA25739@infradead.org>
	<1439104707.7880.8.camel@hasee> <20150810150216.GA22719@redhat.com>
	<yq1si7rgllc.fsf@sermon.lab.mkp.net> <1439230696.26458.6.camel@ssi>
	<yq1bneeh9df.fsf@sermon.lab.mkp.net>
	<20150811024154.GA26351@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150811024154.GA26351@redhat.com>
Cc: Ming Lei <ming.lei@canonical.com>,
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
Date: Fri, 11 Sep 2015 13:22:07 -0000

On Mon, Aug 10, 2015 at 10:41:55PM -0400, Mike Snitzer wrote:
> On Mon, Aug 10 2015 at 10:00pm -0400,
> Martin K. Petersen <martin.petersen@oracle.com> wrote:
> 
> > >>>>> "Ming" == Ming Lin <mlin@kernel.org> writes:
> > 
> > Ming> Did you mean still use (UINT_MAX >> 9) in blkdev_issue_discard()?
> > 
> > Ming> But that doesn't work for dm-thinp. See Kent's suggestion to use
> > Ming> 1<<31.
> > 
> > I'm not sure why things are not working for dm-thinp. Presumably Kent's
> > code would split the discard at a granularity boundary so why would that
> > cause problems for dm?
> 
> DM-thinp processes discards internally before it passes them down (if
> configured to do so).  If a discard is smaller than the granularity of a
> thinp block (whose size is configurable) or if the start and end of the
> discard's extent is misaligned (relative to the thinp blocks mapped to
> the logical extent) then the discard won't actually discard partial
> thinp blocks.

This kind of logic really doesn't belong in dm - if it's needed, it really
belongs in bio_split() (which is supposed to work correctly for discards - so if
it is needed, then bio_split() needs fixing...)

IMO though it belongs in the driver - if a discard needs to be dropped because
it's too small and the hardware can't do it, that should be the driver's
responsibility.
